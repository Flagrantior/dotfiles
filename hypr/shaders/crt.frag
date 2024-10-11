precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

//const vec2 res = vec2(1920., 1080.);
const vec2 res = vec2(1280., 720.);

vec2 curve(vec2 uv) {
  uv = (uv - 0.5) * 2.19;
  uv.x *= 1.0 + pow((abs(uv.y) / 8.0), 2.0);
  uv.y *= 1.0 + pow((abs(uv.x) / 8.0), 2.0);
  uv = (uv * .5) + 0.5;
  uv = uv * 0.92 + 0.04;
  return uv;
}

void main() {
  vec2 uv = v_texcoord;
  uv = curve(uv);
  vec4 pixColor = texture2D(tex, uv);

  vec3 col = pixColor.rgb;
	col.r = texture2D(tex, vec2(uv.x + .0006, uv.y)).r;
	col.b = texture2D(tex, vec2(uv.x - .0006, uv.y)).b;
	col.g = texture2D(tex, vec2(uv.x - .0000, uv.y)).g;

  col = mix(col, col * smoothstep(.0, 1., col), 0.25);

  vec2 uv_ = uv * (1.0 - uv.yx);
  float vignette = uv_.x * uv_.y * 1000.;
  vignette = clamp(pow(vignette, .1), 0., 1.0);
  col *= vec3(vignette);

  float phosphor = .015;
  col.r += (phosphor*sin((uv.y           )*res.y*1.333333333)) *(cos(uv.x*6.282)+1.);
  col.g += (phosphor*sin((uv.y+.333333333)*res.y*1.333333333)) *(cos(uv.x*6.282)+1.);
  col.b += (phosphor*sin((uv.y+.666666666)*res.y*1.333333333)) *(cos(uv.x*6.282)+1.);

  if (uv.x < 0.0 || uv.x > 1.0) col *= 0.0;
  if (uv.y < 0.0 || uv.y > 1.0) col *= 0.0;

	pixColor.rgb = col.rgb;
  gl_FragColor = pixColor;
}
