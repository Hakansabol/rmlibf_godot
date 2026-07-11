# Godot CRT Shader

An authentic, highly-detailed CRT monitor shader for Godot 4.x that simulates the look of classic cathode ray tube displays with advanced effects.

## Features

- **Screen Curvature** - Realistic barrel distortion with overscan compensation
- **Advanced Flicker System** - Multi-frequency flicker with randomness for authentic CRT behavior
- **Moving Scanlines** - Animated horizontal lines that scroll across the screen
- **Glitch Lines** - Horizontal static lines simulating bad cable connections
- **Rolling Distortion** - Vertical hold issues like old TVs
- **Chromatic Aberration** - Color fringing at edges like real CRTs
- **Dynamic TV Noise** - Randomly changing static/grain
- **Color Enhancement** - Adjustable brightness, contrast, and saturation
- **Vignetting** - Subtle darkening at screen edges

## Installation

1. Copy `crt_shader.gdshader` to your Godot project
2. Apply it to a ColorRect or CanvasLayer that covers your scene
3. Set the shader material on the node

## Usage

Add a ColorRect or CanvasLayer to cover your entire viewport:

```gdscript
# Create a full-screen overlay
var crt_overlay = ColorRect.new()
crt_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)

# Load and apply the shader
var shader_material = ShaderMaterial.new()
shader_material.shader = load("res://crt_shader.gdshader")
crt_overlay.material = shader_material
```

## Parameters

### Screen Shape
- **overscan** (0.9-1.2): Compensates for curvature by scaling image - default: 1.05

### Flicker System
- **flicker_intensity** (0.0-0.3): How much screen flickers - default: 0.05
- **flicker_speed** (0.1-10.0): Base flicker rate - default: 2.0
- **flicker_randomness** (0.0-1.0): Mix of steady vs random flicker - default: 0.5
- **flicker_frequency** (0.5-20.0): Multiple frequency layers - default: 8.0

### Glitch Effects
- **glitch_frequency** (0.0003-2.0): How often glitch lines appear - default: 0.05
- **glitch_line_count** (1-5): Number of simultaneous glitch lines - default: 3
- **glitch_line_duration_min** (0.1-1.0): Minimum glitch duration - default: 0.2
- **glitch_line_duration_max** (0.1-1.0): Maximum glitch duration - default: 0.8
- **glitch_line_delay_max** (0.0-1.0): Max delay between glitches - default: 0.5
- **glitch_line_intensity** (0.0-1.0): Strength of glitch effect - default: 0.8
- **glitch_line_thickness** (0.001-0.01): Width of glitch lines - default: 0.003

### Rolling Distortion
- **rolling_distortion_speed** (0.0-2.0): Speed of vertical roll - default: 0.1
- **rolling_distortion_amount** (0.0-0.1): Strength of distortion - default: 0.02
- **rolling_distortion_width** (0.01-0.2): Width of distorted band - default: 0.05

### Scanlines
- **time_speed** (0.1-5.0): Controls animation speed - default: 1.0
- **scanline_speed** (-2.0-2.0): How fast scanlines move - default: 0.02
- **scanline_intensity** (0.0-1.0): Visibility of scanlines - default: 0.15
- **scanline_count** (200-800): Number of scanlines - default: 450

### Visual Effects
- **noise_amount** (0.0-0.3): TV static intensity - default: 0.08
- **distortion_strength** (0.0-0.15): Screen ripple effect - default: 0.05
- **chromatic_aberration** (0.0-5.0): Color separation - default: 1.5

### Color Adjustment
- **brightness** (0.5-1.5): Overall brightness - default: 1.1
- **contrast** (0.5-2.0): Color contrast - default: 1.2
- **saturation** (0.0-2.0): Color saturation - default: 1.1

## Tips

### For subtle, clean CRT look:
- Reduce `flicker_intensity` to 0.02 or lower
- Lower `glitch_frequency` to 0.01 for rare glitches
- Set `noise_amount` to 0.03 for minimal grain
- Use higher `scanline_count` (600+) for sharper lines

### For broken, glitchy TV:
- Increase `glitch_frequency` to 0.5+ for frequent glitches
- Raise `glitch_line_count` to 5
- Boost `rolling_distortion_speed` and `rolling_distortion_amount`
- Increase `flicker_intensity` to 0.2+

### For authentic 1980s monitor:
- Keep defaults, they're calibrated for authentic feel
- Adjust `overscan` to 1.08 for period-accurate curvature
- Use `scanline_count` around 400-500

## Performance

All effects are optimized for real-time rendering. On modern hardware, this shader should run at 60fps+ even at 1080p. The glitch line system uses efficient conditional checks to minimize GPU load.

## Compatibility

- Godot 4.x (uses canvas_item shader)
- Works with 2D and UI elements
- No external dependencies

## License

MIT License - Free to use in any project, commercial or personal.

## Credits

Created for the RetroEDIT project - a writer's sanctuary with authentic retro aesthetics.

Special thanks to the Godot community for shader development resources.
