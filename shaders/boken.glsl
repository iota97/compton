#version 130

uniform sampler2D tex_scr;

// Bokeh disc.
// by David Hoskins.
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. (https://www.shadertoy.com/view/4d2Xzw)
// Modified by SolarLiner

// The Golden Angle is (3.-sqrt(5.0))*PI radians, which doesn't precompiled for some reason.
// The compiler is a dunce I tells-ya!!
#define GOLDEN_ANGLE 2.39996323
#define ITERATIONS 256
#define DISTORTION_ANAMORPHIC	0.6;
#define DISTORTION_BARREL	0.6;
// Helpers-----------------------------------------------------------------------------------
vec2 rotate(vec2 vector, float angle)
{
    float s = sin(angle);
    float c = cos(angle);
    
    return vec2(c*vector.x-s*vector.y, s*vector.x+c*vector.y);
}

mat2 rotMatrix(float angle)
{
    return mat2(cos(angle), sin(angle),
                    -sin(angle), cos(angle));
}

// Additions by SolarLiner ------------------------------------------------------------------
vec2 GetDistOffset(vec2 uv, vec2 pxoffset)
{
    vec2 tocenter = uv.xy+vec2(-0.5,0.5);
    vec3 prep = normalize(vec3(tocenter.y, -tocenter.x, 0.0));
    
    float angle = length(tocenter.xy)*2.221*DISTORTION_BARREL;
    vec3 oldoffset = vec3(pxoffset,0.0);
    float anam = 1.0-DISTORTION_ANAMORPHIC; // Prevents a strange syntax error
    oldoffset.x *= anam;
    
    vec3 rotated = oldoffset * cos(angle) + cross(prep, oldoffset) * sin(angle) + prep * dot(prep, oldoffset) * (1.0-cos(angle));
    
    return rotated.xy;
}

//-------------------------------------------------------------------------------------------
vec3 Bokeh(sampler2D tex, vec2 uv, float radius, float amount)
{
	vec3 acc = vec3(0.0);
	vec3 div = vec3(0.0);
	vec2 tocenter = uv.xy+vec2(-0.5,0.5);
	vec2 pixel = 1.0 / vec2(textureSize(tex_scr, 0));
	float r = 1.0;
	vec2 vangle = vec2(0.0,radius); // Start angle
	mat2 rot = rotMatrix(GOLDEN_ANGLE);
    
	amount += radius*500.0;
    
	for (int j = 0; j < ITERATIONS; j++)
    	{  
        	r += 1. / r;
		vangle = rot * vangle;
       		 // (r-1.0) here is the equivalent to sqrt(0, 1, 2, 3...)
       		vec2 pos = GetDistOffset(uv, pixel*(r-1.)*vangle);
        
		vec3 col = texture(tex, uv + pos).xyz;
		col = col * col * 1.5; // ...contrast it for better highlights - leave this out elsewhere.
		vec3 bokeh = pow(col, vec3(9.0)) * amount+.4;
		acc += col * bokeh;
		div += bokeh;
	}
	return acc / div;
}

void main()
{
        gl_FragColor = vec4(Bokeh(tex_scr, gl_TexCoord[0].xy, 1.0, 40.0), 1.0);
}
