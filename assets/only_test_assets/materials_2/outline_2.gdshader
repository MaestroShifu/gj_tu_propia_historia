shader_type spatial;
render_mode unshaded;
// Settings outline
uniform float thickness = 1.0;
uniform vec4 colorOutline: source_color = vec4(0.0, 0.0, 0.0, 1.0);

// Settings for lineardepth function
uniform float zNear = 0.1;
uniform float zFar = 15.0;

// Hints from GODOT
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
//linearises the depth sample
float linearDepth(float depthSample) {
	depthSample = 2.0 * depthSample - 1.0;
	float zLinear = 2.0 * zNear * zFar / (zFar + zNear - depthSample * (zFar - zNear));
	return zLinear;
}

void fragment() {
	vec3 offset = vec3((1.0 / VIEWPORT_SIZE.x), (1.0 / VIEWPORT_SIZE.y), 0.0) * thickness;
	
	float pixelCenter = linearDepth(texture(DEPTH_TEXTURE, SCREEN_UV).x);
	float pixelLeft   = linearDepth(texture(DEPTH_TEXTURE, SCREEN_UV - offset.xz).x);
	float pixelRight  = linearDepth(texture(DEPTH_TEXTURE, SCREEN_UV + offset.xz).x);
	float pixelUp     = linearDepth(texture(DEPTH_TEXTURE, SCREEN_UV + offset.zy).x);
	float pixelDown   = linearDepth(texture(DEPTH_TEXTURE, SCREEN_UV - offset.zy).x);
	
	float sobelDepth = abs(pixelLeft-pixelCenter) + abs(pixelRight-pixelCenter) + abs(pixelUp-pixelCenter) + abs(pixelDown-pixelCenter);
	sobelDepth /= 4.0;
	sobelDepth = floor(clamp(sobelDepth, 0.0, 1.0) );
	
	
	ALBEDO =  colorOutline.rgb;
	ALPHA = sobelDepth;
}
