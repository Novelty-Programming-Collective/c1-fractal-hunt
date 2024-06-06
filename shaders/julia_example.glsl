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

float julia(vec2 uv){
    // renders the julia set.
	int j;
	for(int i=0;i<1000;i++){
		j++;
		vec2 c=vec2(-0.345,0.654);
		vec2 d=vec2(u_time*0.005,0.0);
		uv=vec2(uv.x*uv.x-uv.y*uv.y,2.0*uv.x*uv.y)+c+d;
		if(length(uv)>float(1000)){
			break;
		}
	}
	return float(j)/float(1000);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy * 2.0 - 1.0;
    st.x *= u_resolution.x / u_resolution.y;

    st*=abs(sin(u_time*0.02));
	float f=julia(st);
    float c = 0.2 / f;
    vec3 p = palette(c + u_time);

	gl_FragColor = vec4(p,1.0);
}