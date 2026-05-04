shader_type canvas_item;

// === PARAMETERS YOU CAN TWEAK ===
uniform float speed : hint_range(0.0, 10.0) = 1.0;
uniform float intensity : hint_range(0.0, 2.0) = 0.1;
uniform float frequency : hint_range(0.0, 100.0) = 30.0;
uniform float falloff : hint_range(0.0, 10.0) = 3.0;
uniform float time_scale : hint_range(0.01, 10.0) = 2.0;
uniform vec2 pivot = vec2(0.5, 0.0);
uniform vec2 offset = vec2(0.0, -1.0);

// === ROTATION FUNCTION ===
vec2 rotate(vec2 vec, float theta) {
	float s = sin(theta);
	float c = cos(theta);
	return vec2(
		vec.x * c - vec.y * s,
		vec.x * s + vec.y * c
	);
}

void fragment() {
	vec2 uv = (UV - pivot) * 2.0;

	float time_intensity = 1.0 / (0.01 + TIME * speed / time_scale);
	float rot = sin(time_intensity * frequency) * intensity * (1.0 + length(uv) * falloff);

	uv = rotate(uv + offset, rot) - offset;

	if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
		COLOR = vec4(0.0);
	} else {
		COLOR = texture(TEXTURE, uv);
	}
}