Shader "Unlit/Shader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			void C5E1v_basicLight(float4 position  : POSITION,

				float3 normal : NORMAL,



				out float4 oPosition : POSITION,

				out float4 color : COLOR,



				uniform float4x4 modelViewProj,

				uniform float3 globalAmbient,

				uniform float3 lightColor,

				uniform float3 lightPosition,

				uniform float3 eyePosition,

				uniform float3 Ke,

				uniform float3 Ka,

				uniform float3 Kd,

				uniform float3 Ks,

				uniform float  shininess)



			{

				oPosition = mul(modelViewProj, position);



				float3 P = position.xyz;

				float3 N = normal;



				// Compute the emissive term

				float3 emissive = Ke;



				// Compute the ambient term

				float3 ambient = Ka * globalAmbient;



				// Compute the diffuse term

				float3 L = normalize(lightPosition - P);

				float diffuseLight = max(dot(N, L), 0);

				float3 diffuse = Kd * lightColor * diffuseLight;



				// Compute the specular term

				float3 V = normalize(eyePosition - P);

				float3 H = normalize(L + V);

				float specularLight = pow(max(dot(N, H), 0),

					shininess);

				if (diffuseLight <= 0) specularLight = 0;

				float3 specular = Ks * lightColor * specularLight;



				color.xyz = emissive + ambient + diffuse + specular;

				color.w = 1;

			}

			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
