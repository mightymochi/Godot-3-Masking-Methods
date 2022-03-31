shader_type canvas_item;

uniform bool invert_mask = false;

void fragment(){
	COLOR = texture(SCREEN_TEXTURE,SCREEN_UV);
	float alpha_total = texture(TEXTURE, UV).a;
	if (invert_mask == true) {
		alpha_total = 1.0 - alpha_total;
	}
	COLOR.a = alpha_total;
}