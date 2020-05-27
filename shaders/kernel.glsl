// Custom kernel
// Sharpening ATM

#version 130

uniform sampler2D tex_scr;

void main(void) 
{
	// Kernel matix
	float k0 =  0.0, k1 = -0.5, k2 =  0.0;
	float k3 = -0.5, k4 =  3.0, k5 = -0.5;
	float k6 =  0.0, k7 = -0.5, k8 =  0.0;

	// Pixel size
	vec2 pix = 1.0/vec2(textureSize(tex_scr, 0));

	// Frag coordinate
	vec2 coord = gl_TexCoord[0].xy;

	// Colors of the 3x3 pixel matrix
	vec4 c0 = texture2D(tex_scr, coord + vec2(-pix.x, pix.y));
	vec4 c1 = texture2D(tex_scr, coord + vec2(0.0, pix.y));
	vec4 c2 = texture2D(tex_scr, coord + vec2(pix.x, pix.y));
	vec4 c3 = texture2D(tex_scr, coord + vec2(-pix.x, 0.0));
	vec4 c4 = texture2D(tex_scr, coord);
	vec4 c5 = texture2D(tex_scr, coord + vec2(pix.x, 0.0));
	vec4 c6 = texture2D(tex_scr, coord + vec2(-pix.x, -pix.y));
	vec4 c7 = texture2D(tex_scr, coord + vec2(0.0, -pix.y));
	vec4 c8 = texture2D(tex_scr, coord + vec2(pix.x, -pix.y));

	// Compute the kernel
	gl_FragColor = c0*k0+c1*k1+c2*k2+c3*k3+c4*k4+c5*k5+c6*k6+c7*k7+c8*k8;
}
