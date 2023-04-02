shader_type canvas_item;
uniform int MAX_ITERATIONS = 1000;
uniform vec4 background_color = vec4(0,0,0,1);
uniform float zoom;
uniform float pos_x;
uniform float pos_y;
uniform int mode;
uniform int mode_z;


void fragment() {
	COLOR = background_color;
	
	vec2 c = vec2(UV.x / zoom + pos_x, UV.y / zoom + pos_y);
	vec2 z = vec2(0.0);  // complex number
	for (int i=0; i<MAX_ITERATIONS; i++) {
		if (mode_z == 0) z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
		else if (mode_z == 1) z = vec2(abs(z.y * z.y - z.x * z.x), 2.0 * z.x * z.y) + c;
		else if (mode_z == 2) z = vec2(z.x * z.x - z.y * z.y + length(z)*(1.0-2.0/(TIME*TIME*0.1)), 2.0 * z.x * z.y) + c;

	    if (length(z) < float(i)*(0.05/log(zoom*zoom*zoom+1.2))) {  // < float(i)*0.01   > 2.0
	        //COLOR = vec4(0, sin(1.0/length(z)*0.1), cos(1.0/length(z)*0.1), 1);
	        COLOR = vec4(0, sin(float(i)*0.1), cos(float(i)*0.1), 1);
			if (mode==1)
				break;
	    } else if (length(z) > 2.0) {
	        COLOR = vec4(0, sin(float(i)*0.1), cos(float(i)*0.1), 1);
			break;
		}
	}
}