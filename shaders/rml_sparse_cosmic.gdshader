shader_type canvas_item;

uniform sampler2D mask_tex;

//// Hash without Sine
//// MIT License...
//// Copyright (c)2014 David Hoskins.
//float noise(vec2 p)
//{
	//vec3 p3  = fract(vec3(p.xyx) * .1031);
    //p3 += dot(p3, p3.yzx + 33.33);
    //return fract((p3.x + p3.y) * p3.z);
//}
float noise(vec2 p) {
    return fract(43758.5453123 * sin(dot(p, vec2(12.9898, 78.233))));
}

void fragment() {
	float t = TIME * 0.2;
	vec3 c = vec3(noise(vec2(UV.x * 5.0 + t, 0)), noise(vec2(0, UV.y * 5.0 + t)), UV.y);
	float mask_a = texture(mask_tex, UV).a;
	COLOR = vec4(c, mask_a);
}
