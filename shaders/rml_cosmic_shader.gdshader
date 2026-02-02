shader_type canvas_item;

// frisk256 @ Shadertoy
// https://www.shadertoy.com/view/t3dfRr

#define r (1.0 / SCREEN_PIXEL_SIZE).xy

float random(vec2 p) {
    return fract(p.x * (fract(p.y * 0.15743) + 2.42) * 2.523);
}

float random(vec4 p) {
    return random(vec2(random(p.xy),random(p.zw)) * 3.74 + 4.34);
}

vec3 randvec(vec3 p) {
    vec3 g = vec3(
    random(vec4(p,1.)),
    random(vec4(p,2.)),
    random(vec4(p,3.))
    );
    g -= 0.5;
    g /= length(g);
    return g;
}

float noise(vec3 p) {
    //float s = 7.;
    vec3 k = fract(p);
    vec3 q = floor(p);
    vec3 corn000 = q + vec3(0,0,0);
    vec3 corn001 = q + vec3(0,0,1);
    vec3 corn010 = q + vec3(0,1,0);
    vec3 corn011 = q + vec3(0,1,1);
    vec3 corn100 = q + vec3(1,0,0);
    vec3 corn101 = q + vec3(1,0,1);
    vec3 corn110 = q + vec3(1,1,0);
    vec3 corn111 = q + vec3(1,1,1);
    vec3 grad000 = randvec(corn000);
    vec3 grad001 = randvec(corn001);
    vec3 grad010 = randvec(corn010);
    vec3 grad011 = randvec(corn011);
    vec3 grad100 = randvec(corn100);
    vec3 grad101 = randvec(corn101);
    vec3 grad110 = randvec(corn110);
    vec3 grad111 = randvec(corn111);
    float val000 = dot(k - vec3(0,0,0),grad000);
    float val001 = dot(k - vec3(0,0,1),grad001);
    float val010 = dot(k - vec3(0,1,0),grad010);
    float val011 = dot(k - vec3(0,1,1),grad011);
    float val100 = dot(k - vec3(1,0,0),grad100);
    float val101 = dot(k - vec3(1,0,1),grad101);
    float val110 = dot(k - vec3(1,1,0),grad110);
    float val111 = dot(k - vec3(1,1,1),grad111);
    vec3 f = k * k * (3. - 2. * k);
    return
    mix(mix(mix(val000,
                val001,f.z),
            mix(val010,
                val011,f.z),f.y),
        mix(mix(val100,
                val101,f.z),
            mix(val110,
                val111,f.z),f.y),f.x);
}

vec3 grad(vec3 p,float x) {
    float epsilon = 0.001;
    vec3 q = vec3(
    noise(p - vec2(1,0).xyy * epsilon),
    noise(p - vec2(1,0).yxy * epsilon),
    noise(p - vec2(1,0).yyx * epsilon));
    return (x - q) / epsilon;
}

vec3 value(vec3 p,float x) {
    vec3 g = p;
    vec3 t = vec3(0);
    float q = 1.;
    float w = (1. - x / 24.) * 5.;
    for(int n = 0; n < 5; n++) {
        p += 73.4;
        float v = noise(p);
        t += vec3(1.17,0.9,1.2) * v / q * clamp(w,0.,1.);
        p *= 2.1;
        q *= 1.5;
        w -= 1.;
        if(w < 0.) {
            break;
        }
    }
    t = pow(t,vec3(0.9,1.2,0.7));
    p = g * 25.;
    t += min(pow(noise(p * 2.5) * 1.9,8.) * (length(t) - 0.1) * 0.7,7.) * pow(vec3(1.3,1.1,0.5),vec3(2.));
    t = max(t,0.);
    t = 1. - 1. / (t * 4. + 1.);
    t *= t * 1.2;
    t -= 0.2;
    t = max(t,0.);
    return t * 1.6;
}

void fragment() {
    vec2 mUV = (UV*r + UV*r - r) / sqrt(r.x * r.y) * 0.5 * 3.0;
    COLOR = vec4(0,0,0,1);
    float s = TIME * 0.4;
    vec3 h = vec3(1);
    for(float i = 1.; i < 24.; i++) {
        float q = i - fract(s);
        COLOR.xyz += max(value(vec3(mUV * q + TIME * 0.5,i + floor(s)) * 0.5,q) * pow(1. - q / 23.,2.) / h - 0.15 / length(vec3(mUV * q,q * 0.4)),0.);
        h += length(COLOR.xyz) * 0.4;
    }
    COLOR = 1. - 1. / (COLOR * 1.7 + 1.);
    COLOR *= COLOR * 2.5;
	vec4 mc = texture(TEXTURE, UV);
	COLOR.a = mc.a;
}
