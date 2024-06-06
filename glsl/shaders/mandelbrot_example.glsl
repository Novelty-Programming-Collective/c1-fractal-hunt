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

vec2 squareImaginary(vec2 number){
	return vec2( number.x * number.x - number.y * number.y, 2.0*number.x*number.y);
}

float iterateMandelbrot(vec2 coord){
    float maxIterations = 500.0;
	vec2 z = vec2(0,0);

	for(int i=0;i<1000;i++){
		z = squareImaginary(z) + coord;

		if(length(z)>2.0) {
            return float(i)/ maxIterations;
        }
        
	}
	return 1.0;
}

vec4 mandelbrot(vec2 screen_position) {
    float tz = 0.5 - 0.5*cos(0.225 * u_time/2.0);
    float zoom = pow(0.5,20.0*tz);
    vec2 start_point = vec2(-0.761574,-0.0847596);

    screen_position = zoom * screen_position + start_point;

    float mcolor = iterateMandelbrot(screen_position);
    float c = 0.2 / mcolor;
    vec3 p = palette(c + u_time);

    return vec4(p, 1.0);
}


void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy * 2.0 - 1.0;
    st.x *= u_resolution.x / u_resolution.y;

    vec4 mandelcolor = mandelbrot(st);
    gl_FragColor = mandelcolor;
}