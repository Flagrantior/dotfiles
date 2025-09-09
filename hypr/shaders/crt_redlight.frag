#version 320 es
precision mediump float;
in vec2 v_texcoord;
out vec4 FragColor;
uniform sampler2D tex;

//const vec2 res = vec2(1920., 1080.);
const vec2 res = vec2(1280., 720.);

void main() {
  vec2 uv = (v_texcoord -.5) *2.19;
  uv.x *= 1. +pow((uv.y*.125), 2.);
  uv.y *= 1. +pow((uv.x*.125), 2.);
  uv = (uv*.5 +.5)*.92 +.04;

  vec3 col = texture(tex, uv).rgb;

	col.r = texture(tex, vec2(uv.x -(uv.x-.35)*.004, uv.y -(uv.y-.5)*.002)).r;
	col.b = texture(tex, vec2(uv.x +(uv.x-.35)*.004, uv.y +(uv.y-.5)*.002)).b;

	col = mix(col, col * smoothstep(.0, 1., col), 0.25);
	col = vec3(col.r, col.g*.75, col.b*.25);

	vec2 _uv = uv *(1.0 -uv.yx);
  col *= clamp(pow((_uv.x *_uv.y *1000.), .1), 0., 1.0);


  col.r += (.015 *sin((uv.y            ) *res.y *1.333333333)) *(cos(uv.x*6.282)+1.);
  col.g += (.025 *sin((uv.y +.333333333) *res.y *1.333333333)) *(cos(uv.x*6.282)+1.);
  col.b += (.025 *sin((uv.y +.666666666) *res.y *1.333333333)) *(cos(uv.x*6.282)+1.);

  if (uv.x<0. || uv.x>1. || uv.y<0. || uv.y>1.) col = vec3(0.);

  FragColor = vec4(col, 1.);
}
