// black and white

#version 110

uniform sampler2D tex_scr;

void main() 
{
	vec4 col = texture2D(tex_scr, gl_TexCoord[0].xy);
	float l = dot(col.rgb, vec3(0.299, 0.587, 0.114));
	gl_FragColor = vec4(l, l, l, 1.0);
}

