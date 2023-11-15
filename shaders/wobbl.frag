// Wobbl shader (name by cobalt bar)
// Made by TheLeerName
// Specially for VS Hombre Reimagined FNF Mod (not released yet)

#pragma header

// quick quide how to change variables in defines in lua or in smth else
// 1. replace "#define power 0.03" with "uniform float power;"
// 2. profit!!!

#define power 0.05
#define size 2.

// bro will make camera disappear if you not uncomment line below
#define USED_ON_CAMERA

#define VERTICAL
#define HORIZONTAL

void main() {
	vec2 uv = openfl_TextureCoordv;
	vec2 fragCoord = uv * openfl_TextureSize;

	vec2 offset = sin(fragCoord / size) / 100. * power;

	#ifdef HORIZONTAL
	uv.x += offset.y;
	#endif

	#ifdef VERTICAL
	uv.y += offset.x;
	#endif

	#define openfl_TextureCoordv uv

	#ifdef USED_ON_CAMERA
		gl_FragColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
		return;
	#endif

	#pragma body
}