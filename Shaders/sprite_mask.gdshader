shader_type canvas_item;

uniform sampler2D mask_texture;
uniform float rect_size : hint_range(0.0, 5.0) = 1.0;
uniform float ratio_width : hint_range(0.0, 3.0) = 1.0;
uniform float ratio_height : hint_range(0.0, 3.0) = 1.0;
uniform float location_x : hint_range(-1.0, 2.0) = 0.0;
uniform float location_y : hint_range(-1.0, 2.0) = 0.0;
uniform bool invert_mask = false;

void fragment() {
	float ratio = TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y;
    vec4 colour = texture(TEXTURE, UV);
	float alpha_total = texture(mask_texture, (UV - vec2(location_x,location_y)) / vec2(ratio_width,ratio_height) / rect_size).a;
	if (invert_mask == true) {
		alpha_total = 1.0 - alpha_total;
	}
    colour.a *= alpha_total;
    COLOR = colour;
}