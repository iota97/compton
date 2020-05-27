// Chromatic aberation from https://www.shadertoy.com/view/4dXXDl by jcant0n

#version 130

uniform sampler2D tex_scr;

void main(void) {
	
	float ChromaticAberration = 25.0f;
	vec2 uv = gl_TexCoord[0].xy;

	vec2 texel = 1.0/vec2(textureSize(tex_scr, 0));
    
	vec2 coords = (uv - 0.5) * 2.0;
	float coordDot = dot(coords, coords);
    
	vec2 precompute = ChromaticAberration * coordDot * coords;
	vec2 uvR = uv - texel.xy * precompute;
	vec2 uvB = uv + texel.xy * precompute;
    
	vec4 color;
    	color.r = texture(tex_scr, uvR).r;
    	color.g = texture(tex_scr, uv).g;
    	color.b = texture(tex_scr, uvB).b;
    
	gl_FragColor = color;
}
