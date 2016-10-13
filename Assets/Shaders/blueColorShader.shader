Shader "_Shaders/blueColorShader" {
	Properties 
	{
		_MainTex("Main Texture", 2D) = "white" {}
	}

		SubShader 
	{
		Tags { "Queue" = "Transparent" }
		ZWrite Off

		Blend SrcAlpha OneMinusSrcAlpha
		
		Pass 
		{
			CGPROGRAM
			#pragma exclude_renderers ps3 xbox360
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform _MainTex

			struct vertexInput
			{
				float4 vertex : POSITION;
			};

			struct fragmentInput
			{
				float4 pos : SV_POSITION;
			};

			fragmentInput vert( vertexInput i )
			{
				fragmentInput o;
				o.pos = mul(UNITY_MATRIX_MVP, i.vertex);

				return o;
			}

			half4 frag( fragmentInput i ) : COLOR
			{
				return half4(0.0, 0.0, 0.0, 1.0);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
