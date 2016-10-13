Shader "_Shaders/Lit Vertex Specular" {
	Properties {
		_Color ("Diffuse Material Color", Color) = (1,1,1,1)
		_MainTex ("Base RGB", 2D) = "white" {}
		_SpecColor("Specular Material Color", Color) = (1,1,1,1)
		_Shininess("Shininess", Float) = 10
	}
		SubShader{

			Tags { "LightMode" = "ForwardBase" }

			Pass
			{
CGPROGRAM
#pragma exclude_renderers ps3 xbox360 flash
#pragma fragmentoption ARB_precision_hint_fastest
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"
#include "../Shared/prime31.cginc"

// uniforms
uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;
uniform fixed4 _Color;
uniform fixed4 _LightColor0;
uniform fixed4 _SpecColor;
uniform float _Shininess;

struct vertexInput
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 texcoord : TEXCOORD;
};

struct fragmentInput
{
	float4 pos : SV_POSITION;
	float4 color : COLOR0;
	half2 uv : TEXCOORD0;
};

fragmentInput vert(vertexInput i)
{
	fragmentInput o;
	o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
	o.uv = TRANSFORM_TEX(i.texcoord, _MainTex);

	float3 normalDirection = NORMAL_TO_WORLD( i.normal);

	float3 lightDirection = WorldSpaceLightDir( i.vertex );

	float attenuation = 1.0 / length(lightDirection);
	lightDirection = normalize(lightDirection);

	float ndotl = dot(normalDirection, lightDirection);
	float3 diffuse = attenuation * _LightColor0.rgb * _Color.rgb * max(0.0, ndotl);

	float3 viewDirection = WorldSpaceLightDir(i.vertex);
	float3 specularReflection;

	if (ndotl > 0)
	{
		float3 reflection = reflect(-lightDirection, normalDirection);
		float rdotv = pow(max(0.0, dot(reflection, viewDirection)), _Shininess);
		specularReflection = attenuation * _LightColor0.rgb * _SpecColor.rgb * rdotv;
	}
	else
	{
		specularReflection = float3(0.0, 0.0, 0.0);
	}

	float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb * _Color.rgb;
	o.color = float4(ambientLighting + diffuse + specularReflection, 1.0);

	//o.color = half4(diffuse, 1.0);

	return o;
}

half4 frag(fragmentInput i) : COLOR
{
	return i.color;
	return tex2D(_MainTex, i.uv) * i.color;
}


ENDCG
		}
	}
	FallBack "Diffuse"
}
