#version 320 es
precision mediump float;
in vec2 v_texcoord;
out vec4 FragColor;
uniform sampler2D tex;

void main() {
  vec3 col = texture(tex, v_texcoord).rgb;

	FragColor.r = col.r;
	FragColor.g = col.g*.75;
	FragColor.b = col.b*.25;
	FragColor.a = 1.0;
}
