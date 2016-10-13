Shader "_Shaders/SimpleTextureTwoSided"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
	}

		SubShader{
		Tags{ "Queue" = "Transparent" }
		ZWrite off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			Cull Front

CGPROGRAM
#pragma exclude_renderers ps3 xbox360 flash
#pragma fragmentoption ARB_precision_hint_fastest
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

//uniforms
uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;


struct vertexInput
{
	float4 vertex : POSITION;
	float4 texcoord : TEXCOORD0;
};

struct fragmentInput
{
	float4 pos : SV_POSITION;
	half2 uv : TEXCOORD0;
};

fragmentInput vert(vertexInput i)
{
	fragmentInput o;
	o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
	o.uv = TRANSFORM_TEX(i.texcoord, _MainTex);

	return o;
}

half4 frag(fragmentInput i) : COLOR
{
	return tex2D(_MainTex, i.uv);
}

ENDCG
		} //end Pass

		Pass
{
	Cull Back

	CGPROGRAM
#pragma exclude_renderers ps3 xbox360 flash
#pragma fragmentoption ARB_precision_hint_fastest
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

//uniforms
uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;


struct vertexInput
{
	float4 vertex : POSITION;
	float4 texcoord : TEXCOORD0;
};

struct fragmentInput
{
	float4 pos : SV_POSITION;
	half2 uv : TEXCOORD0;
};

fragmentInput vert(vertexInput i)
{
	fragmentInput o;

	// vert distortion
	i.vertex.x += _SinTime.w * i.vertex.y;

	o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
	o.uv = TRANSFORM_TEX(i.texcoord, _MainTex);

	return o;
}

half4 frag(fragmentInput i) : COLOR
{
	return tex2D(_MainTex, i.uv);
}

ENDCG
} //end Pass
	}
	FallBack "Diffuse"
}
