// invert color

#version 110

uniform sampler2D tex_scr;

void main() 
{
	vec4 col = texture2D(tex_scr, gl_TexCoord[0].xy);
	col = vec4(1.0) - col;
	gl_FragColor = col;
}

