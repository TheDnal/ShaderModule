Shader "Custom/WaveEffect"
{
    Properties
    {
        _WaveCentreX("WaveCentreX", Float) = 0
        _WaveCentreY("WaveCentreY", Float) = 0
        _Color("Color", Color) = (1,0,0,1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"
                "Queue" = "Transparent" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            //define properties
            float _WaveCentreX;
            float _WaveCentreY;
            float4 _Color;
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
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                float2 waveCentre = (_WaveCentreX,_WaveCentreY);
                float dist = distance(i.uv, waveCentre);
                float4 white = (1,1,1,1);
                float4 wave = cos(dist * 10 + _Time.y);
                fixed4 col = lerp(white, _Color, wave);
                
                return col;
            }
            ENDCG
        }
    }
}
