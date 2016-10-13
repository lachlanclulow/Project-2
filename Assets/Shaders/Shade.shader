Shader "_Shaders/Shade" 
{
	Properties
	{
		_Color("Tint Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

		SubShader
	{
		Tags { "Queue" = "Transparent" }
		ZWrite Off
		
		//Blend modes equation
		//						SrcFactor * fragment_output + DstFactor * pixel_color_in_framebuffer;
		// Blend {code for SrcFactor} {code for DstFactor}
		
		Blend SrcAlpha OneMinusSrcAlpha
		//Blend One OneMinusSrcAlpha
		//Blend One One
		//Blend SrcAlpha One
		//Blend OneMinusDstColor One
		//Blend DstColor Zero
		//Blend DstColor SrcColor
		//Blend Zero SrcAlpha

		//BlendOp Min
		//BlendOp Max

		Pass
		{
			CGPROGRAM
			#pragma exclude_renderers ps3 xbox360
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// uniforms
			uniform fixed4 _Color;

			struct vertexInput
			{
				float4 vertex : POSITION; // position (in object coordinates)
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord: TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				fixed4 color : COLOR;
			};

			struct fragmentInput
			{
				float4 pos : SV_POSITION;
				float4 color : COLOR0;
			};

			fragmentInput vert( vertexInput i )
			{
				fragmentInput o;
				o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
				o.color = _Color;

				// debug
				//o.color = i.texcoord;
				//o.color = i.textcoord1;
				//o.color = i.vertex;
				//o.color = i.vertex + float4( 0.5, 0.5, 0.5, 0.0 );
				//o.color = i.tangent;
				//o.color = float4( i.normal * 0.5 + 0.5, 1.0 );
				//o.color = i.color;

				return o;
			}

			half4 frag( fragmentInput i ) : COLOR
			{
				return i.color;
			}

			ENDCG
		}	

	}

	FallBack "Diffuse"
}
