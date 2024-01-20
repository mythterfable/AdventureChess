shader_type canvas_item;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    if (tex.a == 0.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
        COLOR.rgb = vec3(1.0) - tex.rgb;
        COLOR.a = tex.a;
    }
}
