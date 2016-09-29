#ifdef GL_ES
precision mediump float;
#endif

attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec4 a_color;

varying vec2 v_texCoord;
varying float v_alf;

void main()
{
    gl_Position = CC_PMatrix * a_position;
    v_alf = a_color.a;
    v_texCoord = a_texCoord;
}
