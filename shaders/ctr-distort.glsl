// Screen distort from https://github.com/Kobe46/Shaderlay GPLv3.0

#version 130

uniform sampler2D tex_scr;

void main() {
	
	const float factor = 0.5f;

	vec2 coord = gl_TexCoord[0].xy - vec2(0.5);
	float rsq = coord.x * coord.x + coord.y * coord.y;
	coord += coord * (factor * rsq);
	if (abs(coord.x) >= 0.5 || abs(coord.y) >= 0.5) {
		coord = vec2(-1.0);
	} else {
		coord += vec2(0.5);
	}

	gl_FragColor = texture(tex_scr, coord);
}
