#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;
//varying float v_alf;

uniform float a_alf;

void main(void)
{
	vec2 D = vec2(v_texCoord.x - 0.5, v_texCoord.y - 0.5);
	float d = length(D);
	if(d < 0.28)
	{
		gl_FragColor = texture2D(CC_Texture0, v_texCoord);
		gl_FragColor = a_alf*gl_FragColor;
	}
	else if(d > 0.29)
	{
		gl_FragColor = vec4(0,0,0,0);
	}
}