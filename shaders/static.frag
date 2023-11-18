// just a simple static with alpha and size (strength)
// its red btw, to change it go to 35 line
// Made by TheLeerName

#pragma header

uniform float ALPHA; // 0.15
uniform vec2 SIZE; // vec2(5)

uniform float iTime;

// https://www.shadertoy.com/view/ltB3zD
// Golden Ratio
#define PHI 1.61803398874989484820459
float gold_noise(in vec2 xy, in float seed) {
	return fract(tan(distance(xy*PHI, xy)*seed)*xy.x);
}

// fragCoord - (openfl_TextureCoordv*openfl_TextureSize, or if you in shadertoy just 2nd arg in void mainImage)
// seed - u can use iTime for it
// size - in pixels ig
float staticSized(vec2 fragCoord, float seed, vec2 size) {
	fragCoord = floor(fragCoord / size) + 1.;
	return gold_noise(fragCoord, seed);
}

void main() {
	vec2 uv = openfl_TextureCoordv.xy;
	if (uv.x < 0. || uv.y < 0. || uv.x > 1. || uv.y > 1.)
		discard;

	gl_FragColor = flixel_texture2D(bitmap, uv);

	vec2 fragCoord = uv * openfl_TextureSize;
	gl_FragColor.rgb = mix(gl_FragColor.rgb, vec3(staticSized(fragCoord, iTime, SIZE), 0, 0), ALPHA) * gl_FragColor.a;
}