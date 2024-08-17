shader_type canvas_item;

// mipmap is neaded for textureLod
uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest_mipmap;

void fragment() {
	vec4 screen = textureLod(screen_texture, SCREEN_UV, 0.0);
	screen.r = 1.0 - screen.r;
	screen.g = 1.0 - screen.g;
	screen.b = 1.0 - screen.b;
    COLOR = screen;
}