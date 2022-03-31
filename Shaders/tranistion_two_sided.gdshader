//Adapted from GDQuest transition shader https://github.com/GDQuest/godot-demos/blob/master/2018/09-20-shaders/shaders/transition.shader
shader_type canvas_item;
render_mode unshaded;

uniform float cutoff_one : hint_range(-0.01, 2.0) = 0.5;
uniform float cutoff_two : hint_range(-0.01, 2.0) = 0.0;
uniform float smooth_size : hint_range(0.0, 1.0) = 0.0;
uniform bool invert_mask = false;
uniform vec4 masking_color : hint_color = vec4(1.0,1.0,1.0,1.0);
uniform sampler2D mask : hint_albedo;

void fragment()
{
	vec4 orig_color = texture(TEXTURE, UV);
	float value = texture(mask, UV).r;
	float alpha = smoothstep(cutoff_one, cutoff_one - smooth_size, value * (1.0 - smooth_size) + smooth_size) - smoothstep(cutoff_two, cutoff_two - smooth_size, value * (1.0 - smooth_size) + smooth_size);
	if (invert_mask == true) {
		alpha = 1.0 - alpha;
	}
	COLOR = vec4(orig_color.rgb * masking_color.rgb, alpha * orig_color.a);
}