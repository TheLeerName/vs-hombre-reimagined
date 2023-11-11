#pragma header

uniform float curveX;
uniform float curveY;

float wiggle(float u) {
	return 27.0*(1.0 - 2.0*u); 
}

void main() {
	// wtf the matrix 3 revolutions reference?!??!?!?!?!
	mat3 matrix = mat3(
        1., 0., wiggle( 0.5 + curveX / 10. ),
        0., 1., wiggle( 0.5 + curveY / 10. ),
        0., 0., 1.
    );

	// haha funny 3d perspective
    vec3 uv3 = matrix * vec3(openfl_TextureCoordv - 0.5, 1.0);
    vec2 uv = uv3.xy / uv3.z + 0.5;

	if (uv.x < 0. || uv.y < 0. || uv.x > 1. || uv.y > 1) return;
	gl_FragColor = flixel_texture2D(bitmap, uv);
    gl_FragColor = mix(vec4(0.0), gl_FragColor, vec4(step(0.0, uv3.z))); // remove pixels behind viewer
}