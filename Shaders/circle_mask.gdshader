shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 1.0) = 0.4;
uniform float size_ratio : hint_range(0.0, 3.0) = 1.0;
uniform float location_x : hint_range(-1.0, 2.0) = 0.5;
uniform float location_y : hint_range(-1.0, 2.0) = 0.5;
uniform bool invert_mask = false;

void fragment() {
	float ratio = 1.0 / size_ratio;
	float dist = distance(vec2(location_x, location_y), vec2(mix(0.5, UV.x, ratio), UV.y));
	vec4 orig_color = texture(TEXTURE, UV);
	COLOR.rgb = orig_color.rgb;
	float alpha_total = (1.0 - step(circle_size, dist));
	if (invert_mask == true) {
		alpha_total = 1.0 - alpha_total;
	}
	COLOR.a = alpha_total * orig_color.a;
}