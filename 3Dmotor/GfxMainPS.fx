//struct vs_output
//{
//    float4 Pos  : POSITION;
 //   float4 ShadowColor : COLOR0;
  //  float4 LightColor : COLOR1;
//    float2 TexDiffuse : TEXCOORD;// : TEXCOORD;
//    float2 TexShadow : TEXCOORD1;// : TEXCOORD1;
//};

sampler DiffuseTex, Shadow;
float4 fBias : register(c4);

// could be
//ps.1.1
//tex t0
//tex t1
//mul_x4_sat r0.rgb, v0, t0
//+add_x4_sat r0.a, t1, -v1
//mul_x4_sat r1.rgb, v1, t0
//+add r0.a, c4, r0
//cnd r0.rgb, r0.a, r0, r1
//+mul r0.a, t0.a, v0.a

float4 PS( vs_output vs ) : COLOR
{
	float4 diffuse = tex2D( DiffuseTex, vs.TexDiffuse );
	float3 light = saturate( vs.LightColor * diffuse * 4 );
	float3 shade = saturate( vs.ShadowColor * diffuse * 4 );
	float4 res;
	res.a = saturate( ( tex2D( Shadow, vs.TexShadow ).a - vs.LightColor.a ) * 4 ) + fBias.w;
	if ( res.a > 0.5 )
		res.xyz = light;
	else
		res.xyz = shade;
	res.a = diffuse.a * vs.ShadowColor.a;
	return res;
}
