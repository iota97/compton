// Sobel Edge Detection Filter

#version 130

uniform sampler2D tex_scr;

// hsv2rgb snippet
vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {

	// Pixel size
 	vec2 delta = 1.0/vec2(textureSize(tex_scr, 0));

  	// Get luminance of addiacent pixels
	vec3 lum = vec3(0.299, 0.587, 0.114);
	float col0 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(-1.0, -1.0)*delta).rgb, lum);
 	float col1 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(0.0, -1.0)*delta).rgb, lum);
  	float col2 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(1.0, -1.0)*delta).rgb, lum);
  	float col3 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(-1.0, 0.0)*delta).rgb, lum);
  	float col5 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(1.0, 0.0)*delta).rgb, lum);
  	float col6 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(-1.0, 1.0)*delta).rgb, lum);
  	float col7 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(0.0, 1.0)*delta).rgb, lum);
  	float col8 = dot(texture2D(tex_scr, gl_TexCoord[0].xy + vec2(1.0, 1.0)*delta).rgb, lum);

  	// Compute the vertical and horizzontal component
 	float colh = col0+2.0*col1+col2-col6-2.0*col7-col8;
  	float colv = col2+2.0*col5+col8-col0-2.0*col3-col6;

	// Angle and magnitude
  	float angle = atan(colv/colh);
  	float mag = sqrt(colh*colh+colv*colv);

 	// Output color
 	gl_FragColor.rgb = hsv2rgb(vec3(angle/3.14159, 1.0, mag/4.472136));
  	gl_FragColor.a = 1.0;
}
