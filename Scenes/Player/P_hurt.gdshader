shader_type canvas_item;

uniform float _r;
uniform float _g;
uniform float _b;
uniform bool flash = false;
uniform float mix_weight = 0.7;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (flash) {
		vec3 flash_color = vec3(_r, _g, _b);
		vec3 flashed_texture_rgb = mix(texture_color.rbg, flash_color, mix_weight);
		COLOR = vec4(flashed_texture_rgb, texture_color.a);
	}
	else {
		COLOR = texture_color;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
