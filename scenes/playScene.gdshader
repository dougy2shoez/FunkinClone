shader_type canvas_item;
uniform float hue:hint_range(0.0, 6.283185) = 0.0;

uniform float saturation: hint_range(0.0, 4) = 1.0;

uniform float brightness: hint_range(0.0, 4) = 1.0;

uniform float contrast :hint_range(0.0, 4) = 1.0;



void fragment()

{

	COLOR = texture(TEXTURE,UV);

	vec4 color = texture(TEXTURE,UV);

	mat3 RGB_to_YIQ = mat3(

		vec3(0.2989, 0.5959, 0.2115),

		vec3(0.5870, -0.2774, -0.5229),

		vec3(0.1140, -0.3216, 0.3114)

	);

	color.rgb = RGB_to_YIQ * color.rgb;



	float sin_hue = sin(hue);

	float cos_hue = cos(hue);



	mat3 hue_Shift = mat3(

		vec3(1.0,0,0),

		vec3(0,cos_hue,-sin_hue),

		vec3(0,sin_hue,cos_hue)

	);

	color.rgb = hue_Shift * color.rgb;



	mat3 sat_Shift = mat3(

		vec3(1.0,0,0),

		vec3(0,saturation,0),

		vec3(0,0,saturation)

	);

	color.rgb = sat_Shift * color.rgb;

	color.rgb = inverse(RGB_to_YIQ) * color.rgb;



	color.rgb = mix(vec3(0.0),color.rgb,brightness);

	color.rgb = mix(vec3(0.5),color.rgb,contrast);

	COLOR = color;

}