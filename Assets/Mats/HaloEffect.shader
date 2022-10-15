Shader "Custom/HaloEffect"
{
    Properties
    {
        _ColourA ("ColourA", Color) = (1, 1, 1, 1)
        _ColourB("ColourB", Color) = (1, 1, 1, 1)
        [KeywordEnum(Colour, Normal, UV, Blend)] 
        _Map("Maps", Float) = 0
        _Scale("Scale", Float) = 1
    }
        SubShader
        {
            Tags { "RenderType" = "Transparent"
                    "Queue" = "Transparent"}


            Pass
            {
                Cull Off
                ZWrite Off
                //ZTest GEqual
            Blend One One //additive
            //Blend DstColor Zero  //multiplicative

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _MAP_COLOUR _MAP_NORMAL _MAP_UV _MAP_BLEND
            #include "UnityCG.cginc"

            //Properties defined as variables
            float4 _ColourA;
            float4 _ColourB;
            float _Scale;

            #define TAU 6.28318530718 //2*PI

            struct appdata //Mesh data
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normals : NORMAL;
            };

            struct v2f //interpolator
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD1; //a data stream from the vertex shader
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = v.normals;
                UnityObjectToWorldNormal(v.normals);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
            #if _MAP_COLOUR
                return _ColourA;
            #elif _MAP_NORMAL
                return float4 (i.normal, 1);
            #elif _MAP_UV
                return float4(i.uv, 0, 1);
            #elif _MAP_BLEND
                float xOffset = cos(i.uv.x * TAU * 4) * 0.05;
            float t = cos((i.uv.y + xOffset - _Time.y * 0.1f) * TAU * 5 +
                _Time.y * _Scale) * 0.5 + 0.5;
                t *= 1 - i.uv.y;
                float topBottomRemover = (abs(i.normal.y) < 0.999);
                float waves = t * topBottomRemover;
                float4 gradient = lerp(_ColourA, _ColourB, t);
                return gradient * waves;
            #endif

            }
            ENDCG
        }
    }
}
