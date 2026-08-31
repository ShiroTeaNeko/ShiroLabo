//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Spine/Skeleton" {
Properties {
_Cutoff ("Shadow alpha cutoff", Range(0, 1)) = 0.1
_MainTex ("Main Texture", 2D) = "black" { }
[Toggle(_STRAIGHT_ALPHA_INPUT)] _StraightAlphaInput ("Straight Alpha Texture", Float) = 0
_StencilRef ("Stencil Reference", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Float) = 8
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  Fog {
   Mode Off
  }
  GpuProgramID 36988
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 97
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Vertex %4 "main" %11 %72 %84 %86 %88 %89 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpDecorate %11 Location 11 
                                              OpDecorate %16 ArrayStride 16 
                                              OpDecorate %17 ArrayStride 17 
                                              OpMemberDecorate %18 0 Offset 18 
                                              OpMemberDecorate %18 1 Offset 18 
                                              OpDecorate %18 Block 
                                              OpDecorate %20 DescriptorSet 20 
                                              OpDecorate %20 Binding 20 
                                              OpMemberDecorate %70 0 BuiltIn 70 
                                              OpMemberDecorate %70 1 BuiltIn 70 
                                              OpMemberDecorate %70 2 BuiltIn 70 
                                              OpDecorate %70 Block 
                                              OpDecorate vs_TEXCOORD0 Location 84 
                                              OpDecorate %86 Location 86 
                                              OpDecorate %88 Location 88 
                                              OpDecorate %89 Location 89 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypePointer Input %7 
                         Input f32_4* %11 = OpVariable Input 
                                      %14 = OpTypeInt 32 0 
                                  u32 %15 = OpConstant 4 
                                      %16 = OpTypeArray %7 %15 
                                      %17 = OpTypeArray %7 %15 
                                      %18 = OpTypeStruct %16 %17 
                                      %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4[4]; f32_4[4];}* %20 = OpVariable Uniform 
                                      %21 = OpTypeInt 32 1 
                                  i32 %22 = OpConstant 0 
                                  i32 %23 = OpConstant 1 
                                      %24 = OpTypePointer Uniform %7 
                                  i32 %35 = OpConstant 2 
                                  i32 %44 = OpConstant 3 
                       Private f32_4* %48 = OpVariable Private 
                                  u32 %68 = OpConstant 1 
                                      %69 = OpTypeArray %6 %68 
                                      %70 = OpTypeStruct %7 %6 %69 
                                      %71 = OpTypePointer Output %70 
 Output struct {f32_4; f32; f32[1];}* %72 = OpVariable Output 
                                      %80 = OpTypePointer Output %7 
                                      %82 = OpTypeVector %6 2 
                                      %83 = OpTypePointer Output %82 
               Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                      %85 = OpTypePointer Input %82 
                         Input f32_2* %86 = OpVariable Input 
                        Output f32_4* %88 = OpVariable Output 
                         Input f32_4* %89 = OpVariable Input 
                                      %91 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                                f32_4 %12 = OpLoad %11 
                                f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                       Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
                                f32_4 %26 = OpLoad %25 
                                f32_4 %27 = OpFMul %13 %26 
                                              OpStore %9 %27 
                       Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
                                f32_4 %29 = OpLoad %28 
                                f32_4 %30 = OpLoad %11 
                                f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                f32_4 %32 = OpFMul %29 %31 
                                f32_4 %33 = OpLoad %9 
                                f32_4 %34 = OpFAdd %32 %33 
                                              OpStore %9 %34 
                       Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                f32_4 %37 = OpLoad %36 
                                f32_4 %38 = OpLoad %11 
                                f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                f32_4 %40 = OpFMul %37 %39 
                                f32_4 %41 = OpLoad %9 
                                f32_4 %42 = OpFAdd %40 %41 
                                              OpStore %9 %42 
                                f32_4 %43 = OpLoad %9 
                       Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                f32_4 %46 = OpLoad %45 
                                f32_4 %47 = OpFAdd %43 %46 
                                              OpStore %9 %47 
                                f32_4 %49 = OpLoad %9 
                                f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                       Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
                                f32_4 %52 = OpLoad %51 
                                f32_4 %53 = OpFMul %50 %52 
                                              OpStore %48 %53 
                       Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
                                f32_4 %55 = OpLoad %54 
                                f32_4 %56 = OpLoad %9 
                                f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                f32_4 %58 = OpFMul %55 %57 
                                f32_4 %59 = OpLoad %48 
                                f32_4 %60 = OpFAdd %58 %59 
                                              OpStore %48 %60 
                       Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
                                f32_4 %62 = OpLoad %61 
                                f32_4 %63 = OpLoad %9 
                                f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                f32_4 %65 = OpFMul %62 %64 
                                f32_4 %66 = OpLoad %48 
                                f32_4 %67 = OpFAdd %65 %66 
                                              OpStore %48 %67 
                       Uniform f32_4* %73 = OpAccessChain %20 %23 %44 
                                f32_4 %74 = OpLoad %73 
                                f32_4 %75 = OpLoad %9 
                                f32_4 %76 = OpVectorShuffle %75 %75 3 3 3 3 
                                f32_4 %77 = OpFMul %74 %76 
                                f32_4 %78 = OpLoad %48 
                                f32_4 %79 = OpFAdd %77 %78 
                        Output f32_4* %81 = OpAccessChain %72 %22 
                                              OpStore %81 %79 
                                f32_2 %87 = OpLoad %86 
                                              OpStore vs_TEXCOORD0 %87 
                                f32_4 %90 = OpLoad %89 
                                              OpStore %88 %90 
                          Output f32* %92 = OpAccessChain %72 %22 %68 
                                  f32 %93 = OpLoad %92 
                                  f32 %94 = OpFNegate %93 
                          Output f32* %95 = OpAccessChain %72 %22 %68 
                                              OpStore %95 %94 
                                              OpReturn
                                              OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 33
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %26 %29 
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
                                             OpDecorate %26 Location 26 
                                             OpDecorate %27 RelaxedPrecision 
                                             OpDecorate %29 Location 29 
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
                                     %25 = OpTypePointer Output %7 
                       Output f32_4* %26 = OpVariable Output 
                                     %28 = OpTypePointer Input %7 
                        Input f32_4* %29 = OpVariable Input 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD0 
                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                             OpStore %9 %24 
                               f32_4 %27 = OpLoad %9 
                               f32_4 %30 = OpLoad %29 
                               f32_4 %31 = OpFMul %27 %30 
                                             OpStore %26 %31 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 97
