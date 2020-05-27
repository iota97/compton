// Oil effect

#version 130

uniform sampler2D tex_scr;

void main(void) 
{
	// Config
	float radius = 7.0;
	float offset = 1.0;
	
	// Pixel size
	vec2 delta = 1.0/vec2(textureSize(tex_scr, 0));

	// Get most luminous pixel within the radius
	vec3 lum_fac = vec3(0.299, 0.587, 0.114);
	vec3 col;
	float lum = -1.0;

	for(float x = -radius; x < radius; x+=offset)
	{
		for(float y = -radius; y < radius; y+=offset)
		{
			vec3 tmp_col = texture2D(tex_scr, gl_TexCoord[0].xy + vec2(x, y)*delta).rgb;
			float tmp_lum = dot(tmp_col, lum_fac);
			if (tmp_lum > lum)
			{
				lum = tmp_lum;
				col = tmp_col;
			}
		}
	}

	// Display it
	gl_FragColor = vec4(col, 1.0);
}
