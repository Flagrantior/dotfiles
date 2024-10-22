precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
  vec3 col = texture2D(tex, v_texcoord).rgb;

	gl_FragColor.r = col.r;
	gl_FragColor.g = col.g*.75;
	gl_FragColor.b = col.b*.25;
}