; Schema: 0
                                              OpCapability Shader 
                                       %1 = OpExtInstImport "GLSL.std.450" 
                                              OpMemoryModel Logical GLSL450 
                                              OpEntryPoint Vertex %4 "main" %11 %72 %84 %86 %88 %89 
                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                              OpDecorate %11 Location 11 
                                              OpDecorate %16 ArrayStride 16 
                                              OpDecorate %17 ArrayStride 17 
                                              OpMemberDecorate %18 0 Offset 18 
                                              OpMemberDecorate %18 1 Offset 18 
                                              OpDecorate %18 Block 
                                              OpDecorate %20 DescriptorSet 20 
                                              OpDecorate %20 Binding 20 
                                              OpMemberDecorate %70 0 BuiltIn 70 
                                              OpMemberDecorate %70 1 BuiltIn 70 
                                              OpMemberDecorate %70 2 BuiltIn 70 
                                              OpDecorate %70 Block 
                                              OpDecorate vs_TEXCOORD0 Location 84 
                                              OpDecorate %86 Location 86 
                                              OpDecorate %88 Location 88 
                                              OpDecorate %89 Location 89 
                                       %2 = OpTypeVoid 
                                       %3 = OpTypeFunction %2 
                                       %6 = OpTypeFloat 32 
                                       %7 = OpTypeVector %6 4 
                                       %8 = OpTypePointer Private %7 
                        Private f32_4* %9 = OpVariable Private 
                                      %10 = OpTypePointer Input %7 
                         Input f32_4* %11 = OpVariable Input 
                                      %14 = OpTypeInt 32 0 
                                  u32 %15 = OpConstant 4 
                                      %16 = OpTypeArray %7 %15 
                                      %17 = OpTypeArray %7 %15 
                                      %18 = OpTypeStruct %16 %17 
                                      %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4[4]; f32_4[4];}* %20 = OpVariable Uniform 
                                      %21 = OpTypeInt 32 1 
                                  i32 %22 = OpConstant 0 
                                  i32 %23 = OpConstant 1 
                                      %24 = OpTypePointer Uniform %7 
                                  i32 %35 = OpConstant 2 
                                  i32 %44 = OpConstant 3 
                       Private f32_4* %48 = OpVariable Private 
                                  u32 %68 = OpConstant 1 
                                      %69 = OpTypeArray %6 %68 
                                      %70 = OpTypeStruct %7 %6 %69 
                                      %71 = OpTypePointer Output %70 
 Output struct {f32_4; f32; f32[1];}* %72 = OpVariable Output 
                                      %80 = OpTypePointer Output %7 
                                      %82 = OpTypeVector %6 2 
                                      %83 = OpTypePointer Output %82 
               Output f32_2* vs_TEXCOORD0 = OpVariable Output 
                                      %85 = OpTypePointer Input %82 
                         Input f32_2* %86 = OpVariable Input 
                        Output f32_4* %88 = OpVariable Output 
                         Input f32_4* %89 = OpVariable Input 
                                      %91 = OpTypePointer Output %6 
                                  void %4 = OpFunction None %3 
                                       %5 = OpLabel 
                                f32_4 %12 = OpLoad %11 
                                f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                       Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
                                f32_4 %26 = OpLoad %25 
                                f32_4 %27 = OpFMul %13 %26 
                                              OpStore %9 %27 
                       Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
                                f32_4 %29 = OpLoad %28 
                                f32_4 %30 = OpLoad %11 
                                f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                f32_4 %32 = OpFMul %29 %31 
                                f32_4 %33 = OpLoad %9 
                                f32_4 %34 = OpFAdd %32 %33 
                                              OpStore %9 %34 
                       Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                f32_4 %37 = OpLoad %36 
                                f32_4 %38 = OpLoad %11 
                                f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                f32_4 %40 = OpFMul %37 %39 
                                f32_4 %41 = OpLoad %9 
                                f32_4 %42 = OpFAdd %40 %41 
                                              OpStore %9 %42 
                                f32_4 %43 = OpLoad %9 
                       Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                f32_4 %46 = OpLoad %45 
                                f32_4 %47 = OpFAdd %43 %46 
                                              OpStore %9 %47 
                                f32_4 %49 = OpLoad %9 
                                f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                       Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
                                f32_4 %52 = OpLoad %51 
                                f32_4 %53 = OpFMul %50 %52 
                                              OpStore %48 %53 
                       Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
                                f32_4 %55 = OpLoad %54 
                                f32_4 %56 = OpLoad %9 
                                f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                f32_4 %58 = OpFMul %55 %57 
                                f32_4 %59 = OpLoad %48 
                                f32_4 %60 = OpFAdd %58 %59 
                                              OpStore %48 %60 
                       Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
                                f32_4 %62 = OpLoad %61 
                                f32_4 %63 = OpLoad %9 
                                f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                f32_4 %65 = OpFMul %62 %64 
                                f32_4 %66 = OpLoad %48 
                                f32_4 %67 = OpFAdd %65 %66 
                                              OpStore %48 %67 
                       Uniform f32_4* %73 = OpAccessChain %20 %23 %44 
                                f32_4 %74 = OpLoad %73 
                                f32_4 %75 = OpLoad %9 
                                f32_4 %76 = OpVectorShuffle %75 %75 3 3 3 3 
                                f32_4 %77 = OpFMul %74 %76 
                                f32_4 %78 = OpLoad %48 
                                f32_4 %79 = OpFAdd %77 %78 
                        Output f32_4* %81 = OpAccessChain %72 %22 
                                              OpStore %81 %79 
                                f32_2 %87 = OpLoad %86 
                                              OpStore vs_TEXCOORD0 %87 
                                f32_4 %90 = OpLoad %89 
                                              OpStore %88 %90 
                          Output f32* %92 = OpAccessChain %72 %22 %68 
                                  f32 %93 = OpLoad %92 
                                  f32 %94 = OpFNegate %93 
                          Output f32* %95 = OpAccessChain %72 %22 %68 
                                              OpStore %95 %94 
                                              OpReturn
                                              OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 41
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %22 %34 %37 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %12 DescriptorSet 12 
                                             OpDecorate %12 Binding 12 
                                             OpDecorate %13 RelaxedPrecision 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate %16 DescriptorSet 16 
                                             OpDecorate %16 Binding 16 
                                             OpDecorate %17 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD0 Location 22 
                                             OpDecorate %34 Location 34 
                                             OpDecorate %37 Location 37 
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
                                     %25 = OpTypeVector %6 3 
                                     %33 = OpTypePointer Output %7 
                       Output f32_4* %34 = OpVariable Output 
                                     %36 = OpTypePointer Input %7 
                        Input f32_4* %37 = OpVariable Input 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %13 = OpLoad %12 
                             sampler %17 = OpLoad %16 
          read_only Texture2DSampled %19 = OpSampledImage %13 %17 
                               f32_2 %23 = OpLoad vs_TEXCOORD0 
                               f32_4 %24 = OpImageSampleImplicitLod %19 %23 
                                             OpStore %9 %24 
                               f32_4 %26 = OpLoad %9 
                               f32_3 %27 = OpVectorShuffle %26 %26 3 3 3 
                               f32_4 %28 = OpLoad %9 
                               f32_3 %29 = OpVectorShuffle %28 %28 0 1 2 
                               f32_3 %30 = OpFMul %27 %29 
                               f32_4 %31 = OpLoad %9 
                               f32_4 %32 = OpVectorShuffle %31 %30 4 5 6 3 
                                             OpStore %9 %32 
                               f32_4 %35 = OpLoad %9 
                               f32_4 %38 = OpLoad %37 
                               f32_4 %39 = OpFMul %35 %38 
                                             OpStore %34 %39 
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
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "vulkan " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
}
}
 Pass {
  Name "Caster"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  Cull Off
  Offset 1, 1
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  Fog {
   Mode Off
  }
  GpuProgramID 106208
Program "vp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
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
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat4;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat4);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat4) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat4;
    vs_TEXCOORD1.xyz = in_TEXCOORD0.xyz;
    vs_TEXCOORD1.w = in_COLOR0.w;
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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SHADOWS_DEPTH" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 150
; Schema: 0
                                                     OpCapability Shader 
                                              %1 = OpExtInstImport "GLSL.std.450" 
                                                     OpMemoryModel Logical GLSL450 
                                                     OpEntryPoint Vertex %4 "main" %11 %111 %134 %135 %140 
                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                     OpDecorate %11 Location 11 
                                                     OpDecorate %16 ArrayStride 16 
                                                     OpDecorate %17 ArrayStride 17 
                                                     OpMemberDecorate %18 0 Offset 18 
                                                     OpMemberDecorate %18 1 Offset 18 
                                                     OpMemberDecorate %18 2 Offset 18 
                                                     OpDecorate %18 Block 
                                                     OpDecorate %20 DescriptorSet 20 
                                                     OpDecorate %20 Binding 20 
                                                     OpMemberDecorate %109 0 BuiltIn 109 
                                                     OpMemberDecorate %109 1 BuiltIn 109 
                                                     OpMemberDecorate %109 2 BuiltIn 109 
                                                     OpDecorate %109 Block 
                                                     OpDecorate vs_TEXCOORD1 Location 134 
                                                     OpDecorate %135 Location 135 
                                                     OpDecorate %140 Location 140 
                                              %2 = OpTypeVoid 
                                              %3 = OpTypeFunction %2 
                                              %6 = OpTypeFloat 32 
                                              %7 = OpTypeVector %6 4 
                                              %8 = OpTypePointer Private %7 
                               Private f32_4* %9 = OpVariable Private 
                                             %10 = OpTypePointer Input %7 
                                Input f32_4* %11 = OpVariable Input 
                                             %14 = OpTypeInt 32 0 
                                         u32 %15 = OpConstant 4 
                                             %16 = OpTypeArray %7 %15 
                                             %17 = OpTypeArray %7 %15 
                                             %18 = OpTypeStruct %7 %16 %17 
                                             %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4; f32_4[4]; f32_4[4];}* %20 = OpVariable Uniform 
                                             %21 = OpTypeInt 32 1 
                                         i32 %22 = OpConstant 1 
                                             %23 = OpTypePointer Uniform %7 
                                         i32 %27 = OpConstant 0 
                                         i32 %35 = OpConstant 2 
                                         i32 %44 = OpConstant 3 
                              Private f32_4* %48 = OpVariable Private 
                                         u32 %75 = OpConstant 0 
                                             %76 = OpTypePointer Uniform %6 
                                         u32 %79 = OpConstant 3 
                                             %80 = OpTypePointer Private %6 
                                         f32 %87 = OpConstant 3.674022E-40 
                                         f32 %92 = OpConstant 3.674022E-40 
                                Private f32* %95 = OpVariable Private 
                                         u32 %96 = OpConstant 2 
                                        u32 %107 = OpConstant 1 
                                            %108 = OpTypeArray %6 %107 
                                            %109 = OpTypeStruct %7 %6 %108 
                                            %110 = OpTypePointer Output %109 
       Output struct {f32_4; f32; f32[1];}* %111 = OpVariable Output 
                                            %112 = OpTypeVector %6 3 
                                            %115 = OpTypePointer Output %7 
                                            %132 = OpTypePointer Output %6 
                      Output f32_4* vs_TEXCOORD1 = OpVariable Output 
                               Input f32_4* %135 = OpVariable Input 
                               Input f32_4* %140 = OpVariable Input 
                                            %141 = OpTypePointer Input %6 
                                         void %4 = OpFunction None %3 
                                              %5 = OpLabel 
                                       f32_4 %12 = OpLoad %11 
                                       f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                              Uniform f32_4* %24 = OpAccessChain %20 %22 %22 
                                       f32_4 %25 = OpLoad %24 
                                       f32_4 %26 = OpFMul %13 %25 
                                                     OpStore %9 %26 
                              Uniform f32_4* %28 = OpAccessChain %20 %22 %27 
                                       f32_4 %29 = OpLoad %28 
                                       f32_4 %30 = OpLoad %11 
                                       f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                       f32_4 %32 = OpFMul %29 %31 
                                       f32_4 %33 = OpLoad %9 
                                       f32_4 %34 = OpFAdd %32 %33 
                                                     OpStore %9 %34 
                              Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                       f32_4 %37 = OpLoad %36 
                                       f32_4 %38 = OpLoad %11 
                                       f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                       f32_4 %40 = OpFMul %37 %39 
                                       f32_4 %41 = OpLoad %9 
                                       f32_4 %42 = OpFAdd %40 %41 
                                                     OpStore %9 %42 
                                       f32_4 %43 = OpLoad %9 
                              Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                       f32_4 %46 = OpLoad %45 
                                       f32_4 %47 = OpFAdd %43 %46 
                                                     OpStore %9 %47 
                                       f32_4 %49 = OpLoad %9 
                                       f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                              Uniform f32_4* %51 = OpAccessChain %20 %35 %22 
                                       f32_4 %52 = OpLoad %51 
                                       f32_4 %53 = OpFMul %50 %52 
                                                     OpStore %48 %53 
                              Uniform f32_4* %54 = OpAccessChain %20 %35 %27 
                                       f32_4 %55 = OpLoad %54 
                                       f32_4 %56 = OpLoad %9 
                                       f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                       f32_4 %58 = OpFMul %55 %57 
                                       f32_4 %59 = OpLoad %48 
                                       f32_4 %60 = OpFAdd %58 %59 
                                                     OpStore %48 %60 
                              Uniform f32_4* %61 = OpAccessChain %20 %35 %35 
                                       f32_4 %62 = OpLoad %61 
                                       f32_4 %63 = OpLoad %9 
                                       f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                       f32_4 %65 = OpFMul %62 %64 
                                       f32_4 %66 = OpLoad %48 
                                       f32_4 %67 = OpFAdd %65 %66 
                                                     OpStore %48 %67 
                              Uniform f32_4* %68 = OpAccessChain %20 %35 %44 
                                       f32_4 %69 = OpLoad %68 
                                       f32_4 %70 = OpLoad %9 
                                       f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                       f32_4 %72 = OpFMul %69 %71 
                                       f32_4 %73 = OpLoad %48 
                                       f32_4 %74 = OpFAdd %72 %73 
                                                     OpStore %9 %74 
                                Uniform f32* %77 = OpAccessChain %20 %27 %75 
                                         f32 %78 = OpLoad %77 
                                Private f32* %81 = OpAccessChain %9 %79 
                                         f32 %82 = OpLoad %81 
                                         f32 %83 = OpFDiv %78 %82 
                                Private f32* %84 = OpAccessChain %48 %75 
                                                     OpStore %84 %83 
                                Private f32* %85 = OpAccessChain %48 %75 
                                         f32 %86 = OpLoad %85 
                                         f32 %88 = OpExtInst %1 37 %86 %87 
                                Private f32* %89 = OpAccessChain %48 %75 
                                                     OpStore %89 %88 
                                Private f32* %90 = OpAccessChain %48 %75 
                                         f32 %91 = OpLoad %90 
                                         f32 %93 = OpExtInst %1 40 %91 %92 
                                Private f32* %94 = OpAccessChain %48 %75 
                                                     OpStore %94 %93 
                                Private f32* %97 = OpAccessChain %9 %96 
                                         f32 %98 = OpLoad %97 
                                Private f32* %99 = OpAccessChain %48 %75 
                                        f32 %100 = OpLoad %99 
                                        f32 %101 = OpFAdd %98 %100 
                                                     OpStore %95 %101 
                               Private f32* %102 = OpAccessChain %9 %79 
                                        f32 %103 = OpLoad %102 
                                        f32 %104 = OpLoad %95 
                                        f32 %105 = OpExtInst %1 37 %103 %104 
                               Private f32* %106 = OpAccessChain %48 %75 
                                                     OpStore %106 %105 
                                      f32_4 %113 = OpLoad %9 
                                      f32_3 %114 = OpVectorShuffle %113 %113 0 1 3 
                              Output f32_4* %116 = OpAccessChain %111 %27 
                                      f32_4 %117 = OpLoad %116 
                                      f32_4 %118 = OpVectorShuffle %117 %114 4 5 2 6 
                                                     OpStore %116 %118 
                                        f32 %119 = OpLoad %95 
                                        f32 %120 = OpFNegate %119 
                               Private f32* %121 = OpAccessChain %48 %75 
                                        f32 %122 = OpLoad %121 
                                        f32 %123 = OpFAdd %120 %122 
                               Private f32* %124 = OpAccessChain %9 %75 
                                                     OpStore %124 %123 
                               Uniform f32* %125 = OpAccessChain %20 %27 %107 
                                        f32 %126 = OpLoad %125 
                               Private f32* %127 = OpAccessChain %9 %75 
                                        f32 %128 = OpLoad %127 
                                        f32 %129 = OpFMul %126 %128 
                                        f32 %130 = OpLoad %95 
                                        f32 %131 = OpFAdd %129 %130 
                                Output f32* %133 = OpAccessChain %111 %27 %96 
                                                     OpStore %133 %131 
                                      f32_4 %136 = OpLoad %135 
                                      f32_3 %137 = OpVectorShuffle %136 %136 0 1 2 
                                      f32_4 %138 = OpLoad vs_TEXCOORD1 
                                      f32_4 %139 = OpVectorShuffle %138 %137 4 5 6 3 
                                                     OpStore vs_TEXCOORD1 %139 
                                 Input f32* %142 = OpAccessChain %140 %79 
                                        f32 %143 = OpLoad %142 
                                Output f32* %144 = OpAccessChain vs_TEXCOORD1 %79 
                                                     OpStore %144 %143 
                                Output f32* %145 = OpAccessChain %111 %27 %107 
                                        f32 %146 = OpLoad %145 
                                        f32 %147 = OpFNegate %146 
                                Output f32* %148 = OpAccessChain %111 %27 %107 
                                                     OpStore %148 %147 
                                                     OpReturn
                                                     OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 64
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %21 %61 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %8 RelaxedPrecision 
                                             OpDecorate %11 RelaxedPrecision 
                                             OpDecorate %11 DescriptorSet 11 
                                             OpDecorate %11 Binding 11 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %15 RelaxedPrecision 
                                             OpDecorate %15 DescriptorSet 15 
                                             OpDecorate %15 Binding 15 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 21 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpDecorate %30 RelaxedPrecision 
                                             OpMemberDecorate %35 0 RelaxedPrecision 
                                             OpMemberDecorate %35 0 Offset 35 
                                             OpDecorate %35 Block 
                                             OpDecorate %37 DescriptorSet 37 
                                             OpDecorate %37 Binding 37 
                                             OpDecorate %42 RelaxedPrecision 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %61 Location 61 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypePointer Private %6 
                         Private f32* %8 = OpVariable Private 
                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %10 = OpTypePointer UniformConstant %9 
UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
                                     %13 = OpTypeSampler 
                                     %14 = OpTypePointer UniformConstant %13 
            UniformConstant sampler* %15 = OpVariable UniformConstant 
                                     %17 = OpTypeSampledImage %9 
                                     %19 = OpTypeVector %6 4 
                                     %20 = OpTypePointer Input %19 
               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
                                     %22 = OpTypeVector %6 2 
                                     %26 = OpTypeInt 32 0 
                                 u32 %27 = OpConstant 3 
                        Private f32* %29 = OpVariable Private 
                                     %31 = OpTypePointer Input %6 
                                     %35 = OpTypeStruct %6 
                                     %36 = OpTypePointer Uniform %35 
              Uniform struct {f32;}* %37 = OpVariable Uniform 
                                     %38 = OpTypeInt 32 1 
                                 i32 %39 = OpConstant 0 
                                     %40 = OpTypePointer Uniform %6 
                                     %45 = OpTypeBool 
                                     %46 = OpTypePointer Private %45 
                       Private bool* %47 = OpVariable Private 
                                 f32 %49 = OpConstant 3.674022E-40 
                                 i32 %52 = OpConstant 1 
                                 i32 %54 = OpConstant -1 
                                     %60 = OpTypePointer Output %19 
                       Output f32_4* %61 = OpVariable Output 
                               f32_4 %62 = OpConstantComposite %49 %49 %49 %49 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %12 = OpLoad %11 
                             sampler %16 = OpLoad %15 
          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
                               f32_4 %23 = OpLoad vs_TEXCOORD1 
                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
                                 f32 %28 = OpCompositeExtract %25 3 
                                             OpStore %8 %28 
                                 f32 %30 = OpLoad %8 
                          Input f32* %32 = OpAccessChain vs_TEXCOORD1 %27 
                                 f32 %33 = OpLoad %32 
                                 f32 %34 = OpFMul %30 %33 
                        Uniform f32* %41 = OpAccessChain %37 %39 
                                 f32 %42 = OpLoad %41 
                                 f32 %43 = OpFNegate %42 
                                 f32 %44 = OpFAdd %34 %43 
                                             OpStore %29 %44 
                                 f32 %48 = OpLoad %29 
                                bool %50 = OpFOrdLessThan %48 %49 
                                             OpStore %47 %50 
                                bool %51 = OpLoad %47 
                                 i32 %53 = OpSelect %51 %52 %39 
                                 i32 %55 = OpIMul %53 %54 
                                bool %56 = OpINotEqual %55 %39 
                                             OpSelectionMerge %58 None 
                                             OpBranchConditional %56 %57 %58 
                                     %57 = OpLabel 
                                             OpKill
                                     %58 = OpLabel 
                                             OpStore %61 %62 
                                             OpReturn
                                             OpFunctionEnd
