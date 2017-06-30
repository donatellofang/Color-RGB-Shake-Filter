Shader "Unlit/ScreenColorShake"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScreenResolution ("_ScreenResolution", Vector) = (0.,0.,0.,0.)
        _MoveOffset ("Color Move", float) = 0
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
            
            #include "UnityCG.cginc"
			uniform float4 _ScreenResolution;
            uniform float _MoveOffset;
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
            	float offset = _MoveOffset;
            	float2 offsetCoord1 = i.uv.xy + float2(offset, -offset) / _ScreenResolution.x ;
                float2 offsetCoord2 = i.uv.xy + float2(-offset, offset) / _ScreenResolution.x ;

                fixed4 colorLT = tex2D(_MainTex, offsetCoord1);
                fixed4 colorRD = tex2D(_MainTex, offsetCoord2);
                fixed4 originalColor = tex2D(_MainTex, i.uv);
                // sample the texture
                //fixed4 color = tex2D(_MainTex, i.uv);

                //green,blue,red
                fixed4 col = fixed4(0,colorLT.g,0,1) + fixed4(0,0,originalColor.b,1) + fixed4(colorRD.r,0,0,1);

                return col;
            }
            ENDCG
        }
    }
}