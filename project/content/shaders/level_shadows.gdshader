shader_type canvas_item;
render_mode unshaded;

const vec3 shadow_color = vec3(0.0, 0.0, 0.0);

uniform float angle : hint_range(0, 360) = 0; 
uniform float max_dist : hint_range(0, 1000) = 50;  
uniform float shadow_strength : hint_range(0.0, 1.0) = 0.5;

void fragment() { 
    float ang_rad = angle * 3.1416 / 180.0; 
    vec2 dir = vec2(sin(ang_rad), cos(ang_rad)); 
    vec2 at = screen_uv_to_sdf(SCREEN_UV); 
    float accum = 0.0;
    
    while(accum < max_dist) {
        float d = texture_sdf(at);
        accum += d;
        
        if (d < 0.01) {
            break;
        }
        
        at += d * dir;
    }
    
    float alpha = accum < max_dist ? 1.0 : 0.0;
    COLOR = vec4(shadow_color, alpha * shadow_strength);
}