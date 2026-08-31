//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Universal Render Pipeline/Particles/Unlit" {
Properties {
_BaseMap ("Base Map", 2D) = "white" { }
_BaseColor ("Base Color", Color) = (1,1,1,1)
_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_BumpMap ("Normal Map", 2D) = "bump" { }
_EmissionColor ("Color", Color) = (0,0,0,1)
_EmissionMap ("Emission", 2D) = "white" { }
_SoftParticlesNearFadeDistance ("Soft Particles Near Fade", Float) = 0
_SoftParticlesFarFadeDistance ("Soft Particles Far Fade", Float) = 1
_CameraNearFadeDistance ("Camera Near Fade", Float) = 1
_CameraFarFadeDistance ("Camera Far Fade", Float) = 2
_DistortionBlend ("Distortion Blend", Float) = 0.5
_DistortionStrength ("Distortion Strength", Float) = 1
_Surface ("__surface", Float) = 0
_Blend ("__mode", Float) = 0
_AlphaClip ("__clip", Float) = 0
_BlendOp ("__blendop", Float) = 0
_SrcBlend ("__src", Float) = 1
_DstBlend ("__dst", Float) = 0
_ZWrite ("__zw", Float) = 1
_Cull ("__cull", Float) = 2
_ColorMode ("_ColorMode", Float) = 0
_BaseColorAddSubDiff ("_ColorMode", Vector) = (0,0,0,0)
[ToggleOff] _FlipbookBlending ("__flipbookblending", Float) = 0
_SoftParticlesEnabled ("__softparticlesenabled", Float) = 0
_CameraFadingEnabled ("__camerafadingenabled", Float) = 0
_SoftParticleFadeParams ("__softparticlefadeparams", Vector) = (0,0,0,0)
_CameraFadeParams ("__camerafadeparams", Vector) = (0,0,0,0)
_DistortionEnabled ("__distortionenabled", Float) = 0
_DistortionStrengthScaled ("Distortion Strength Scaled", Float) = 0.1
_QueueOffset ("Queue offset", Float) = 0
_FlipbookMode ("flipbook", Float) = 0
_Mode ("mode", Float) = 0
_Color ("color", Color) = (1,1,1,1)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderPipeline" = "UniversalPipeline" "RenderType" = "Opaque" }
 Pass {
  Name "ForwardLit"
  Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderPipeline" = "UniversalPipeline" "RenderType" = "Opaque" }
  Blend Zero Zero, Zero Zero
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 3110
Program "vp" {
SubProgram "gles3 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _SoftParticleFadeParams;
	UNITY_UNIFORM vec4 _CameraFadeParams;
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM mediump vec4 _EmissionColor;
	UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
	UNITY_UNIFORM mediump float _Cutoff;
	UNITY_UNIFORM mediump float _DistortionStrengthScaled;
	UNITY_UNIFORM mediump float _DistortionBlend;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * _BaseColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 198
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %19 %27 %87 %128 %160 %163 %187 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %9 Location 9 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 15 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate vs_TEXCOORD1 Location 19 
                                                      OpDecorate %27 Location 27 
                                                      OpDecorate %32 ArrayStride 32 
                                                      OpDecorate %33 ArrayStride 33 
                                                      OpDecorate %35 ArrayStride 35 
                                                      OpMemberDecorate %36 0 Offset 36 
                                                      OpMemberDecorate %36 1 Offset 36 
                                                      OpMemberDecorate %36 2 Offset 36 
                                                      OpMemberDecorate %36 3 RelaxedPrecision 
                                                      OpMemberDecorate %36 3 Offset 36 
                                                      OpMemberDecorate %36 4 RelaxedPrecision 
                                                      OpMemberDecorate %36 4 Offset 36 
                                                      OpMemberDecorate %36 5 RelaxedPrecision 
                                                      OpMemberDecorate %36 5 Offset 36 
                                                      OpMemberDecorate %36 6 Offset 36 
                                                      OpMemberDecorate %36 7 RelaxedPrecision 
                                                      OpMemberDecorate %36 7 Offset 36 
                                                      OpMemberDecorate %36 8 Offset 36 
                                                      OpMemberDecorate %36 9 Offset 36 
                                                      OpMemberDecorate %36 10 RelaxedPrecision 
                                                      OpMemberDecorate %36 10 Offset 36 
                                                      OpMemberDecorate %36 11 RelaxedPrecision 
                                                      OpMemberDecorate %36 11 Offset 36 
                                                      OpMemberDecorate %36 12 RelaxedPrecision 
                                                      OpMemberDecorate %36 12 Offset 36 
                                                      OpMemberDecorate %36 13 RelaxedPrecision 
                                                      OpMemberDecorate %36 13 Offset 36 
                                                      OpMemberDecorate %36 14 RelaxedPrecision 
                                                      OpMemberDecorate %36 14 Offset 36 
                                                      OpMemberDecorate %36 15 RelaxedPrecision 
                                                      OpMemberDecorate %36 15 Offset 36 
                                                      OpMemberDecorate %36 16 RelaxedPrecision 
                                                      OpMemberDecorate %36 16 Offset 36 
                                                      OpDecorate %36 Block 
                                                      OpDecorate %38 DescriptorSet 38 
                                                      OpDecorate %38 Binding 38 
                                                      OpDecorate %87 Location 87 
                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD2 Location 128 
                                                      OpDecorate %134 ArrayStride 134 
                                                      OpMemberDecorate %135 0 Offset 135 
                                                      OpMemberDecorate %135 1 Offset 135 
                                                      OpDecorate %135 Block 
                                                      OpDecorate %137 DescriptorSet 137 
                                                      OpDecorate %137 Binding 137 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 160 
                                                      OpDecorate vs_TEXCOORD8 Location 163 
                                                      OpMemberDecorate %185 0 BuiltIn 185 
                                                      OpMemberDecorate %185 1 BuiltIn 185 
                                                      OpMemberDecorate %185 2 BuiltIn 185 
                                                      OpDecorate %185 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Output %7 
                                 Output f32_4* %9 = OpVariable Output 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %13 = OpTypeVector %6 2 
                                              %14 = OpTypePointer Output %13 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                              %16 = OpTypePointer Input %13 
                                 Input f32_2* %17 = OpVariable Input 
                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
                                          f32 %20 = OpConstant 3.674022E-40 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 3 
                                              %23 = OpTypePointer Output %6 
                                              %25 = OpTypePointer Private %7 
                               Private f32_4* %26 = OpVariable Private 
                                 Input f32_4* %27 = OpVariable Input 
                                              %28 = OpTypeVector %6 3 
                                          u32 %31 = OpConstant 4 
                                              %32 = OpTypeArray %7 %31 
                                              %33 = OpTypeArray %7 %31 
                                          u32 %34 = OpConstant 2 
                                              %35 = OpTypeArray %7 %34 
                                              %36 = OpTypeStruct %32 %33 %7 %7 %7 %35 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %37 = OpTypePointer Uniform %36 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %38 = OpVariable Uniform 
                                              %39 = OpTypeInt 32 1 
                                          i32 %40 = OpConstant 0 
                                          i32 %41 = OpConstant 1 
                                              %42 = OpTypePointer Uniform %7 
                                          i32 %60 = OpConstant 2 
                                          i32 %74 = OpConstant 3 
                               Private f32_4* %85 = OpVariable Private 
                                              %86 = OpTypePointer Input %28 
                                 Input f32_3* %87 = OpVariable Input 
                                          u32 %93 = OpConstant 0 
                                              %94 = OpTypePointer Private %6 
                                         u32 %101 = OpConstant 1 
                                Private f32* %109 = OpVariable Private 
                                         f32 %116 = OpConstant 3.674022E-40 
                                             %127 = OpTypePointer Output %28 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %134 = OpTypeArray %7 %31 
                                             %135 = OpTypeStruct %28 %134 
                                             %136 = OpTypePointer Uniform %135 
          Uniform struct {f32_3; f32_4[4];}* %137 = OpVariable Uniform 
                                             %138 = OpTypePointer Uniform %28 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
                                       f32_3 %164 = OpConstantComposite %20 %20 %20 
                                             %184 = OpTypeArray %6 %101 
                                             %185 = OpTypeStruct %7 %6 %184 
                                             %186 = OpTypePointer Output %185 
        Output struct {f32_4; f32; f32[1];}* %187 = OpVariable Output 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                                      OpStore %9 %12 
                                        f32_2 %18 = OpLoad %17 
                                                      OpStore vs_TEXCOORD0 %18 
                                  Output f32* %24 = OpAccessChain vs_TEXCOORD1 %22 
                                                      OpStore %24 %20 
                                        f32_4 %29 = OpLoad %27 
                                        f32_3 %30 = OpVectorShuffle %29 %29 1 1 1 
                               Uniform f32_4* %43 = OpAccessChain %38 %40 %41 
                                        f32_4 %44 = OpLoad %43 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                        f32_3 %46 = OpFMul %30 %45 
                                        f32_4 %47 = OpLoad %26 
                                        f32_4 %48 = OpVectorShuffle %47 %46 4 5 6 3 
                                                      OpStore %26 %48 
                               Uniform f32_4* %49 = OpAccessChain %38 %40 %40 
                                        f32_4 %50 = OpLoad %49 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                        f32_4 %52 = OpLoad %27 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 0 0 
                                        f32_3 %54 = OpFMul %51 %53 
                                        f32_4 %55 = OpLoad %26 
                                        f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
                                        f32_3 %57 = OpFAdd %54 %56 
                                        f32_4 %58 = OpLoad %26 
                                        f32_4 %59 = OpVectorShuffle %58 %57 4 5 6 3 
                                                      OpStore %26 %59 
                               Uniform f32_4* %61 = OpAccessChain %38 %40 %60 
                                        f32_4 %62 = OpLoad %61 
                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
                                        f32_4 %64 = OpLoad %27 
                                        f32_3 %65 = OpVectorShuffle %64 %64 2 2 2 
                                        f32_3 %66 = OpFMul %63 %65 
                                        f32_4 %67 = OpLoad %26 
                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
                                        f32_3 %69 = OpFAdd %66 %68 
                                        f32_4 %70 = OpLoad %26 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %26 %71 
                                        f32_4 %72 = OpLoad %26 
                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
                               Uniform f32_4* %75 = OpAccessChain %38 %40 %74 
                                        f32_4 %76 = OpLoad %75 
                                        f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
                                        f32_3 %78 = OpFAdd %73 %77 
                                        f32_4 %79 = OpLoad %26 
                                        f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
                                                      OpStore %26 %80 
                                        f32_4 %81 = OpLoad %26 
                                        f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
                                        f32_4 %83 = OpLoad vs_TEXCOORD1 
                                        f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
                                                      OpStore vs_TEXCOORD1 %84 
                                        f32_3 %88 = OpLoad %87 
                               Uniform f32_4* %89 = OpAccessChain %38 %41 %40 
                                        f32_4 %90 = OpLoad %89 
                                        f32_3 %91 = OpVectorShuffle %90 %90 0 1 2 
                                          f32 %92 = OpDot %88 %91 
                                 Private f32* %95 = OpAccessChain %85 %93 
                                                      OpStore %95 %92 
                                        f32_3 %96 = OpLoad %87 
                               Uniform f32_4* %97 = OpAccessChain %38 %41 %41 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
                                         f32 %100 = OpDot %96 %99 
                                Private f32* %102 = OpAccessChain %85 %101 
                                                      OpStore %102 %100 
                                       f32_3 %103 = OpLoad %87 
                              Uniform f32_4* %104 = OpAccessChain %38 %41 %60 
                                       f32_4 %105 = OpLoad %104 
                                       f32_3 %106 = OpVectorShuffle %105 %105 0 1 2 
                                         f32 %107 = OpDot %103 %106 
                                Private f32* %108 = OpAccessChain %85 %34 
                                                      OpStore %108 %107 
                                       f32_4 %110 = OpLoad %85 
                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
                                       f32_4 %112 = OpLoad %85 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %111 %113 
                                                      OpStore %109 %114 
                                         f32 %115 = OpLoad %109 
                                         f32 %117 = OpExtInst %1 40 %115 %116 
                                                      OpStore %109 %117 
                                         f32 %118 = OpLoad %109 
                                         f32 %119 = OpExtInst %1 32 %118 
                                                      OpStore %109 %119 
                                         f32 %120 = OpLoad %109 
                                       f32_3 %121 = OpCompositeConstruct %120 %120 %120 
                                       f32_4 %122 = OpLoad %85 
                                       f32_3 %123 = OpVectorShuffle %122 %122 0 1 2 
                                       f32_3 %124 = OpFMul %121 %123 
                                       f32_4 %125 = OpLoad %85 
                                       f32_4 %126 = OpVectorShuffle %125 %124 4 5 6 3 
                                                      OpStore %85 %126 
                                       f32_4 %129 = OpLoad %85 
                                       f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
                                                      OpStore vs_TEXCOORD2 %130 
                                       f32_4 %131 = OpLoad %26 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_3 %133 = OpFNegate %132 
                              Uniform f32_3* %139 = OpAccessChain %137 %40 
                                       f32_3 %140 = OpLoad %139 
                                       f32_3 %141 = OpFAdd %133 %140 
                                       f32_4 %142 = OpLoad %85 
                                       f32_4 %143 = OpVectorShuffle %142 %141 4 5 6 3 
                                                      OpStore %85 %143 
                                       f32_4 %144 = OpLoad %85 
                                       f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
                                       f32_4 %146 = OpLoad %85 
                                       f32_3 %147 = OpVectorShuffle %146 %146 0 1 2 
                                         f32 %148 = OpDot %145 %147 
                                                      OpStore %109 %148 
                                         f32 %149 = OpLoad %109 
                                         f32 %150 = OpExtInst %1 40 %149 %116 
                                                      OpStore %109 %150 
                                         f32 %151 = OpLoad %109 
                                         f32 %152 = OpExtInst %1 32 %151 
                                                      OpStore %109 %152 
                                         f32 %153 = OpLoad %109 
                                       f32_3 %154 = OpCompositeConstruct %153 %153 %153 
                                       f32_4 %155 = OpLoad %85 
                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
                                       f32_3 %157 = OpFMul %154 %156 
                                       f32_4 %158 = OpLoad %85 
                                       f32_4 %159 = OpVectorShuffle %158 %157 4 5 6 3 
                                                      OpStore %85 %159 
                                       f32_4 %161 = OpLoad %85 
                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
                                                      OpStore vs_TEXCOORD3 %162 
                                                      OpStore vs_TEXCOORD8 %164 
                                       f32_4 %165 = OpLoad %26 
                                       f32_4 %166 = OpVectorShuffle %165 %165 1 1 1 1 
                              Uniform f32_4* %167 = OpAccessChain %137 %41 %41 
                                       f32_4 %168 = OpLoad %167 
                                       f32_4 %169 = OpFMul %166 %168 
                                                      OpStore %85 %169 
                              Uniform f32_4* %170 = OpAccessChain %137 %41 %40 
                                       f32_4 %171 = OpLoad %170 
                                       f32_4 %172 = OpLoad %26 
                                       f32_4 %173 = OpVectorShuffle %172 %172 0 0 0 0 
                                       f32_4 %174 = OpFMul %171 %173 
                                       f32_4 %175 = OpLoad %85 
                                       f32_4 %176 = OpFAdd %174 %175 
                                                      OpStore %85 %176 
                              Uniform f32_4* %177 = OpAccessChain %137 %41 %60 
                                       f32_4 %178 = OpLoad %177 
                                       f32_4 %179 = OpLoad %26 
                                       f32_4 %180 = OpVectorShuffle %179 %179 2 2 2 2 
                                       f32_4 %181 = OpFMul %178 %180 
                                       f32_4 %182 = OpLoad %85 
                                       f32_4 %183 = OpFAdd %181 %182 
                                                      OpStore %26 %183 
                                       f32_4 %188 = OpLoad %26 
                              Uniform f32_4* %189 = OpAccessChain %137 %41 %74 
                                       f32_4 %190 = OpLoad %189 
                                       f32_4 %191 = OpFAdd %188 %190 
                               Output f32_4* %192 = OpAccessChain %187 %40 
                                                      OpStore %192 %191 
                                 Output f32* %193 = OpAccessChain %187 %40 %101 
                                         f32 %194 = OpLoad %193 
                                         f32 %195 = OpFNegate %194 
                                 Output f32* %196 = OpAccessChain %187 %40 %101 
                                                      OpStore %196 %195 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 45
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %22 %38 %42 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %12 DescriptorSet 12 
                                                      OpDecorate %12 Binding 12 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 RelaxedPrecision 
                                                      OpDecorate %16 DescriptorSet 16 
                                                      OpDecorate %16 Binding 16 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 22 
                                                      OpDecorate %25 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpMemberDecorate %27 0 Offset 27 
                                                      OpMemberDecorate %27 1 Offset 27 
                                                      OpMemberDecorate %27 2 Offset 27 
                                                      OpMemberDecorate %27 3 RelaxedPrecision 
                                                      OpMemberDecorate %27 3 Offset 27 
                                                      OpMemberDecorate %27 4 RelaxedPrecision 
                                                      OpMemberDecorate %27 4 Offset 27 
                                                      OpMemberDecorate %27 5 RelaxedPrecision 
                                                      OpMemberDecorate %27 5 Offset 27 
                                                      OpMemberDecorate %27 6 RelaxedPrecision 
                                                      OpMemberDecorate %27 6 Offset 27 
                                                      OpMemberDecorate %27 7 RelaxedPrecision 
                                                      OpMemberDecorate %27 7 Offset 27 
                                                      OpMemberDecorate %27 8 RelaxedPrecision 
                                                      OpMemberDecorate %27 8 Offset 27 
                                                      OpDecorate %27 Block 
                                                      OpDecorate %29 DescriptorSet 29 
                                                      OpDecorate %29 Binding 29 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %35 RelaxedPrecision 
                                                      OpDecorate %36 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %38 Location 38 
                                                      OpDecorate %39 RelaxedPrecision 
                                                      OpDecorate %40 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %42 Location 42 
                                                      OpDecorate %43 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypePointer UniformConstant %10 
         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                              %14 = OpTypeSampler 
                                              %15 = OpTypePointer UniformConstant %14 
                     UniformConstant sampler* %16 = OpVariable UniformConstant 
                                              %18 = OpTypeSampledImage %10 
                                              %20 = OpTypeVector %6 2 
                                              %21 = OpTypePointer Input %20 
                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                               Private f32_4* %25 = OpVariable Private 
                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
                                              %28 = OpTypePointer Uniform %27 
Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
                                              %30 = OpTypeInt 32 1 
                                          i32 %31 = OpConstant 3 
                                              %32 = OpTypePointer Uniform %7 
                                              %37 = OpTypePointer Input %7 
                                 Input f32_4* %38 = OpVariable Input 
                                              %41 = OpTypePointer Output %7 
                                Output f32_4* %42 = OpVariable Output 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                          read_only Texture2D %13 = OpLoad %12 
                                      sampler %17 = OpLoad %16 
                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                                      OpStore %9 %24 
                                        f32_4 %26 = OpLoad %9 
                               Uniform f32_4* %33 = OpAccessChain %29 %31 
                                        f32_4 %34 = OpLoad %33 
                                        f32_4 %35 = OpFMul %26 %34 
                                                      OpStore %25 %35 
                                        f32_4 %36 = OpLoad %25 
                                        f32_4 %39 = OpLoad %38 
                                        f32_4 %40 = OpFMul %36 %39 
                                                      OpStore %25 %40 
                                        f32_4 %43 = OpLoad %25 
                                                      OpStore %42 %43 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_EMISSION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.w = 0.0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    vs_TEXCOORD3.xyz = u_xlat1.xyz;
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _SoftParticleFadeParams;
	UNITY_UNIFORM vec4 _CameraFadeParams;
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM mediump vec4 _EmissionColor;
	UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
	UNITY_UNIFORM mediump float _Cutoff;
	UNITY_UNIFORM mediump float _DistortionStrengthScaled;
	UNITY_UNIFORM mediump float _DistortionBlend;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _EmissionMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * _BaseColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = texture(_EmissionMap, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _EmissionColor.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "_EMISSION" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 198
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %19 %27 %87 %128 %160 %163 %187 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %9 Location 9 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 15 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate vs_TEXCOORD1 Location 19 
                                                      OpDecorate %27 Location 27 
                                                      OpDecorate %32 ArrayStride 32 
                                                      OpDecorate %33 ArrayStride 33 
                                                      OpDecorate %35 ArrayStride 35 
                                                      OpMemberDecorate %36 0 Offset 36 
                                                      OpMemberDecorate %36 1 Offset 36 
                                                      OpMemberDecorate %36 2 Offset 36 
                                                      OpMemberDecorate %36 3 RelaxedPrecision 
                                                      OpMemberDecorate %36 3 Offset 36 
                                                      OpMemberDecorate %36 4 RelaxedPrecision 
                                                      OpMemberDecorate %36 4 Offset 36 
                                                      OpMemberDecorate %36 5 RelaxedPrecision 
                                                      OpMemberDecorate %36 5 Offset 36 
                                                      OpMemberDecorate %36 6 Offset 36 
                                                      OpMemberDecorate %36 7 RelaxedPrecision 
                                                      OpMemberDecorate %36 7 Offset 36 
                                                      OpMemberDecorate %36 8 Offset 36 
                                                      OpMemberDecorate %36 9 Offset 36 
                                                      OpMemberDecorate %36 10 RelaxedPrecision 
                                                      OpMemberDecorate %36 10 Offset 36 
                                                      OpMemberDecorate %36 11 RelaxedPrecision 
                                                      OpMemberDecorate %36 11 Offset 36 
                                                      OpMemberDecorate %36 12 RelaxedPrecision 
                                                      OpMemberDecorate %36 12 Offset 36 
                                                      OpMemberDecorate %36 13 RelaxedPrecision 
                                                      OpMemberDecorate %36 13 Offset 36 
                                                      OpMemberDecorate %36 14 RelaxedPrecision 
                                                      OpMemberDecorate %36 14 Offset 36 
                                                      OpMemberDecorate %36 15 RelaxedPrecision 
                                                      OpMemberDecorate %36 15 Offset 36 
                                                      OpMemberDecorate %36 16 RelaxedPrecision 
                                                      OpMemberDecorate %36 16 Offset 36 
                                                      OpDecorate %36 Block 
                                                      OpDecorate %38 DescriptorSet 38 
                                                      OpDecorate %38 Binding 38 
                                                      OpDecorate %87 Location 87 
                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD2 Location 128 
                                                      OpDecorate %134 ArrayStride 134 
                                                      OpMemberDecorate %135 0 Offset 135 
                                                      OpMemberDecorate %135 1 Offset 135 
                                                      OpDecorate %135 Block 
                                                      OpDecorate %137 DescriptorSet 137 
                                                      OpDecorate %137 Binding 137 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 160 
                                                      OpDecorate vs_TEXCOORD8 Location 163 
                                                      OpMemberDecorate %185 0 BuiltIn 185 
                                                      OpMemberDecorate %185 1 BuiltIn 185 
                                                      OpMemberDecorate %185 2 BuiltIn 185 
                                                      OpDecorate %185 Block 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Output %7 
                                 Output f32_4* %9 = OpVariable Output 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %13 = OpTypeVector %6 2 
                                              %14 = OpTypePointer Output %13 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                              %16 = OpTypePointer Input %13 
                                 Input f32_2* %17 = OpVariable Input 
                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
                                          f32 %20 = OpConstant 3.674022E-40 
                                              %21 = OpTypeInt 32 0 
                                          u32 %22 = OpConstant 3 
                                              %23 = OpTypePointer Output %6 
                                              %25 = OpTypePointer Private %7 
                               Private f32_4* %26 = OpVariable Private 
                                 Input f32_4* %27 = OpVariable Input 
                                              %28 = OpTypeVector %6 3 
                                          u32 %31 = OpConstant 4 
                                              %32 = OpTypeArray %7 %31 
                                              %33 = OpTypeArray %7 %31 
                                          u32 %34 = OpConstant 2 
                                              %35 = OpTypeArray %7 %34 
                                              %36 = OpTypeStruct %32 %33 %7 %7 %7 %35 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %37 = OpTypePointer Uniform %36 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %38 = OpVariable Uniform 
                                              %39 = OpTypeInt 32 1 
                                          i32 %40 = OpConstant 0 
                                          i32 %41 = OpConstant 1 
                                              %42 = OpTypePointer Uniform %7 
                                          i32 %60 = OpConstant 2 
                                          i32 %74 = OpConstant 3 
                               Private f32_4* %85 = OpVariable Private 
                                              %86 = OpTypePointer Input %28 
                                 Input f32_3* %87 = OpVariable Input 
                                          u32 %93 = OpConstant 0 
                                              %94 = OpTypePointer Private %6 
                                         u32 %101 = OpConstant 1 
                                Private f32* %109 = OpVariable Private 
                                         f32 %116 = OpConstant 3.674022E-40 
                                             %127 = OpTypePointer Output %28 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                                             %134 = OpTypeArray %7 %31 
                                             %135 = OpTypeStruct %28 %134 
                                             %136 = OpTypePointer Uniform %135 
          Uniform struct {f32_3; f32_4[4];}* %137 = OpVariable Uniform 
                                             %138 = OpTypePointer Uniform %28 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
                                       f32_3 %164 = OpConstantComposite %20 %20 %20 
                                             %184 = OpTypeArray %6 %101 
                                             %185 = OpTypeStruct %7 %6 %184 
                                             %186 = OpTypePointer Output %185 
        Output struct {f32_4; f32; f32[1];}* %187 = OpVariable Output 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                                      OpStore %9 %12 
                                        f32_2 %18 = OpLoad %17 
                                                      OpStore vs_TEXCOORD0 %18 
                                  Output f32* %24 = OpAccessChain vs_TEXCOORD1 %22 
                                                      OpStore %24 %20 
                                        f32_4 %29 = OpLoad %27 
                                        f32_3 %30 = OpVectorShuffle %29 %29 1 1 1 
                               Uniform f32_4* %43 = OpAccessChain %38 %40 %41 
                                        f32_4 %44 = OpLoad %43 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                        f32_3 %46 = OpFMul %30 %45 
                                        f32_4 %47 = OpLoad %26 
                                        f32_4 %48 = OpVectorShuffle %47 %46 4 5 6 3 
                                                      OpStore %26 %48 
                               Uniform f32_4* %49 = OpAccessChain %38 %40 %40 
                                        f32_4 %50 = OpLoad %49 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                        f32_4 %52 = OpLoad %27 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 0 0 
                                        f32_3 %54 = OpFMul %51 %53 
                                        f32_4 %55 = OpLoad %26 
                                        f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
                                        f32_3 %57 = OpFAdd %54 %56 
                                        f32_4 %58 = OpLoad %26 
                                        f32_4 %59 = OpVectorShuffle %58 %57 4 5 6 3 
                                                      OpStore %26 %59 
                               Uniform f32_4* %61 = OpAccessChain %38 %40 %60 
                                        f32_4 %62 = OpLoad %61 
                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
                                        f32_4 %64 = OpLoad %27 
                                        f32_3 %65 = OpVectorShuffle %64 %64 2 2 2 
                                        f32_3 %66 = OpFMul %63 %65 
                                        f32_4 %67 = OpLoad %26 
                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
                                        f32_3 %69 = OpFAdd %66 %68 
                                        f32_4 %70 = OpLoad %26 
                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
                                                      OpStore %26 %71 
                                        f32_4 %72 = OpLoad %26 
                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
                               Uniform f32_4* %75 = OpAccessChain %38 %40 %74 
                                        f32_4 %76 = OpLoad %75 
                                        f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
                                        f32_3 %78 = OpFAdd %73 %77 
                                        f32_4 %79 = OpLoad %26 
                                        f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
                                                      OpStore %26 %80 
                                        f32_4 %81 = OpLoad %26 
                                        f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
                                        f32_4 %83 = OpLoad vs_TEXCOORD1 
                                        f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
                                                      OpStore vs_TEXCOORD1 %84 
                                        f32_3 %88 = OpLoad %87 
                               Uniform f32_4* %89 = OpAccessChain %38 %41 %40 
                                        f32_4 %90 = OpLoad %89 
                                        f32_3 %91 = OpVectorShuffle %90 %90 0 1 2 
                                          f32 %92 = OpDot %88 %91 
                                 Private f32* %95 = OpAccessChain %85 %93 
                                                      OpStore %95 %92 
                                        f32_3 %96 = OpLoad %87 
                               Uniform f32_4* %97 = OpAccessChain %38 %41 %41 
                                        f32_4 %98 = OpLoad %97 
                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
                                         f32 %100 = OpDot %96 %99 
                                Private f32* %102 = OpAccessChain %85 %101 
                                                      OpStore %102 %100 
                                       f32_3 %103 = OpLoad %87 
                              Uniform f32_4* %104 = OpAccessChain %38 %41 %60 
                                       f32_4 %105 = OpLoad %104 
                                       f32_3 %106 = OpVectorShuffle %105 %105 0 1 2 
                                         f32 %107 = OpDot %103 %106 
                                Private f32* %108 = OpAccessChain %85 %34 
                                                      OpStore %108 %107 
                                       f32_4 %110 = OpLoad %85 
                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
                                       f32_4 %112 = OpLoad %85 
                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
                                         f32 %114 = OpDot %111 %113 
                                                      OpStore %109 %114 
                                         f32 %115 = OpLoad %109 
                                         f32 %117 = OpExtInst %1 40 %115 %116 
                                                      OpStore %109 %117 
                                         f32 %118 = OpLoad %109 
                                         f32 %119 = OpExtInst %1 32 %118 
                                                      OpStore %109 %119 
                                         f32 %120 = OpLoad %109 
                                       f32_3 %121 = OpCompositeConstruct %120 %120 %120 
                                       f32_4 %122 = OpLoad %85 
                                       f32_3 %123 = OpVectorShuffle %122 %122 0 1 2 
                                       f32_3 %124 = OpFMul %121 %123 
                                       f32_4 %125 = OpLoad %85 
                                       f32_4 %126 = OpVectorShuffle %125 %124 4 5 6 3 
                                                      OpStore %85 %126 
                                       f32_4 %129 = OpLoad %85 
                                       f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
                                                      OpStore vs_TEXCOORD2 %130 
                                       f32_4 %131 = OpLoad %26 
                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
                                       f32_3 %133 = OpFNegate %132 
                              Uniform f32_3* %139 = OpAccessChain %137 %40 
                                       f32_3 %140 = OpLoad %139 
                                       f32_3 %141 = OpFAdd %133 %140 
                                       f32_4 %142 = OpLoad %85 
                                       f32_4 %143 = OpVectorShuffle %142 %141 4 5 6 3 
                                                      OpStore %85 %143 
                                       f32_4 %144 = OpLoad %85 
                                       f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
                                       f32_4 %146 = OpLoad %85 
                                       f32_3 %147 = OpVectorShuffle %146 %146 0 1 2 
                                         f32 %148 = OpDot %145 %147 
                                                      OpStore %109 %148 
                                         f32 %149 = OpLoad %109 
                                         f32 %150 = OpExtInst %1 40 %149 %116 
                                                      OpStore %109 %150 
                                         f32 %151 = OpLoad %109 
                                         f32 %152 = OpExtInst %1 32 %151 
                                                      OpStore %109 %152 
                                         f32 %153 = OpLoad %109 
                                       f32_3 %154 = OpCompositeConstruct %153 %153 %153 
                                       f32_4 %155 = OpLoad %85 
                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
                                       f32_3 %157 = OpFMul %154 %156 
                                       f32_4 %158 = OpLoad %85 
                                       f32_4 %159 = OpVectorShuffle %158 %157 4 5 6 3 
                                                      OpStore %85 %159 
                                       f32_4 %161 = OpLoad %85 
                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
                                                      OpStore vs_TEXCOORD3 %162 
                                                      OpStore vs_TEXCOORD8 %164 
                                       f32_4 %165 = OpLoad %26 
                                       f32_4 %166 = OpVectorShuffle %165 %165 1 1 1 1 
                              Uniform f32_4* %167 = OpAccessChain %137 %41 %41 
                                       f32_4 %168 = OpLoad %167 
                                       f32_4 %169 = OpFMul %166 %168 
                                                      OpStore %85 %169 
                              Uniform f32_4* %170 = OpAccessChain %137 %41 %40 
                                       f32_4 %171 = OpLoad %170 
                                       f32_4 %172 = OpLoad %26 
                                       f32_4 %173 = OpVectorShuffle %172 %172 0 0 0 0 
                                       f32_4 %174 = OpFMul %171 %173 
                                       f32_4 %175 = OpLoad %85 
                                       f32_4 %176 = OpFAdd %174 %175 
                                                      OpStore %85 %176 
                              Uniform f32_4* %177 = OpAccessChain %137 %41 %60 
                                       f32_4 %178 = OpLoad %177 
                                       f32_4 %179 = OpLoad %26 
                                       f32_4 %180 = OpVectorShuffle %179 %179 2 2 2 2 
                                       f32_4 %181 = OpFMul %178 %180 
                                       f32_4 %182 = OpLoad %85 
                                       f32_4 %183 = OpFAdd %181 %182 
                                                      OpStore %26 %183 
                                       f32_4 %188 = OpLoad %26 
                              Uniform f32_4* %189 = OpAccessChain %137 %41 %74 
                                       f32_4 %190 = OpLoad %189 
                                       f32_4 %191 = OpFAdd %188 %190 
                               Output f32_4* %192 = OpAccessChain %187 %40 
                                                      OpStore %192 %191 
                                 Output f32* %193 = OpAccessChain %187 %40 %101 
                                         f32 %194 = OpLoad %193 
                                         f32 %195 = OpFNegate %194 
                                 Output f32* %196 = OpAccessChain %187 %40 %101 
                                                      OpStore %196 %195 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 73
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %22 %38 %53 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %12 DescriptorSet 12 
                                                      OpDecorate %12 Binding 12 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 RelaxedPrecision 
                                                      OpDecorate %16 DescriptorSet 16 
                                                      OpDecorate %16 Binding 16 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 22 
                                                      OpDecorate %25 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpMemberDecorate %27 0 Offset 27 
                                                      OpMemberDecorate %27 1 Offset 27 
                                                      OpMemberDecorate %27 2 Offset 27 
                                                      OpMemberDecorate %27 3 RelaxedPrecision 
                                                      OpMemberDecorate %27 3 Offset 27 
                                                      OpMemberDecorate %27 4 RelaxedPrecision 
                                                      OpMemberDecorate %27 4 Offset 27 
                                                      OpMemberDecorate %27 5 RelaxedPrecision 
                                                      OpMemberDecorate %27 5 Offset 27 
                                                      OpMemberDecorate %27 6 RelaxedPrecision 
                                                      OpMemberDecorate %27 6 Offset 27 
                                                      OpMemberDecorate %27 7 RelaxedPrecision 
                                                      OpMemberDecorate %27 7 Offset 27 
                                                      OpMemberDecorate %27 8 RelaxedPrecision 
                                                      OpMemberDecorate %27 8 Offset 27 
                                                      OpDecorate %27 Block 
                                                      OpDecorate %29 DescriptorSet 29 
                                                      OpDecorate %29 Binding 29 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %35 RelaxedPrecision 
                                                      OpDecorate %36 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %38 Location 38 
                                                      OpDecorate %39 RelaxedPrecision 
                                                      OpDecorate %40 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %44 DescriptorSet 44 
                                                      OpDecorate %44 Binding 44 
                                                      OpDecorate %45 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %53 RelaxedPrecision 
                                                      OpDecorate %53 Location 53 
                                                      OpDecorate %54 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %62 RelaxedPrecision 
                                                      OpDecorate %69 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypePointer UniformConstant %10 
         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                              %14 = OpTypeSampler 
                                              %15 = OpTypePointer UniformConstant %14 
                     UniformConstant sampler* %16 = OpVariable UniformConstant 
                                              %18 = OpTypeSampledImage %10 
                                              %20 = OpTypeVector %6 2 
                                              %21 = OpTypePointer Input %20 
                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                               Private f32_4* %25 = OpVariable Private 
                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
                                              %28 = OpTypePointer Uniform %27 
Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
                                              %30 = OpTypeInt 32 1 
                                          i32 %31 = OpConstant 3 
                                              %32 = OpTypePointer Uniform %7 
                                              %37 = OpTypePointer Input %7 
                                 Input f32_4* %38 = OpVariable Input 
                                              %41 = OpTypeVector %6 3 
                                              %42 = OpTypePointer Private %41 
                               Private f32_3* %43 = OpVariable Private 
         UniformConstant read_only Texture2D* %44 = OpVariable UniformConstant 
                     UniformConstant sampler* %46 = OpVariable UniformConstant 
                                              %52 = OpTypePointer Output %7 
                                Output f32_4* %53 = OpVariable Output 
                                          i32 %55 = OpConstant 4 
                                              %65 = OpTypeInt 32 0 
                                          u32 %66 = OpConstant 3 
                                              %67 = OpTypePointer Private %6 
                                              %70 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                          read_only Texture2D %13 = OpLoad %12 
                                      sampler %17 = OpLoad %16 
                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                                      OpStore %9 %24 
                                        f32_4 %26 = OpLoad %9 
                               Uniform f32_4* %33 = OpAccessChain %29 %31 
                                        f32_4 %34 = OpLoad %33 
                                        f32_4 %35 = OpFMul %26 %34 
                                                      OpStore %25 %35 
                                        f32_4 %36 = OpLoad %25 
                                        f32_4 %39 = OpLoad %38 
                                        f32_4 %40 = OpFMul %36 %39 
                                                      OpStore %25 %40 
                          read_only Texture2D %45 = OpLoad %44 
                                      sampler %47 = OpLoad %46 
                   read_only Texture2DSampled %48 = OpSampledImage %45 %47 
                                        f32_2 %49 = OpLoad vs_TEXCOORD0 
                                        f32_4 %50 = OpImageSampleImplicitLod %48 %49 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                                      OpStore %43 %51 
                                        f32_3 %54 = OpLoad %43 
                               Uniform f32_4* %56 = OpAccessChain %29 %55 
                                        f32_4 %57 = OpLoad %56 
                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
                                        f32_3 %59 = OpFMul %54 %58 
                                        f32_4 %60 = OpLoad %25 
                                        f32_3 %61 = OpVectorShuffle %60 %60 0 1 2 
                                        f32_3 %62 = OpFAdd %59 %61 
                                        f32_4 %63 = OpLoad %53 
                                        f32_4 %64 = OpVectorShuffle %63 %62 4 5 6 3 
                                                      OpStore %53 %64 
                                 Private f32* %68 = OpAccessChain %25 %66 
                                          f32 %69 = OpLoad %68 
                                  Output f32* %71 = OpAccessChain %53 %66 
                                                      OpStore %71 %69 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
#else
    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
#endif
    gl_Position = u_xlat1;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _SoftParticleFadeParams;
	UNITY_UNIFORM vec4 _CameraFadeParams;
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM mediump vec4 _EmissionColor;
	UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
	UNITY_UNIFORM mediump float _Cutoff;
	UNITY_UNIFORM mediump float _DistortionStrengthScaled;
	UNITY_UNIFORM mediump float _DistortionBlend;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * _BaseColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.www;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_LINEAR" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 206
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %22 %106 %120 %145 %183 %197 %199 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %9 Location 9 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 15 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %22 Location 22 
                                                      OpDecorate %27 ArrayStride 27 
                                                      OpDecorate %28 ArrayStride 28 
                                                      OpDecorate %30 ArrayStride 30 
                                                      OpMemberDecorate %31 0 Offset 31 
                                                      OpMemberDecorate %31 1 Offset 31 
                                                      OpMemberDecorate %31 2 Offset 31 
                                                      OpMemberDecorate %31 3 RelaxedPrecision 
                                                      OpMemberDecorate %31 3 Offset 31 
                                                      OpMemberDecorate %31 4 RelaxedPrecision 
                                                      OpMemberDecorate %31 4 Offset 31 
                                                      OpMemberDecorate %31 5 RelaxedPrecision 
                                                      OpMemberDecorate %31 5 Offset 31 
                                                      OpMemberDecorate %31 6 Offset 31 
                                                      OpMemberDecorate %31 7 RelaxedPrecision 
                                                      OpMemberDecorate %31 7 Offset 31 
                                                      OpMemberDecorate %31 8 Offset 31 
                                                      OpMemberDecorate %31 9 Offset 31 
                                                      OpMemberDecorate %31 10 RelaxedPrecision 
                                                      OpMemberDecorate %31 10 Offset 31 
                                                      OpMemberDecorate %31 11 RelaxedPrecision 
                                                      OpMemberDecorate %31 11 Offset 31 
                                                      OpMemberDecorate %31 12 RelaxedPrecision 
                                                      OpMemberDecorate %31 12 Offset 31 
                                                      OpMemberDecorate %31 13 RelaxedPrecision 
                                                      OpMemberDecorate %31 13 Offset 31 
                                                      OpMemberDecorate %31 14 RelaxedPrecision 
                                                      OpMemberDecorate %31 14 Offset 31 
                                                      OpMemberDecorate %31 15 RelaxedPrecision 
                                                      OpMemberDecorate %31 15 Offset 31 
                                                      OpMemberDecorate %31 16 RelaxedPrecision 
                                                      OpMemberDecorate %31 16 Offset 31 
                                                      OpDecorate %31 Block 
                                                      OpDecorate %33 DescriptorSet 33 
                                                      OpDecorate %33 Binding 33 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpMemberDecorate %70 2 Offset 70 
                                                      OpMemberDecorate %70 3 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %104 0 BuiltIn 104 
                                                      OpMemberDecorate %104 1 BuiltIn 104 
                                                      OpMemberDecorate %104 2 BuiltIn 104 
                                                      OpDecorate %104 Block 
                                                      OpDecorate vs_TEXCOORD1 Location 120 
                                                      OpDecorate %145 Location 145 
                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD2 Location 183 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 197 
                                                      OpDecorate vs_TEXCOORD8 Location 199 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Output %7 
                                 Output f32_4* %9 = OpVariable Output 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %13 = OpTypeVector %6 2 
                                              %14 = OpTypePointer Output %13 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                              %16 = OpTypePointer Input %13 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 3 
                                              %20 = OpTypePointer Private %19 
                               Private f32_3* %21 = OpVariable Private 
                                 Input f32_4* %22 = OpVariable Input 
                                              %25 = OpTypeInt 32 0 
                                          u32 %26 = OpConstant 4 
                                              %27 = OpTypeArray %7 %26 
                                              %28 = OpTypeArray %7 %26 
                                          u32 %29 = OpConstant 2 
                                              %30 = OpTypeArray %7 %29 
                                              %31 = OpTypeStruct %27 %28 %7 %7 %7 %30 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %32 = OpTypePointer Uniform %31 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %33 = OpVariable Uniform 
                                              %34 = OpTypeInt 32 1 
                                          i32 %35 = OpConstant 0 
                                          i32 %36 = OpConstant 1 
                                              %37 = OpTypePointer Uniform %7 
                                          i32 %50 = OpConstant 2 
                                          i32 %60 = OpConstant 3 
                                              %65 = OpTypePointer Private %7 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %26 
                                              %70 = OpTypeStruct %19 %7 %7 %69 
                                              %71 = OpTypePointer Uniform %70 
Uniform struct {f32_3; f32_4; f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                              %94 = OpTypePointer Private %6 
                                 Private f32* %95 = OpVariable Private 
                                          u32 %98 = OpConstant 1 
                                              %99 = OpTypePointer Uniform %6 
                                             %103 = OpTypeArray %6 %98 
                                             %104 = OpTypeStruct %7 %6 %103 
                                             %105 = OpTypePointer Output %104 
        Output struct {f32_4; f32; f32[1];}* %106 = OpVariable Output 
                                         f32 %111 = OpConstant 3.674022E-40 
                                         f32 %118 = OpConstant 3.674022E-40 
                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
                                         u32 %125 = OpConstant 3 
                                             %129 = OpTypePointer Output %6 
                                             %140 = OpTypePointer Uniform %19 
                                             %144 = OpTypePointer Input %19 
                                Input f32_3* %145 = OpVariable Input 
                                         u32 %151 = OpConstant 0 
                                         f32 %171 = OpConstant 3.674022E-40 
                                             %182 = OpTypePointer Output %19 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
                                       f32_3 %200 = OpConstantComposite %118 %118 %118 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                                      OpStore %9 %12 
                                        f32_2 %18 = OpLoad %17 
                                                      OpStore vs_TEXCOORD0 %18 
                                        f32_4 %23 = OpLoad %22 
                                        f32_3 %24 = OpVectorShuffle %23 %23 1 1 1 
                               Uniform f32_4* %38 = OpAccessChain %33 %35 %36 
                                        f32_4 %39 = OpLoad %38 
                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
                                        f32_3 %41 = OpFMul %24 %40 
                                                      OpStore %21 %41 
                               Uniform f32_4* %42 = OpAccessChain %33 %35 %35 
                                        f32_4 %43 = OpLoad %42 
                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                                        f32_4 %45 = OpLoad %22 
                                        f32_3 %46 = OpVectorShuffle %45 %45 0 0 0 
                                        f32_3 %47 = OpFMul %44 %46 
                                        f32_3 %48 = OpLoad %21 
                                        f32_3 %49 = OpFAdd %47 %48 
                                                      OpStore %21 %49 
                               Uniform f32_4* %51 = OpAccessChain %33 %35 %50 
                                        f32_4 %52 = OpLoad %51 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_4 %54 = OpLoad %22 
                                        f32_3 %55 = OpVectorShuffle %54 %54 2 2 2 
                                        f32_3 %56 = OpFMul %53 %55 
                                        f32_3 %57 = OpLoad %21 
                                        f32_3 %58 = OpFAdd %56 %57 
                                                      OpStore %21 %58 
                                        f32_3 %59 = OpLoad %21 
                               Uniform f32_4* %61 = OpAccessChain %33 %35 %60 
                                        f32_4 %62 = OpLoad %61 
                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
                                        f32_3 %64 = OpFAdd %59 %63 
                                                      OpStore %21 %64 
                                        f32_3 %67 = OpLoad %21 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %60 %36 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %60 %35 
                                        f32_4 %77 = OpLoad %76 
                                        f32_3 %78 = OpLoad %21 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %60 %50 
                                        f32_4 %84 = OpLoad %83 
                                        f32_3 %85 = OpLoad %21 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %66 %89 
                                        f32_4 %90 = OpLoad %66 
                               Uniform f32_4* %91 = OpAccessChain %72 %60 %60 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %66 %93 
                                 Private f32* %96 = OpAccessChain %66 %29 
                                          f32 %97 = OpLoad %96 
                                Uniform f32* %100 = OpAccessChain %72 %36 %98 
                                         f32 %101 = OpLoad %100 
                                         f32 %102 = OpFDiv %97 %101 
                                                      OpStore %95 %102 
                                       f32_4 %107 = OpLoad %66 
                               Output f32_4* %108 = OpAccessChain %106 %35 
                                                      OpStore %108 %107 
                                         f32 %109 = OpLoad %95 
                                         f32 %110 = OpFNegate %109 
                                         f32 %112 = OpFAdd %110 %111 
                                                      OpStore %95 %112 
                                         f32 %113 = OpLoad %95 
                                Uniform f32* %114 = OpAccessChain %72 %36 %29 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFMul %113 %115 
                                                      OpStore %95 %116 
                                         f32 %117 = OpLoad %95 
                                         f32 %119 = OpExtInst %1 40 %117 %118 
                                                      OpStore %95 %119 
                                         f32 %121 = OpLoad %95 
                                Uniform f32* %122 = OpAccessChain %72 %50 %29 
                                         f32 %123 = OpLoad %122 
                                         f32 %124 = OpFMul %121 %123 
                                Uniform f32* %126 = OpAccessChain %72 %50 %125 
                                         f32 %127 = OpLoad %126 
                                         f32 %128 = OpFAdd %124 %127 
                                 Output f32* %130 = OpAccessChain vs_TEXCOORD1 %125 
                                                      OpStore %130 %128 
                                 Output f32* %131 = OpAccessChain vs_TEXCOORD1 %125 
                                         f32 %132 = OpLoad %131 
                                         f32 %133 = OpExtInst %1 43 %132 %118 %111 
                                 Output f32* %134 = OpAccessChain vs_TEXCOORD1 %125 
                                                      OpStore %134 %133 
                                       f32_3 %135 = OpLoad %21 
                                       f32_4 %136 = OpLoad vs_TEXCOORD1 
                                       f32_4 %137 = OpVectorShuffle %136 %135 4 5 6 3 
                                                      OpStore vs_TEXCOORD1 %137 
                                       f32_3 %138 = OpLoad %21 
                                       f32_3 %139 = OpFNegate %138 
                              Uniform f32_3* %141 = OpAccessChain %72 %35 
                                       f32_3 %142 = OpLoad %141 
                                       f32_3 %143 = OpFAdd %139 %142 
                                                      OpStore %21 %143 
                                       f32_3 %146 = OpLoad %145 
                              Uniform f32_4* %147 = OpAccessChain %33 %36 %35 
                                       f32_4 %148 = OpLoad %147 
                                       f32_3 %149 = OpVectorShuffle %148 %148 0 1 2 
                                         f32 %150 = OpDot %146 %149 
                                Private f32* %152 = OpAccessChain %66 %151 
                                                      OpStore %152 %150 
                                       f32_3 %153 = OpLoad %145 
                              Uniform f32_4* %154 = OpAccessChain %33 %36 %36 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
                                         f32 %157 = OpDot %153 %156 
                                Private f32* %158 = OpAccessChain %66 %98 
                                                      OpStore %158 %157 
                                       f32_3 %159 = OpLoad %145 
                              Uniform f32_4* %160 = OpAccessChain %33 %36 %50 
                                       f32_4 %161 = OpLoad %160 
                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
                                         f32 %163 = OpDot %159 %162 
                                Private f32* %164 = OpAccessChain %66 %29 
                                                      OpStore %164 %163 
                                       f32_4 %165 = OpLoad %66 
                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                       f32_4 %167 = OpLoad %66 
                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
                                         f32 %169 = OpDot %166 %168 
                                                      OpStore %95 %169 
                                         f32 %170 = OpLoad %95 
                                         f32 %172 = OpExtInst %1 40 %170 %171 
                                                      OpStore %95 %172 
                                         f32 %173 = OpLoad %95 
                                         f32 %174 = OpExtInst %1 32 %173 
                                                      OpStore %95 %174 
                                         f32 %175 = OpLoad %95 
                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
                                       f32_4 %177 = OpLoad %66 
                                       f32_3 %178 = OpVectorShuffle %177 %177 0 1 2 
                                       f32_3 %179 = OpFMul %176 %178 
                                       f32_4 %180 = OpLoad %66 
                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
                                                      OpStore %66 %181 
                                       f32_4 %184 = OpLoad %66 
                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
                                                      OpStore vs_TEXCOORD2 %185 
                                       f32_3 %186 = OpLoad %21 
                                       f32_3 %187 = OpLoad %21 
                                         f32 %188 = OpDot %186 %187 
                                                      OpStore %95 %188 
                                         f32 %189 = OpLoad %95 
                                         f32 %190 = OpExtInst %1 40 %189 %171 
                                                      OpStore %95 %190 
                                         f32 %191 = OpLoad %95 
                                         f32 %192 = OpExtInst %1 32 %191 
                                                      OpStore %95 %192 
                                         f32 %193 = OpLoad %95 
                                       f32_3 %194 = OpCompositeConstruct %193 %193 %193 
                                       f32_3 %195 = OpLoad %21 
                                       f32_3 %196 = OpFMul %194 %195 
                                                      OpStore %21 %196 
                                       f32_3 %198 = OpLoad %21 
                                                      OpStore vs_TEXCOORD3 %198 
                                                      OpStore vs_TEXCOORD8 %200 
                                 Output f32* %201 = OpAccessChain %106 %35 %98 
                                         f32 %202 = OpLoad %201 
                                         f32 %203 = OpFNegate %202 
                                 Output f32* %204 = OpAccessChain %106 %35 %98 
                                                      OpStore %204 %203 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 60
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %22 %38 %42 %46 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %12 DescriptorSet 12 
                                                      OpDecorate %12 Binding 12 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 RelaxedPrecision 
                                                      OpDecorate %16 DescriptorSet 16 
                                                      OpDecorate %16 Binding 16 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 22 
                                                      OpDecorate %25 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpMemberDecorate %27 0 Offset 27 
                                                      OpMemberDecorate %27 1 Offset 27 
                                                      OpMemberDecorate %27 2 Offset 27 
                                                      OpMemberDecorate %27 3 RelaxedPrecision 
                                                      OpMemberDecorate %27 3 Offset 27 
                                                      OpMemberDecorate %27 4 RelaxedPrecision 
                                                      OpMemberDecorate %27 4 Offset 27 
                                                      OpMemberDecorate %27 5 RelaxedPrecision 
                                                      OpMemberDecorate %27 5 Offset 27 
                                                      OpMemberDecorate %27 6 RelaxedPrecision 
                                                      OpMemberDecorate %27 6 Offset 27 
                                                      OpMemberDecorate %27 7 RelaxedPrecision 
                                                      OpMemberDecorate %27 7 Offset 27 
                                                      OpMemberDecorate %27 8 RelaxedPrecision 
                                                      OpMemberDecorate %27 8 Offset 27 
                                                      OpDecorate %27 Block 
                                                      OpDecorate %29 DescriptorSet 29 
                                                      OpDecorate %29 Binding 29 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %35 RelaxedPrecision 
                                                      OpDecorate %36 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %38 Location 38 
                                                      OpDecorate %39 RelaxedPrecision 
                                                      OpDecorate %40 RelaxedPrecision 
                                                      OpDecorate %42 RelaxedPrecision 
                                                      OpDecorate %42 Location 42 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %45 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD1 Location 46 
                                                      OpDecorate %56 RelaxedPrecision 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypePointer UniformConstant %10 
         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                              %14 = OpTypeSampler 
                                              %15 = OpTypePointer UniformConstant %14 
                     UniformConstant sampler* %16 = OpVariable UniformConstant 
                                              %18 = OpTypeSampledImage %10 
                                              %20 = OpTypeVector %6 2 
                                              %21 = OpTypePointer Input %20 
                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                               Private f32_4* %25 = OpVariable Private 
                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
                                              %28 = OpTypePointer Uniform %27 
Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
                                              %30 = OpTypeInt 32 1 
                                          i32 %31 = OpConstant 3 
                                              %32 = OpTypePointer Uniform %7 
                                              %37 = OpTypePointer Input %7 
                                 Input f32_4* %38 = OpVariable Input 
                                              %41 = OpTypePointer Output %7 
                                Output f32_4* %42 = OpVariable Output 
                                              %43 = OpTypeVector %6 3 
                        Input f32_4* vs_TEXCOORD1 = OpVariable Input 
                                              %52 = OpTypeInt 32 0 
                                          u32 %53 = OpConstant 3 
                                              %54 = OpTypePointer Private %6 
                                              %57 = OpTypePointer Output %6 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                          read_only Texture2D %13 = OpLoad %12 
                                      sampler %17 = OpLoad %16 
                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                                      OpStore %9 %24 
                                        f32_4 %26 = OpLoad %9 
                               Uniform f32_4* %33 = OpAccessChain %29 %31 
                                        f32_4 %34 = OpLoad %33 
                                        f32_4 %35 = OpFMul %26 %34 
                                                      OpStore %25 %35 
                                        f32_4 %36 = OpLoad %25 
                                        f32_4 %39 = OpLoad %38 
                                        f32_4 %40 = OpFMul %36 %39 
                                                      OpStore %25 %40 
                                        f32_4 %44 = OpLoad %25 
                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
                                        f32_4 %47 = OpLoad vs_TEXCOORD1 
                                        f32_3 %48 = OpVectorShuffle %47 %47 3 3 3 
                                        f32_3 %49 = OpFMul %45 %48 
                                        f32_4 %50 = OpLoad %42 
                                        f32_4 %51 = OpVectorShuffle %50 %49 4 5 6 3 
                                                      OpStore %42 %51 
                                 Private f32* %55 = OpAccessChain %25 %53 
                                          f32 %56 = OpLoad %55 
                                  Output f32* %58 = OpAccessChain %42 %53 
                                                      OpStore %58 %56 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "_EMISSION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 unity_FogParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
	UNITY_UNIFORM mediump vec4 unity_LightData;
	UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
	UNITY_UNIFORM vec4 unity_ProbesOcclusion;
	UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
	UNITY_UNIFORM vec4 unity_LightmapST;
	UNITY_UNIFORM vec4 unity_DynamicLightmapST;
	UNITY_UNIFORM mediump vec4 unity_SHAr;
	UNITY_UNIFORM mediump vec4 unity_SHAg;
	UNITY_UNIFORM mediump vec4 unity_SHAb;
	UNITY_UNIFORM mediump vec4 unity_SHBr;
	UNITY_UNIFORM mediump vec4 unity_SHBg;
	UNITY_UNIFORM mediump vec4 unity_SHBb;
	UNITY_UNIFORM mediump vec4 unity_SHC;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD8;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
#else
    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
#endif
    gl_Position = u_xlat1;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4 _SoftParticleFadeParams;
	UNITY_UNIFORM vec4 _CameraFadeParams;
	UNITY_UNIFORM vec4 _BaseMap_ST;
	UNITY_UNIFORM mediump vec4 _BaseColor;
	UNITY_UNIFORM mediump vec4 _EmissionColor;
	UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
	UNITY_UNIFORM mediump float _Cutoff;
	UNITY_UNIFORM mediump float _DistortionStrengthScaled;
	UNITY_UNIFORM mediump float _DistortionBlend;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
UNITY_LOCATION(1) uniform mediump sampler2D _EmissionMap;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_0 * _BaseColor;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = texture(_EmissionMap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * _EmissionColor.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD1.www;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "FOG_LINEAR" "_EMISSION" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 206
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %22 %106 %120 %145 %183 %197 %199 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %9 Location 9 
                                                      OpDecorate %11 RelaxedPrecision 
                                                      OpDecorate %11 Location 11 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 15 
                                                      OpDecorate %17 Location 17 
                                                      OpDecorate %22 Location 22 
                                                      OpDecorate %27 ArrayStride 27 
                                                      OpDecorate %28 ArrayStride 28 
                                                      OpDecorate %30 ArrayStride 30 
                                                      OpMemberDecorate %31 0 Offset 31 
                                                      OpMemberDecorate %31 1 Offset 31 
                                                      OpMemberDecorate %31 2 Offset 31 
                                                      OpMemberDecorate %31 3 RelaxedPrecision 
                                                      OpMemberDecorate %31 3 Offset 31 
                                                      OpMemberDecorate %31 4 RelaxedPrecision 
                                                      OpMemberDecorate %31 4 Offset 31 
                                                      OpMemberDecorate %31 5 RelaxedPrecision 
                                                      OpMemberDecorate %31 5 Offset 31 
                                                      OpMemberDecorate %31 6 Offset 31 
                                                      OpMemberDecorate %31 7 RelaxedPrecision 
                                                      OpMemberDecorate %31 7 Offset 31 
                                                      OpMemberDecorate %31 8 Offset 31 
                                                      OpMemberDecorate %31 9 Offset 31 
                                                      OpMemberDecorate %31 10 RelaxedPrecision 
                                                      OpMemberDecorate %31 10 Offset 31 
                                                      OpMemberDecorate %31 11 RelaxedPrecision 
                                                      OpMemberDecorate %31 11 Offset 31 
                                                      OpMemberDecorate %31 12 RelaxedPrecision 
                                                      OpMemberDecorate %31 12 Offset 31 
                                                      OpMemberDecorate %31 13 RelaxedPrecision 
                                                      OpMemberDecorate %31 13 Offset 31 
                                                      OpMemberDecorate %31 14 RelaxedPrecision 
                                                      OpMemberDecorate %31 14 Offset 31 
                                                      OpMemberDecorate %31 15 RelaxedPrecision 
                                                      OpMemberDecorate %31 15 Offset 31 
                                                      OpMemberDecorate %31 16 RelaxedPrecision 
                                                      OpMemberDecorate %31 16 Offset 31 
                                                      OpDecorate %31 Block 
                                                      OpDecorate %33 DescriptorSet 33 
                                                      OpDecorate %33 Binding 33 
                                                      OpDecorate %69 ArrayStride 69 
                                                      OpMemberDecorate %70 0 Offset 70 
                                                      OpMemberDecorate %70 1 Offset 70 
                                                      OpMemberDecorate %70 2 Offset 70 
                                                      OpMemberDecorate %70 3 Offset 70 
                                                      OpDecorate %70 Block 
                                                      OpDecorate %72 DescriptorSet 72 
                                                      OpDecorate %72 Binding 72 
                                                      OpMemberDecorate %104 0 BuiltIn 104 
                                                      OpMemberDecorate %104 1 BuiltIn 104 
                                                      OpMemberDecorate %104 2 BuiltIn 104 
                                                      OpDecorate %104 Block 
                                                      OpDecorate vs_TEXCOORD1 Location 120 
                                                      OpDecorate %145 Location 145 
                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD2 Location 183 
                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD3 Location 197 
                                                      OpDecorate vs_TEXCOORD8 Location 199 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Output %7 
                                 Output f32_4* %9 = OpVariable Output 
                                              %10 = OpTypePointer Input %7 
                                 Input f32_4* %11 = OpVariable Input 
                                              %13 = OpTypeVector %6 2 
                                              %14 = OpTypePointer Output %13 
                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                              %16 = OpTypePointer Input %13 
                                 Input f32_2* %17 = OpVariable Input 
                                              %19 = OpTypeVector %6 3 
                                              %20 = OpTypePointer Private %19 
                               Private f32_3* %21 = OpVariable Private 
                                 Input f32_4* %22 = OpVariable Input 
                                              %25 = OpTypeInt 32 0 
                                          u32 %26 = OpConstant 4 
                                              %27 = OpTypeArray %7 %26 
                                              %28 = OpTypeArray %7 %26 
                                          u32 %29 = OpConstant 2 
                                              %30 = OpTypeArray %7 %29 
                                              %31 = OpTypeStruct %27 %28 %7 %7 %7 %30 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
                                              %32 = OpTypePointer Uniform %31 
Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %33 = OpVariable Uniform 
                                              %34 = OpTypeInt 32 1 
                                          i32 %35 = OpConstant 0 
                                          i32 %36 = OpConstant 1 
                                              %37 = OpTypePointer Uniform %7 
                                          i32 %50 = OpConstant 2 
                                          i32 %60 = OpConstant 3 
                                              %65 = OpTypePointer Private %7 
                               Private f32_4* %66 = OpVariable Private 
                                              %69 = OpTypeArray %7 %26 
                                              %70 = OpTypeStruct %19 %7 %7 %69 
                                              %71 = OpTypePointer Uniform %70 
Uniform struct {f32_3; f32_4; f32_4; f32_4[4];}* %72 = OpVariable Uniform 
                                              %94 = OpTypePointer Private %6 
                                 Private f32* %95 = OpVariable Private 
                                          u32 %98 = OpConstant 1 
                                              %99 = OpTypePointer Uniform %6 
                                             %103 = OpTypeArray %6 %98 
                                             %104 = OpTypeStruct %7 %6 %103 
                                             %105 = OpTypePointer Output %104 
        Output struct {f32_4; f32; f32[1];}* %106 = OpVariable Output 
                                         f32 %111 = OpConstant 3.674022E-40 
                                         f32 %118 = OpConstant 3.674022E-40 
                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
                                         u32 %125 = OpConstant 3 
                                             %129 = OpTypePointer Output %6 
                                             %140 = OpTypePointer Uniform %19 
                                             %144 = OpTypePointer Input %19 
                                Input f32_3* %145 = OpVariable Input 
                                         u32 %151 = OpConstant 0 
                                         f32 %171 = OpConstant 3.674022E-40 
                                             %182 = OpTypePointer Output %19 
                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
                                       f32_3 %200 = OpConstantComposite %118 %118 %118 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                                        f32_4 %12 = OpLoad %11 
                                                      OpStore %9 %12 
                                        f32_2 %18 = OpLoad %17 
                                                      OpStore vs_TEXCOORD0 %18 
                                        f32_4 %23 = OpLoad %22 
                                        f32_3 %24 = OpVectorShuffle %23 %23 1 1 1 
                               Uniform f32_4* %38 = OpAccessChain %33 %35 %36 
                                        f32_4 %39 = OpLoad %38 
                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
                                        f32_3 %41 = OpFMul %24 %40 
                                                      OpStore %21 %41 
                               Uniform f32_4* %42 = OpAccessChain %33 %35 %35 
                                        f32_4 %43 = OpLoad %42 
                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
                                        f32_4 %45 = OpLoad %22 
                                        f32_3 %46 = OpVectorShuffle %45 %45 0 0 0 
                                        f32_3 %47 = OpFMul %44 %46 
                                        f32_3 %48 = OpLoad %21 
                                        f32_3 %49 = OpFAdd %47 %48 
                                                      OpStore %21 %49 
                               Uniform f32_4* %51 = OpAccessChain %33 %35 %50 
                                        f32_4 %52 = OpLoad %51 
                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
                                        f32_4 %54 = OpLoad %22 
                                        f32_3 %55 = OpVectorShuffle %54 %54 2 2 2 
                                        f32_3 %56 = OpFMul %53 %55 
                                        f32_3 %57 = OpLoad %21 
                                        f32_3 %58 = OpFAdd %56 %57 
                                                      OpStore %21 %58 
                                        f32_3 %59 = OpLoad %21 
                               Uniform f32_4* %61 = OpAccessChain %33 %35 %60 
                                        f32_4 %62 = OpLoad %61 
                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
                                        f32_3 %64 = OpFAdd %59 %63 
                                                      OpStore %21 %64 
                                        f32_3 %67 = OpLoad %21 
                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
                               Uniform f32_4* %73 = OpAccessChain %72 %60 %36 
                                        f32_4 %74 = OpLoad %73 
                                        f32_4 %75 = OpFMul %68 %74 
                                                      OpStore %66 %75 
                               Uniform f32_4* %76 = OpAccessChain %72 %60 %35 
                                        f32_4 %77 = OpLoad %76 
                                        f32_3 %78 = OpLoad %21 
                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
                                        f32_4 %80 = OpFMul %77 %79 
                                        f32_4 %81 = OpLoad %66 
                                        f32_4 %82 = OpFAdd %80 %81 
                                                      OpStore %66 %82 
                               Uniform f32_4* %83 = OpAccessChain %72 %60 %50 
                                        f32_4 %84 = OpLoad %83 
                                        f32_3 %85 = OpLoad %21 
                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
                                        f32_4 %87 = OpFMul %84 %86 
                                        f32_4 %88 = OpLoad %66 
                                        f32_4 %89 = OpFAdd %87 %88 
                                                      OpStore %66 %89 
                                        f32_4 %90 = OpLoad %66 
                               Uniform f32_4* %91 = OpAccessChain %72 %60 %60 
                                        f32_4 %92 = OpLoad %91 
                                        f32_4 %93 = OpFAdd %90 %92 
                                                      OpStore %66 %93 
                                 Private f32* %96 = OpAccessChain %66 %29 
                                          f32 %97 = OpLoad %96 
                                Uniform f32* %100 = OpAccessChain %72 %36 %98 
                                         f32 %101 = OpLoad %100 
                                         f32 %102 = OpFDiv %97 %101 
                                                      OpStore %95 %102 
                                       f32_4 %107 = OpLoad %66 
                               Output f32_4* %108 = OpAccessChain %106 %35 
                                                      OpStore %108 %107 
                                         f32 %109 = OpLoad %95 
                                         f32 %110 = OpFNegate %109 
                                         f32 %112 = OpFAdd %110 %111 
                                                      OpStore %95 %112 
                                         f32 %113 = OpLoad %95 
                                Uniform f32* %114 = OpAccessChain %72 %36 %29 
                                         f32 %115 = OpLoad %114 
                                         f32 %116 = OpFMul %113 %115 
                                                      OpStore %95 %116 
                                         f32 %117 = OpLoad %95 
                                         f32 %119 = OpExtInst %1 40 %117 %118 
                                                      OpStore %95 %119 
                                         f32 %121 = OpLoad %95 
                                Uniform f32* %122 = OpAccessChain %72 %50 %29 
                                         f32 %123 = OpLoad %122 
                                         f32 %124 = OpFMul %121 %123 
                                Uniform f32* %126 = OpAccessChain %72 %50 %125 
                                         f32 %127 = OpLoad %126 
                                         f32 %128 = OpFAdd %124 %127 
                                 Output f32* %130 = OpAccessChain vs_TEXCOORD1 %125 
                                                      OpStore %130 %128 
                                 Output f32* %131 = OpAccessChain vs_TEXCOORD1 %125 
                                         f32 %132 = OpLoad %131 
                                         f32 %133 = OpExtInst %1 43 %132 %118 %111 
                                 Output f32* %134 = OpAccessChain vs_TEXCOORD1 %125 
                                                      OpStore %134 %133 
                                       f32_3 %135 = OpLoad %21 
                                       f32_4 %136 = OpLoad vs_TEXCOORD1 
                                       f32_4 %137 = OpVectorShuffle %136 %135 4 5 6 3 
                                                      OpStore vs_TEXCOORD1 %137 
                                       f32_3 %138 = OpLoad %21 
                                       f32_3 %139 = OpFNegate %138 
                              Uniform f32_3* %141 = OpAccessChain %72 %35 
                                       f32_3 %142 = OpLoad %141 
                                       f32_3 %143 = OpFAdd %139 %142 
                                                      OpStore %21 %143 
                                       f32_3 %146 = OpLoad %145 
                              Uniform f32_4* %147 = OpAccessChain %33 %36 %35 
                                       f32_4 %148 = OpLoad %147 
                                       f32_3 %149 = OpVectorShuffle %148 %148 0 1 2 
                                         f32 %150 = OpDot %146 %149 
                                Private f32* %152 = OpAccessChain %66 %151 
                                                      OpStore %152 %150 
                                       f32_3 %153 = OpLoad %145 
                              Uniform f32_4* %154 = OpAccessChain %33 %36 %36 
                                       f32_4 %155 = OpLoad %154 
                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
                                         f32 %157 = OpDot %153 %156 
                                Private f32* %158 = OpAccessChain %66 %98 
                                                      OpStore %158 %157 
                                       f32_3 %159 = OpLoad %145 
                              Uniform f32_4* %160 = OpAccessChain %33 %36 %50 
                                       f32_4 %161 = OpLoad %160 
                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
                                         f32 %163 = OpDot %159 %162 
                                Private f32* %164 = OpAccessChain %66 %29 
                                                      OpStore %164 %163 
                                       f32_4 %165 = OpLoad %66 
                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
                                       f32_4 %167 = OpLoad %66 
                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
                                         f32 %169 = OpDot %166 %168 
                                                      OpStore %95 %169 
                                         f32 %170 = OpLoad %95 
                                         f32 %172 = OpExtInst %1 40 %170 %171 
                                                      OpStore %95 %172 
                                         f32 %173 = OpLoad %95 
                                         f32 %174 = OpExtInst %1 32 %173 
                                                      OpStore %95 %174 
                                         f32 %175 = OpLoad %95 
                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
                                       f32_4 %177 = OpLoad %66 
                                       f32_3 %178 = OpVectorShuffle %177 %177 0 1 2 
                                       f32_3 %179 = OpFMul %176 %178 
                                       f32_4 %180 = OpLoad %66 
                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
                                                      OpStore %66 %181 
                                       f32_4 %184 = OpLoad %66 
                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
                                                      OpStore vs_TEXCOORD2 %185 
                                       f32_3 %186 = OpLoad %21 
                                       f32_3 %187 = OpLoad %21 
                                         f32 %188 = OpDot %186 %187 
                                                      OpStore %95 %188 
                                         f32 %189 = OpLoad %95 
                                         f32 %190 = OpExtInst %1 40 %189 %171 
                                                      OpStore %95 %190 
                                         f32 %191 = OpLoad %95 
                                         f32 %192 = OpExtInst %1 32 %191 
                                                      OpStore %95 %192 
                                         f32 %193 = OpLoad %95 
                                       f32_3 %194 = OpCompositeConstruct %193 %193 %193 
                                       f32_3 %195 = OpLoad %21 
                                       f32_3 %196 = OpFMul %194 %195 
                                                      OpStore %21 %196 
                                       f32_3 %198 = OpLoad %21 
                                                      OpStore vs_TEXCOORD3 %198 
                                                      OpStore vs_TEXCOORD8 %200 
                                 Output f32* %201 = OpAccessChain %106 %35 %98 
                                         f32 %202 = OpLoad %201 
                                         f32 %203 = OpFNegate %202 
                                 Output f32* %204 = OpAccessChain %106 %35 %98 
                                                      OpStore %204 %203 
                                                      OpReturn
                                                      OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 79
; Schema: 0
                                                      OpCapability Shader 
                                               %1 = OpExtInstImport "GLSL.std.450" 
                                                      OpMemoryModel Logical GLSL450 
                                                      OpEntryPoint Fragment %4 "main" %22 %38 %63 %72 
                                                      OpExecutionMode %4 OriginUpperLeft 
                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                      OpDecorate %9 RelaxedPrecision 
                                                      OpDecorate %12 RelaxedPrecision 
                                                      OpDecorate %12 DescriptorSet 12 
                                                      OpDecorate %12 Binding 12 
                                                      OpDecorate %13 RelaxedPrecision 
                                                      OpDecorate %16 RelaxedPrecision 
                                                      OpDecorate %16 DescriptorSet 16 
                                                      OpDecorate %16 Binding 16 
                                                      OpDecorate %17 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD0 Location 22 
                                                      OpDecorate %25 RelaxedPrecision 
                                                      OpDecorate %26 RelaxedPrecision 
                                                      OpMemberDecorate %27 0 Offset 27 
                                                      OpMemberDecorate %27 1 Offset 27 
                                                      OpMemberDecorate %27 2 Offset 27 
                                                      OpMemberDecorate %27 3 RelaxedPrecision 
                                                      OpMemberDecorate %27 3 Offset 27 
                                                      OpMemberDecorate %27 4 RelaxedPrecision 
                                                      OpMemberDecorate %27 4 Offset 27 
                                                      OpMemberDecorate %27 5 RelaxedPrecision 
                                                      OpMemberDecorate %27 5 Offset 27 
                                                      OpMemberDecorate %27 6 RelaxedPrecision 
                                                      OpMemberDecorate %27 6 Offset 27 
                                                      OpMemberDecorate %27 7 RelaxedPrecision 
                                                      OpMemberDecorate %27 7 Offset 27 
                                                      OpMemberDecorate %27 8 RelaxedPrecision 
                                                      OpMemberDecorate %27 8 Offset 27 
                                                      OpDecorate %27 Block 
                                                      OpDecorate %29 DescriptorSet 29 
                                                      OpDecorate %29 Binding 29 
                                                      OpDecorate %34 RelaxedPrecision 
                                                      OpDecorate %35 RelaxedPrecision 
                                                      OpDecorate %36 RelaxedPrecision 
                                                      OpDecorate %38 RelaxedPrecision 
                                                      OpDecorate %38 Location 38 
                                                      OpDecorate %39 RelaxedPrecision 
                                                      OpDecorate %40 RelaxedPrecision 
                                                      OpDecorate %43 RelaxedPrecision 
                                                      OpDecorate %44 RelaxedPrecision 
                                                      OpDecorate %44 DescriptorSet 44 
                                                      OpDecorate %44 Binding 44 
                                                      OpDecorate %45 RelaxedPrecision 
                                                      OpDecorate %46 RelaxedPrecision 
                                                      OpDecorate %46 DescriptorSet 46 
                                                      OpDecorate %46 Binding 46 
                                                      OpDecorate %47 RelaxedPrecision 
                                                      OpDecorate %51 RelaxedPrecision 
                                                      OpDecorate %52 RelaxedPrecision 
                                                      OpDecorate %53 RelaxedPrecision 
                                                      OpDecorate %56 RelaxedPrecision 
                                                      OpDecorate %57 RelaxedPrecision 
                                                      OpDecorate %58 RelaxedPrecision 
                                                      OpDecorate %59 RelaxedPrecision 
                                                      OpDecorate %60 RelaxedPrecision 
                                                      OpDecorate %61 RelaxedPrecision 
                                                      OpDecorate %63 RelaxedPrecision 
                                                      OpDecorate %63 Location 63 
                                                      OpDecorate %68 RelaxedPrecision 
                                                      OpDecorate %71 RelaxedPrecision 
                                                      OpDecorate vs_TEXCOORD1 Location 72 
                                               %2 = OpTypeVoid 
                                               %3 = OpTypeFunction %2 
                                               %6 = OpTypeFloat 32 
                                               %7 = OpTypeVector %6 4 
                                               %8 = OpTypePointer Private %7 
                                Private f32_4* %9 = OpVariable Private 
                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                              %11 = OpTypePointer UniformConstant %10 
         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
                                              %14 = OpTypeSampler 
                                              %15 = OpTypePointer UniformConstant %14 
                     UniformConstant sampler* %16 = OpVariable UniformConstant 
                                              %18 = OpTypeSampledImage %10 
                                              %20 = OpTypeVector %6 2 
                                              %21 = OpTypePointer Input %20 
                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
                               Private f32_4* %25 = OpVariable Private 
                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
                                              %28 = OpTypePointer Uniform %27 
Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
                                              %30 = OpTypeInt 32 1 
                                          i32 %31 = OpConstant 3 
                                              %32 = OpTypePointer Uniform %7 
                                              %37 = OpTypePointer Input %7 
                                 Input f32_4* %38 = OpVariable Input 
                                              %41 = OpTypeVector %6 3 
                                              %42 = OpTypePointer Private %41 
                               Private f32_3* %43 = OpVariable Private 
         UniformConstant read_only Texture2D* %44 = OpVariable UniformConstant 
                     UniformConstant sampler* %46 = OpVariable UniformConstant 
                               Private f32_3* %52 = OpVariable Private 
                                          i32 %54 = OpConstant 4 
                                              %62 = OpTypePointer Output %7 
                                Output f32_4* %63 = OpVariable Output 
                                              %64 = OpTypeInt 32 0 
                                          u32 %65 = OpConstant 3 
                                              %66 = OpTypePointer Private %6 
                                              %69 = OpTypePointer Output %6 
                        Input f32_4* vs_TEXCOORD1 = OpVariable Input 
                                          void %4 = OpFunction None %3 
                                               %5 = OpLabel 
                          read_only Texture2D %13 = OpLoad %12 
                                      sampler %17 = OpLoad %16 
                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                                      OpStore %9 %24 
                                        f32_4 %26 = OpLoad %9 
                               Uniform f32_4* %33 = OpAccessChain %29 %31 
                                        f32_4 %34 = OpLoad %33 
                                        f32_4 %35 = OpFMul %26 %34 
                                                      OpStore %25 %35 
                                        f32_4 %36 = OpLoad %25 
                                        f32_4 %39 = OpLoad %38 
                                        f32_4 %40 = OpFMul %36 %39 
                                                      OpStore %25 %40 
                          read_only Texture2D %45 = OpLoad %44 
                                      sampler %47 = OpLoad %46 
                   read_only Texture2DSampled %48 = OpSampledImage %45 %47 
                                        f32_2 %49 = OpLoad vs_TEXCOORD0 
                                        f32_4 %50 = OpImageSampleImplicitLod %48 %49 
                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
                                                      OpStore %43 %51 
                                        f32_3 %53 = OpLoad %43 
                               Uniform f32_4* %55 = OpAccessChain %29 %54 
                                        f32_4 %56 = OpLoad %55 
                                        f32_3 %57 = OpVectorShuffle %56 %56 0 1 2 
                                        f32_3 %58 = OpFMul %53 %57 
                                        f32_4 %59 = OpLoad %25 
                                        f32_3 %60 = OpVectorShuffle %59 %59 0 1 2 
                                        f32_3 %61 = OpFAdd %58 %60 
                                                      OpStore %52 %61 
                                 Private f32* %67 = OpAccessChain %25 %65 
                                          f32 %68 = OpLoad %67 
                                  Output f32* %70 = OpAccessChain %63 %65 
                                                      OpStore %70 %68 
                                        f32_3 %71 = OpLoad %52 
                                        f32_4 %73 = OpLoad vs_TEXCOORD1 
                                        f32_3 %74 = OpVectorShuffle %73 %73 3 3 3 
                                        f32_3 %75 = OpFMul %71 %74 
                                        f32_4 %76 = OpLoad %63 
                                        f32_4 %77 = OpVectorShuffle %76 %75 4 5 6 3 
                                                      OpStore %63 %77 
                                                      OpReturn
                                                      OpFunctionEnd
"
}
}
Program "fp" {
SubProgram "gles3 " {
""
}
SubProgram "vulkan " {
""
}
SubProgram "gles3 " {
Keywords { "_EMISSION" }
""
}
SubProgram "vulkan " {
Keywords { "_EMISSION" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 " {
Keywords { "FOG_LINEAR" "_EMISSION" }
""
}
SubProgram "vulkan " {
Keywords { "FOG_LINEAR" "_EMISSION" }
""
}
}
}
}
CustomEditor "UnityEditor.Rendering.Universal.ShaderGUI.ParticlesUnlitShader"
}