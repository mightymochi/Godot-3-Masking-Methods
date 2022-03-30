shader_type canvas_item;

uniform float the_size : hint_range(0.0, 1.0) = 0.5;
uniform float wipe_direction = 1.0;
uniform bool wipe_axis_y = false;

void fragment() {
	vec4 orig_color = texture(TEXTURE, UV);
	COLOR.rgb = orig_color.rgb;
	float which_axis = UV.x;
	if (wipe_axis_y == true) {
		which_axis = UV.y;
	} 
	COLOR.a = (1.0 - step(the_size * wipe_direction, which_axis * wipe_direction)) * orig_color.a;
}