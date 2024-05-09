shader_type canvas_item;
render_mode unshaded;

uniform vec4 color : source_color;
uniform float angle : hint_range(0, 360);
uniform float max_dist : hint_range(0, 1000) = 100;
uniform float pixel_size : hint_range(1, 100) = 10; // Größe der "Pixel", jetzt als float

void fragment() {
    // Umrechnung von pixel_size zu einem float für korrekte mathematische Operationen
    vec2 pixel_scale = vec2(pixel_size);

    // Berechne die pixelierten UV-Koordinaten
    vec2 pixel_uv = floor(SCREEN_UV * SCREEN_PIXEL_SIZE / pixel_scale) * pixel_scale / SCREEN_PIXEL_SIZE;

    float ang_rad = angle * 3.1416 / 180.0;
    vec2 dir = vec2(sin(ang_rad), cos(ang_rad));
    vec2 at = screen_uv_to_sdf(pixel_uv);
    float accum = 0.0;

    while(accum < max_dist) {
        float d = texture_sdf(at);
        accum += d;
        if (d < 0.01) {
            break;
        }
        at += d * dir;
    }
    
    float alpha = 1.0 - min(1.0, accum / max_dist);
    alpha = ceil(alpha);
    
    COLOR = vec4(color.rgb, alpha * color.a);
}