"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
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
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
    gl_Position.xyw = u_xlat0.xyw;
    vs_TEXCOORD1.xyz = in_TEXCOORD0.xyz;
    vs_TEXCOORD1.w = in_COLOR0.w;
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
uniform 	mediump float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0 = u_xlat16_0 * vs_TEXCOORD1.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0<0.0);
#else
    u_xlatb0 = u_xlat0<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "vulkan " {
Keywords { "SHADOWS_CUBE" }
"; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 131
; Schema: 0
                                                     OpCapability Shader 
                                              %1 = OpExtInstImport "GLSL.std.450" 
                                                     OpMemoryModel Logical GLSL450 
                                                     OpEntryPoint Vertex %4 "main" %11 %96 %115 %116 %121 
                                                     OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                                     OpDecorate %11 Location 11 
                                                     OpDecorate %16 ArrayStride 16 
                                                     OpDecorate %17 ArrayStride 17 
                                                     OpMemberDecorate %18 0 Offset 18 
                                                     OpMemberDecorate %18 1 Offset 18 
                                                     OpMemberDecorate %18 2 Offset 18 
                                                     OpDecorate %18 Block 
                                                     OpDecorate %20 DescriptorSet 20 
                                                     OpDecorate %20 Binding 20 
                                                     OpMemberDecorate %94 0 BuiltIn 94 
                                                     OpMemberDecorate %94 1 BuiltIn 94 
                                                     OpMemberDecorate %94 2 BuiltIn 94 
                                                     OpDecorate %94 Block 
                                                     OpDecorate vs_TEXCOORD1 Location 115 
                                                     OpDecorate %116 Location 116 
                                                     OpDecorate %121 Location 121 
                                              %2 = OpTypeVoid 
                                              %3 = OpTypeFunction %2 
                                              %6 = OpTypeFloat 32 
                                              %7 = OpTypeVector %6 4 
                                              %8 = OpTypePointer Private %7 
                               Private f32_4* %9 = OpVariable Private 
                                             %10 = OpTypePointer Input %7 
                                Input f32_4* %11 = OpVariable Input 
                                             %14 = OpTypeInt 32 0 
                                         u32 %15 = OpConstant 4 
                                             %16 = OpTypeArray %7 %15 
                                             %17 = OpTypeArray %7 %15 
                                             %18 = OpTypeStruct %7 %16 %17 
                                             %19 = OpTypePointer Uniform %18 
Uniform struct {f32_4; f32_4[4]; f32_4[4];}* %20 = OpVariable Uniform 
                                             %21 = OpTypeInt 32 1 
                                         i32 %22 = OpConstant 1 
                                             %23 = OpTypePointer Uniform %7 
                                         i32 %27 = OpConstant 0 
                                         i32 %35 = OpConstant 2 
                                         i32 %44 = OpConstant 3 
                              Private f32_4* %48 = OpVariable Private 
                                         u32 %75 = OpConstant 3 
                                             %76 = OpTypePointer Private %6 
                                         u32 %79 = OpConstant 2 
                                         u32 %83 = OpConstant 0 
                                         u32 %92 = OpConstant 1 
                                             %93 = OpTypeArray %6 %92 
                                             %94 = OpTypeStruct %7 %6 %93 
                                             %95 = OpTypePointer Output %94 
        Output struct {f32_4; f32; f32[1];}* %96 = OpVariable Output 
                                             %97 = OpTypePointer Uniform %6 
                                            %106 = OpTypePointer Output %6 
                                            %108 = OpTypeVector %6 3 
                                            %111 = OpTypePointer Output %7 
                      Output f32_4* vs_TEXCOORD1 = OpVariable Output 
                               Input f32_4* %116 = OpVariable Input 
                               Input f32_4* %121 = OpVariable Input 
                                            %122 = OpTypePointer Input %6 
                                         void %4 = OpFunction None %3 
                                              %5 = OpLabel 
                                       f32_4 %12 = OpLoad %11 
                                       f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
                              Uniform f32_4* %24 = OpAccessChain %20 %22 %22 
                                       f32_4 %25 = OpLoad %24 
                                       f32_4 %26 = OpFMul %13 %25 
                                                     OpStore %9 %26 
                              Uniform f32_4* %28 = OpAccessChain %20 %22 %27 
                                       f32_4 %29 = OpLoad %28 
                                       f32_4 %30 = OpLoad %11 
                                       f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
                                       f32_4 %32 = OpFMul %29 %31 
                                       f32_4 %33 = OpLoad %9 
                                       f32_4 %34 = OpFAdd %32 %33 
                                                     OpStore %9 %34 
                              Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
                                       f32_4 %37 = OpLoad %36 
                                       f32_4 %38 = OpLoad %11 
                                       f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
                                       f32_4 %40 = OpFMul %37 %39 
                                       f32_4 %41 = OpLoad %9 
                                       f32_4 %42 = OpFAdd %40 %41 
                                                     OpStore %9 %42 
                                       f32_4 %43 = OpLoad %9 
                              Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
                                       f32_4 %46 = OpLoad %45 
                                       f32_4 %47 = OpFAdd %43 %46 
                                                     OpStore %9 %47 
                                       f32_4 %49 = OpLoad %9 
                                       f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
                              Uniform f32_4* %51 = OpAccessChain %20 %35 %22 
                                       f32_4 %52 = OpLoad %51 
                                       f32_4 %53 = OpFMul %50 %52 
                                                     OpStore %48 %53 
                              Uniform f32_4* %54 = OpAccessChain %20 %35 %27 
                                       f32_4 %55 = OpLoad %54 
                                       f32_4 %56 = OpLoad %9 
                                       f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
                                       f32_4 %58 = OpFMul %55 %57 
                                       f32_4 %59 = OpLoad %48 
                                       f32_4 %60 = OpFAdd %58 %59 
                                                     OpStore %48 %60 
                              Uniform f32_4* %61 = OpAccessChain %20 %35 %35 
                                       f32_4 %62 = OpLoad %61 
                                       f32_4 %63 = OpLoad %9 
                                       f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
                                       f32_4 %65 = OpFMul %62 %64 
                                       f32_4 %66 = OpLoad %48 
                                       f32_4 %67 = OpFAdd %65 %66 
                                                     OpStore %48 %67 
                              Uniform f32_4* %68 = OpAccessChain %20 %35 %44 
                                       f32_4 %69 = OpLoad %68 
                                       f32_4 %70 = OpLoad %9 
                                       f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
                                       f32_4 %72 = OpFMul %69 %71 
                                       f32_4 %73 = OpLoad %48 
                                       f32_4 %74 = OpFAdd %72 %73 
                                                     OpStore %9 %74 
                                Private f32* %77 = OpAccessChain %9 %75 
                                         f32 %78 = OpLoad %77 
                                Private f32* %80 = OpAccessChain %9 %79 
                                         f32 %81 = OpLoad %80 
                                         f32 %82 = OpExtInst %1 37 %78 %81 
                                Private f32* %84 = OpAccessChain %48 %83 
                                                     OpStore %84 %82 
                                Private f32* %85 = OpAccessChain %9 %79 
                                         f32 %86 = OpLoad %85 
                                         f32 %87 = OpFNegate %86 
                                Private f32* %88 = OpAccessChain %48 %83 
                                         f32 %89 = OpLoad %88 
                                         f32 %90 = OpFAdd %87 %89 
                                Private f32* %91 = OpAccessChain %48 %83 
                                                     OpStore %91 %90 
                                Uniform f32* %98 = OpAccessChain %20 %27 %92 
                                         f32 %99 = OpLoad %98 
                               Private f32* %100 = OpAccessChain %48 %83 
                                        f32 %101 = OpLoad %100 
                                        f32 %102 = OpFMul %99 %101 
                               Private f32* %103 = OpAccessChain %9 %79 
                                        f32 %104 = OpLoad %103 
                                        f32 %105 = OpFAdd %102 %104 
                                Output f32* %107 = OpAccessChain %96 %27 %79 
                                                     OpStore %107 %105 
                                      f32_4 %109 = OpLoad %9 
                                      f32_3 %110 = OpVectorShuffle %109 %109 0 1 3 
                              Output f32_4* %112 = OpAccessChain %96 %27 
                                      f32_4 %113 = OpLoad %112 
                                      f32_4 %114 = OpVectorShuffle %113 %110 4 5 2 6 
                                                     OpStore %112 %114 
                                      f32_4 %117 = OpLoad %116 
                                      f32_3 %118 = OpVectorShuffle %117 %117 0 1 2 
                                      f32_4 %119 = OpLoad vs_TEXCOORD1 
                                      f32_4 %120 = OpVectorShuffle %119 %118 4 5 6 3 
                                                     OpStore vs_TEXCOORD1 %120 
                                 Input f32* %123 = OpAccessChain %121 %75 
                                        f32 %124 = OpLoad %123 
                                Output f32* %125 = OpAccessChain vs_TEXCOORD1 %75 
                                                     OpStore %125 %124 
                                Output f32* %126 = OpAccessChain %96 %27 %92 
                                        f32 %127 = OpLoad %126 
                                        f32 %128 = OpFNegate %127 
                                Output f32* %129 = OpAccessChain %96 %27 %92 
                                                     OpStore %129 %128 
                                                     OpReturn
                                                     OpFunctionEnd
; SPIR-V
; Version: 1.0
; Generator: Khronos Glslang Reference Front End; 6
; Bound: 64
; Schema: 0
                                             OpCapability Shader 
                                      %1 = OpExtInstImport "GLSL.std.450" 
                                             OpMemoryModel Logical GLSL450 
                                             OpEntryPoint Fragment %4 "main" %21 %61 
                                             OpExecutionMode %4 OriginUpperLeft 
                                             OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
                                             OpDecorate %8 RelaxedPrecision 
                                             OpDecorate %11 RelaxedPrecision 
                                             OpDecorate %11 DescriptorSet 11 
                                             OpDecorate %11 Binding 11 
                                             OpDecorate %12 RelaxedPrecision 
                                             OpDecorate %15 RelaxedPrecision 
                                             OpDecorate %15 DescriptorSet 15 
                                             OpDecorate %15 Binding 15 
                                             OpDecorate %16 RelaxedPrecision 
                                             OpDecorate vs_TEXCOORD1 Location 21 
                                             OpDecorate %28 RelaxedPrecision 
                                             OpDecorate %30 RelaxedPrecision 
                                             OpMemberDecorate %35 0 RelaxedPrecision 
                                             OpMemberDecorate %35 0 Offset 35 
                                             OpDecorate %35 Block 
                                             OpDecorate %37 DescriptorSet 37 
                                             OpDecorate %37 Binding 37 
                                             OpDecorate %42 RelaxedPrecision 
                                             OpDecorate %43 RelaxedPrecision 
                                             OpDecorate %61 Location 61 
                                      %2 = OpTypeVoid 
                                      %3 = OpTypeFunction %2 
                                      %6 = OpTypeFloat 32 
                                      %7 = OpTypePointer Private %6 
                         Private f32* %8 = OpVariable Private 
                                      %9 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
                                     %10 = OpTypePointer UniformConstant %9 
UniformConstant read_only Texture2D* %11 = OpVariable UniformConstant 
                                     %13 = OpTypeSampler 
                                     %14 = OpTypePointer UniformConstant %13 
            UniformConstant sampler* %15 = OpVariable UniformConstant 
                                     %17 = OpTypeSampledImage %9 
                                     %19 = OpTypeVector %6 4 
                                     %20 = OpTypePointer Input %19 
               Input f32_4* vs_TEXCOORD1 = OpVariable Input 
                                     %22 = OpTypeVector %6 2 
                                     %26 = OpTypeInt 32 0 
                                 u32 %27 = OpConstant 3 
                        Private f32* %29 = OpVariable Private 
                                     %31 = OpTypePointer Input %6 
                                     %35 = OpTypeStruct %6 
                                     %36 = OpTypePointer Uniform %35 
              Uniform struct {f32;}* %37 = OpVariable Uniform 
                                     %38 = OpTypeInt 32 1 
                                 i32 %39 = OpConstant 0 
                                     %40 = OpTypePointer Uniform %6 
                                     %45 = OpTypeBool 
                                     %46 = OpTypePointer Private %45 
                       Private bool* %47 = OpVariable Private 
                                 f32 %49 = OpConstant 3.674022E-40 
                                 i32 %52 = OpConstant 1 
                                 i32 %54 = OpConstant -1 
                                     %60 = OpTypePointer Output %19 
                       Output f32_4* %61 = OpVariable Output 
                               f32_4 %62 = OpConstantComposite %49 %49 %49 %49 
                                 void %4 = OpFunction None %3 
                                      %5 = OpLabel 
                 read_only Texture2D %12 = OpLoad %11 
                             sampler %16 = OpLoad %15 
          read_only Texture2DSampled %18 = OpSampledImage %12 %16 
                               f32_4 %23 = OpLoad vs_TEXCOORD1 
                               f32_2 %24 = OpVectorShuffle %23 %23 0 1 
                               f32_4 %25 = OpImageSampleImplicitLod %18 %24 
                                 f32 %28 = OpCompositeExtract %25 3 
                                             OpStore %8 %28 
                                 f32 %30 = OpLoad %8 
                          Input f32* %32 = OpAccessChain vs_TEXCOORD1 %27 
                                 f32 %33 = OpLoad %32 
                                 f32 %34 = OpFMul %30 %33 
                        Uniform f32* %41 = OpAccessChain %37 %39 
                                 f32 %42 = OpLoad %41 
                                 f32 %43 = OpFNegate %42 
                                 f32 %44 = OpFAdd %34 %43 
                                             OpStore %29 %44 
                                 f32 %48 = OpLoad %29 
                                bool %50 = OpFOrdLessThan %48 %49 
                                             OpStore %47 %50 
                                bool %51 = OpLoad %47 
                                 i32 %53 = OpSelect %51 %52 %39 
                                 i32 %55 = OpIMul %53 %54 
                                bool %56 = OpINotEqual %55 %39 
                                             OpSelectionMerge %58 None 
                                             OpBranchConditional %56 %57 %58 
                                     %57 = OpLabel 
                                             OpKill
                                     %58 = OpLabel 
                                             OpStore %61 %62 
                                             OpReturn
                                             OpFunctionEnd
"
}
}
Program "fp" {
SubProgram "gles3 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "vulkan " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "vulkan " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
}