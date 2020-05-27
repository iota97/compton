// Pixelize

#version 130

uniform sampler2D tex_scr;

void main() 
{
	// Get pixel size
    	vec2 size = vec2(textureSize(tex_scr, 0)/6.0);

	// Pixelize
  	vec2 coord = vec2(floor(gl_TexCoord[0].xy*size)/size);
	
  	// Reduce color depth
 	vec3 col = floor(texture2D(tex_scr, coord).xyz*5.0)/5.0;

  	// Output
 	gl_FragColor.rgb = col;
 	gl_FragColor.a = 1.0;
}

