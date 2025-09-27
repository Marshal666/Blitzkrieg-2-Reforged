float4x4 ProjMatrix : register( c10 );
//float4 Color : register(c16);

sampler DiffuseTex, Dif2Tex;
// = sampler_state
//{  
//    Texture = (EnvironmentMap); 
//}; 

//struct vs_output
//{
//   float4 Pos  : POSITION;
//    float4 Diff : COLOR0;
//    //float4 Spec : COLOR1;
//    float2 Tex0 : TEXCOORD;// : TEXCOORD;
//    float2 TexDepth : TEXCOORD1;// : TEXCOORD1;
//};

float4 depthMapU, depthMapV, depthMapScale; // 25, 26, 27
float2 NonLinearDepthMapProjection( float4 pos )
{
	float2 uv;
	uv.x = dot( pos, depthMapU );
	uv.y = dot( pos, depthMapV );
	uv  = uv / sqrt( 1 + uv * uv );
	return uv * depthMapScale.xy + depthMapScale.zw;
}

float3 LightDir;// 35
float2 WarFogParams;
float4 ColorsMult;

void CalcLightColors( out float4 Color1, float4 normal, float4 v4, float4 v5, float3 vertexColor )
{
	float fTest = dot( normal, LightDir );
	float fWarfog = v4.w * WarFogParams.y + v5.w * WarFogParams.x;
	float3 ColorMult = fWarfog * vertexColor;
	float4 res;
	res.xyz = ColorMult * v4;	
	res.w = normal.w * ColorsMult.w;
	Color1 = res;
	//Out.Spec.xyz = 
}
//{
//	NonLinearDepthMapProjection oT1
//	locals rTest, rLight, rWarFog // calc light
//	dp3 rTest.x, normal, c35
//	mul rWarFog.w, v4.w, c30.y
//	mad rWarFog.w, v5.w, c30.x, rWarFog.w
//	mul rWarFog.xyz, rWarFog.w, vertexColor
//	mul oD0.xyz, v4, rWarFog
//	mul oD0.w, v1.w, c29.w
//	mul oD1.xyz, v5, rWarFog
//	mul oT0.xy, v3, c6.xx
//	locals rDepth        // calc depth
//	sge rDepth.y, -rTest.x, c35.w
//	dp4 rDepth.x, v0, c16           
//	add oD1.w, rDepth.x, rDepth.y
//}
//		res += "dcl_position v0;\n";
//		res += "dcl_normal v1;\n";
//		res += "dcl_texcoord0 v3;\n";
//		res += "dcl_tangent0 v4;\n";
//		res += "dcl_tangent1 v5;\n";
//		res += "dcl_texcoord1 v6;\n";
struct vs_input
{
    float4 Pos  : POSITION;
    float4 Norm : NORMAL;
    float2 Tex0 : TEXCOORD0;
    float4 v4 : TANGENT0;
    float4 v5 : TANGENT1;
    float2 Tex1  : TEXCOORD1;
};

float4 TexCoordScale : register(c6);
vs_output VS( vs_input inp )
{
    vs_output Out;// = (VS_OUTPUT)0;
    Out.Pos = mul( inp.Pos, ProjMatrix );

//proc G3DiffuseTex
	//m4x4 oPos, v0, c10
	//locals rColor, normal
	//mul rColor.xyz, v1.w, c29
	//CalcNormal normal
	//CalcG3DiffuseTex rColor normal
//    Out.Tex0 = Tex;
//    float2 tmp = Tex  + float2(1,1);
//    Out.Tex1 = tmp;
//    Out.Diff = Color;
//    Out.Spec = float4(0,0,0,0);
//    Out.fake = float2(0,0);
	//Out.Diff = float4(0,0,0,0);//Color;
	CalcLightColors( Out.ShadowColor, inp.Norm, inp.v4, inp.v5, inp.Norm.w * ColorsMult );
	Out.LightColor = float4(0,0,0,0);
	Out.TexDiffuse = inp.Tex0 * TexCoordScale.x;
	Out.TexShadow = float2(0,0);//NonLinearDepthMapProjection( Pos );

    return Out;
}
