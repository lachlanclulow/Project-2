﻿Shader "_Shaders/DualTexture"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		_TextureMix ("Texture Mix", Range(0.0, 1.0)) = 0.5
	}

	SubShader
	{
		Tags{ "Queue" = "Transparent" }
		ZWrite off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
CGPROGRAM
#pragma exclude_renderers ps3 xbox360 flash
#pragma fragmentoption ARB_precision_hint_fastest
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

//uniforms
uniform sampler2D _MainTex;
uniform float4 _MainTex_ST;
uniform sampler2D _SecondTex;
uniform float4 _SecondTex_ST;
uniform fixed _TextureMix;


struct vertexInput
{
	float4 vertex : POSITION;
	float4 texcoord : TEXCOORD0;
};

struct fragmentInput
{
	float4 pos : SV_POSITION;
	half2 uv : TEXCOORD0;
	half uv2 : TEXCOORD1;
};

fragmentInput vert(vertexInput i)
{
	fragmentInput o;
	o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
	o.uv = TRANSFORM_TEX(i.texcoord, _MainTex);
	o.uv2 = TRANSFORM_TEX(i.texcoord, _SecondTex);

	return o;
}

half4 frag(fragmentInput i) : COLOR
{
	fixed4 mainTexColor = tex2D(_MainTex, i.uv);
fixed4 secondTexColor = tex2D(_SecondTex, i.uv2);

	return  lerp(mainTexColor, secondTexColor, _TextureMix);
}

ENDCG
		} //end Pass
	} // end SubShader
	FallBack "Diffuse"
}
