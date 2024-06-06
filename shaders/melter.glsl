precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 palette(float t) {
  vec3 a = vec3(0.848, 0.238, 0.628);
  vec3 b = vec3(0.659, 0.438, 0.328);
  vec3 c = vec3(0.388, 0.388, 0.296);
  vec3 d = vec3(2.538, 2.478, 0.168);
  
  return a.xyz + b.xyz * cos(6.28318 * (c.xyz * t + d.xyz));
}

vec4 fractal_circle(vec2 st) {
    st = fract(st * 2.0) - 0.5;;
    float d = length(st);
    vec3 color = palette(d + u_time);

    d = sin(d * 8.0 + u_time) / 8.0;
    d = abs(d);
    
    d = 0.02 / d;

    color *= d;
    return vec4(color, 1.0);
}
void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy * 2.0 - 1.0;
    st.x *= u_resolution.x / u_resolution.y;

    vec4 mandelcolor = fractal_circle(st);
    gl_FragColor = mandelcolor;
}