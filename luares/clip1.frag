#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;

void main(void)
{
	vec2 D = vec2(v_texCoord.x - 0.5, v_texCoord.y - 0.5);
	float d = length(D);
	if(d < 0.38)
	{
		gl_FragColor = texture2D(CC_Texture0, v_texCoord);
	}
	else if(d > 0.39)
	{
		gl_FragColor = vec4(0);
	}
	else
	{
		vec4 color = texture2D(CC_Texture0, v_texCoord);
		float aa = (0.39 - d)/0.01;
		gl_FragColor = color*aa;
	}
}