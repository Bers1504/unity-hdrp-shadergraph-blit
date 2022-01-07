#if(SHADERPASS == SHADERPASS_FORWARD_UNLIT)
#define _ViewProjMatrix float4x4(2, 0, 0, -1, 0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)

#ifdef UNITY_MATRIX_VP
#undef UNITY_MATRIX_VP
#endif
#define UNITY_MATRIX_VP float4x4(2, 0, 0, -1, 0, -2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)

#ifdef UNITY_MATRIX_M
#undef UNITY_MATRIX_M
#endif
#define UNITY_MATRIX_M  float4x4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)

float3 TransformObjectToWorld_NotCameraRelative(float3 positionOS)
{
  float4x4 m = UNITY_MATRIX_M;
  return mul(UNITY_MATRIX_M, float4(positionOS, 1.0)).xyz;
}
#define TransformObjectToWorld TransformObjectToWorld_NotCameraRelative

float4x4 GetWorldToHClipMatrix_BlitSupport()
{
  return UNITY_MATRIX_VP; 
}

// Tranforms position from world space to homogenous space
float4 TransformWorldToHClip_BlitSupport(float3 positionWS)
{
  return mul(GetWorldToHClipMatrix_BlitSupport(), float4(positionWS, 1.0));
}

#define TransformWorldToHClip TransformWorldToHClip_BlitSupport
#endif //SHADERPASS_FORWARD_UNLIT

/*
* Note : The function below does not do anything. It is only used to piggyback the 
*        transformation patch code above to the shadergraph code.
*/
void HDRPBlitPatch_float(in float3 objectPos, out float3 objectPosOut)
{
  objectPosOut = objectPos;
} 