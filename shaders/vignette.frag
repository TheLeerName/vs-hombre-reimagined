#pragma header

#define round(a) floor(a + 0.5)
#define texture flixel_texture2D
#define iResolution openfl_TextureSize
uniform float iTime;
#define iChannel0 bitmap

#define VIGNETTE_OUTER 0.9
#define VIGNETTE_INNER 0.3
#define VIGNETTE_BREATH_SPEED 7.5
#define VIGNETTE_BREATH_STRENGTH 0.06

vec4 vignette(vec4 fragColor, vec2 uv, float outer, float inner) {
	float dist  = distance(vec2(.5), uv) * 1.414213;
	float vig = clamp((outer - dist) / (outer - inner), 0.0, 1.0);
	fragColor.rgb *= vig;
	return fragColor;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord / iResolution.xy;
	if (uv.x < 0. || uv.y < 0. || uv.x > 1. || uv.y > 1.)
		discard;

	fragColor = texture(iChannel0, uv);

	// vignette code from https://www.shadertoy.com/view/4sB3Rc
	float outer = VIGNETTE_OUTER;
	outer *= abs(sin(iTime * VIGNETTE_BREATH_SPEED)) * VIGNETTE_BREATH_STRENGTH + 1.;
	fragColor = vignette(fragColor, uv, outer, VIGNETTE_INNER);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}