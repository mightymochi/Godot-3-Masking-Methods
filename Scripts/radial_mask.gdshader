//Adapted from https://godotshaders.com/shader/radial-progress-shader/
shader_type canvas_item;

const float PI = 3.141592656;

uniform float fill_ratio:hint_range(0., 1.) = 1.;
uniform float start_angle:hint_range(0., 360.) = 0.;
uniform float max_angle:hint_range(0., 360.) = 360.;
uniform bool invert_fill = false;
uniform bool reflect_x = false;
uniform bool reflect_y = false;
uniform float offset_x:hint_range(-5., 5.) = 0.;
uniform float offset_y:hint_range(-5., 5.) = 0.;

mat2 tex_rotate(float _angle){
	return mat2(vec2(cos(_angle), -sin(_angle)), vec2(sin(_angle), cos(_angle)));
}

void fragment() {
	vec2 offset = vec2(offset_x, offset_y);
	float fill_angle = radians(fill_ratio * max_angle);
	vec2 uv = ((UV * 2.0 - 1.0) + offset) * tex_rotate(-radians(start_angle));
	if (reflect_x) {
		uv *= mat2(vec2(-1.0, 0.0), vec2(0.0, 1.0));
	}
	if (reflect_y) {
		uv *= mat2(vec2(1.0, 0.0), vec2(0.0, -1.0));
	}
	if ((!invert_fill && atan(uv.x, uv.y) + PI < fill_angle) || (invert_fill && atan(uv.x, uv.y) + PI > fill_angle)) {
		COLOR = texture(TEXTURE, UV);
	} else {
		COLOR.a = 0.0;
	}
}