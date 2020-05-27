// 1337 Shader

// Advanced Scanlines (CRT) shader, created to use in PPSSPP (Licence is GPLv2)

#version 130

uniform sampler2D tex_scr;


float amount = 0.8; // suitable range = 0.0 - 1.0
float intensity = 0.8; // suitable range = 0.0 - 1.0

void ppsspp_scanline(vec2 v_texcoord0, sampler2D sampler0)
{
	float pos0 = ((v_texcoord0.y + 1.0) * 170.0*amount) * vec2(textureSize(tex_scr, 0)).x;
	float pos1 = cos((fract( pos0 ) - 0.5)*3.1415926*intensity)*1.5;
	vec4 rgb = texture2D( sampler0, v_texcoord0 );

  	float l = 1.0 - dot(rgb.rgb, vec3(0.299, 0.587, 0.114));
  	rgb = vec4(l, l, l, 1.0);

  	// slight contrast curve
  	float col = l*0.5+0.5*l*l*1.2;

  	// color tint
  	vec4 color = vec4(col) * vec4(0.1,0.9,0.1, 0.0);
  
  	// vignette
  	color *= 1.1 - 0.8 * (dot(v_texcoord0 - 0.5, v_texcoord0 - 0.5) * 2.0);
  	gl_FragColor.rgba = mix(vec4(0,0,0,0), color, pos1);
}

void main() 
{
	ppsspp_scanline(gl_TexCoord[0].xy, tex_scr);
}

