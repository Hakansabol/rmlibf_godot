shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float overscan : hint_range(0.9, 1.2) = 1.05;
uniform float flicker_intensity : hint_range(0.0, 0.3) = 0.05;
uniform float flicker_speed : hint_range(0.1, 10.0) = 2.0;
uniform float flicker_randomness : hint_range(0.0, 1.0) = 0.5;
uniform float flicker_frequency : hint_range(0.5, 20.0) = 8.0;
uniform float glitch_frequency : hint_range(0.0003, 2.0) = 0.05;
uniform int glitch_line_count : hint_range(1, 5) = 3;
uniform float glitch_line_duration_min : hint_range(0.1, 1.0) = 0.2;
uniform float glitch_line_duration_max : hint_range(0.1, 1.0) = 0.8;
uniform float glitch_line_delay_max : hint_range(0.0, 1.0) = 0.5;
uniform float glitch_line_intensity : hint_range(0.0, 1.0) = 0.8;
uniform float glitch_line_thickness : hint_range(0.001, 0.01) = 0.003;
uniform float rolling_distortion_speed : hint_range(0.0, 2.0) = 0.1;
uniform float rolling_distortion_amount : hint_range(0.0, 0.1) = 0.02;
uniform float rolling_distortion_width : hint_range(0.01, 0.2) = 0.05;
uniform float time_speed : hint_range(0.1, 5.0) = 1.0;
uniform float scanline_speed : hint_range(-2.0, 2.0) = 0.02;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.15;
uniform float scanline_count : hint_range(200.0, 800.0) = 450.0;
uniform float noise_amount : hint_range(0.0, 0.3) = 0.08;
uniform float distortion_strength : hint_range(0.0, 0.15) = 0.05;
uniform float chromatic_aberration : hint_range(0.0, 5.0) = 1.5;
uniform float brightness : hint_range(0.5, 1.5) = 1.1;
uniform float contrast : hint_range(0.5, 2.0) = 1.2;
uniform float saturation : hint_range(0.0, 2.0) = 1.1;

// Random noise function
float random(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

// Check if a glitch line should be visible at this position and time
bool is_glitch_line_active(float y_pos, float time, int line_index) {
    // Generate unique seed for this line
    float line_seed = float(line_index) * 17.3;
    
    // Calculate when this line group starts appearing (based on frequency)
    float group_trigger_time = floor(time * glitch_frequency) / glitch_frequency;
    float time_since_trigger = time - group_trigger_time;
    
    // Individual line delay (0 to delay_max)
    float line_delay = random(vec2(group_trigger_time, line_seed)) * glitch_line_delay_max;
    
    // Individual line duration
    float line_duration = mix(glitch_line_duration_min, glitch_line_duration_max,
                               random(vec2(group_trigger_time + 0.5, line_seed)));
    
    // Check if this line should be visible now
    bool is_in_time_window = time_since_trigger >= line_delay &&
                              time_since_trigger < (line_delay + line_duration);
    
    if (!is_in_time_window) return false;
    
    // Random y position for this line (based on group trigger time and line index)
    float line_y = random(vec2(group_trigger_time, line_seed * 2.0));
    
    // Check if current pixel is within this glitch line
    return abs(y_pos - line_y) < glitch_line_thickness;
}

// CRT screen curvature with overscan compensation
vec2 curve_screen(vec2 uv) {
    // Apply overscan first to scale up the image
    uv = (uv - 0.5) * overscan + 0.5;
    
    uv = uv * 2.0 - 1.0;
    vec2 offset = abs(uv.yx) / vec2(6.0, 4.0);
    uv = uv + uv * offset * offset;
    uv = uv * 0.5 + 0.5;
    return uv;
}

void fragment() {
    vec2 curved_uv = curve_screen(UV);
    
    // Check if we're outside the curved screen bounds
    bool out_of_bounds = curved_uv.x < 0.0 || curved_uv.x > 1.0 || curved_uv.y < 0.0 || curved_uv.y > 1.0;
    
    vec3 color = vec3(0.0);
    
    if (!out_of_bounds) {
        // Rolling distortion (vertical hold issue)
        float roll_position = fract(TIME * rolling_distortion_speed);
        float distance_from_roll = abs(curved_uv.y - roll_position);
        float roll_influence = smoothstep(rolling_distortion_width, 0.0, distance_from_roll);
        curved_uv.x += sin(distance_from_roll * 50.0) * rolling_distortion_amount * roll_influence;
        
        // Add slight distortion ripple
        float distortion = sin(curved_uv.y * 50.0 + TIME * time_speed) * distortion_strength * 0.001;
        curved_uv.x += distortion;
        
        // Chromatic aberration
        float r = texture(screen_texture, curved_uv + vec2(chromatic_aberration * 0.001, 0.0)).r;
        float g = texture(screen_texture, curved_uv).g;
        float b = texture(screen_texture, curved_uv - vec2(chromatic_aberration * 0.001, 0.0)).b;
        
        color = vec3(r, g, b);
        
        // Moving scanlines
        float scanline_pos = curved_uv.y * scanline_count + TIME * scanline_speed * 100.0;
        float scanlines = sin(scanline_pos * 3.14159) * scanline_intensity;
        scanlines = clamp(scanlines, -1.0, 1.0);
        
        // Apply scanlines
        color *= (1.0 + scanlines * 0.3);
        
        // Random noise that changes over time
        float noise = random(curved_uv + fract(TIME * time_speed * 0.1)) * noise_amount;
        color += noise;
        
        // Advanced CRT flicker effect
        float base_flicker = sin(TIME * flicker_speed * 3.14159) * (1.0 - flicker_randomness);
        
        // Multiple frequency components for realistic flicker
        float freq1 = sin(TIME * flicker_frequency * 3.14159) * 0.6;
        float freq2 = sin(TIME * flicker_frequency * 2.3 * 3.14159) * 0.3;
        float freq3 = sin(TIME * flicker_frequency * 0.7 * 3.14159) * 0.1;
        
        // Random component that changes over time
        float random_flicker = random(vec2(floor(TIME * flicker_frequency * 2.0))) * flicker_randomness;
        float random_spikes = random(vec2(TIME * flicker_frequency * 5.0)) * flicker_randomness * 0.3;
        
        // Combine all flicker components
        float flicker = 1.0 + (base_flicker + freq1 + freq2 + freq3 + random_flicker + random_spikes) * flicker_intensity;
        color *= flicker;
        
        // Horizontal glitch lines (bad cable connection effect)
        bool has_glitch = false;
        for (int i = 0; i < 5; i++) {
            if (i >= glitch_line_count) break;
            if (is_glitch_line_active(curved_uv.y, TIME, i)) {
                has_glitch = true;
                break;
            }
        }
        
        if (has_glitch) {
            // Black and white static for glitch lines
            float static_noise = random(curved_uv * 1000.0 + TIME * 50.0);
            color = mix(color, vec3(static_noise), glitch_line_intensity);
        }
        
        // Brightness and contrast
        color = ((color - 0.5) * contrast + 0.5) * brightness;
        
        // Saturation
        float gray = dot(color, vec3(0.299, 0.587, 0.114));
        color = mix(vec3(gray), color, saturation);
        
        // Subtle vignette
        vec2 center = curved_uv - 0.5;
        float vignette = 1.0 - dot(center, center) * 0.5;
        color *= vignette;
    }
    
    COLOR = vec4(color, 1.0);
}
