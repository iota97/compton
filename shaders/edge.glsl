// Edge detect

#version 130

uniform sampler2D tex_scr;

void main(void) 
{
	// Pixel size
	vec2 pix = 1.0/vec2(textureSize(tex_scr, 0));

	// Frag coordinate
	vec2 coord = gl_TexCoord[0].xy;

	/* Use 3x3 kernel:

		0  1  0
		1 -4  1
		0  1  0
	*/

	vec4 col0 = texture2D(tex_scr, coord);
	vec4 col1 = texture2D(tex_scr, coord + vec2(0.0, -pix.y));
	vec4 col2 = texture2D(tex_scr, coord + vec2(-pix.x, 0.0));
	vec4 col3 = texture2D(tex_scr, coord + vec2(0.0, pix.y));
	vec4 col4 = texture2D(tex_scr, coord + vec2(pix.x, 0.0));
	vec4 col = col1 + col2 + col3 + col4 - 4.0*col0;

	// Test it
	float test = col.r+col.g+col.b;

	if (test > 0.4)
		gl_FragColor = vec4(0.0, 1.0, 0.2, 1.0);
	else
		gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);

}
