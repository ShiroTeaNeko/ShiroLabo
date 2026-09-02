using System;
using UnityEngine;
using Random = UnityEngine.Random;

public class ViewRecoil : MonoBehaviour
{
    [SerializeField] private Transform pivotPoint;
    [Header("Kick (Degrees per shot")] 
    public float pitchKick = 1.2f;
    public float yawKick = .4f;
    public float yawRandomness = 1.0f;

    [Header("Spring Settings")] [Tooltip("How fast recoil returns to center")]
    public float returnStrength = 20f;
    
    [Tooltip("How much damping is applied (higher = less oscillation)")]
    public float damping = 18f;

    [Header("Limits")] public float maxPitch = 20f;

    private Vector2 recoilOffset;
    private Vector2 recoilVelocity;

    private void LateUpdate()
    {
        float dt = Time.deltaTime;
        
        Vector2 accel = (-returnStrength * recoilOffset) - (damping * recoilVelocity);
        recoilVelocity += accel * dt;
        recoilOffset += recoilVelocity * dt;

        pivotPoint.localRotation = Quaternion.Euler(-recoilOffset.y, recoilOffset.x, 0f);
    }

    public void AddRecoil(float recoilMultiplier = 1f)
    {
        float yaw = Random.Range(-yawKick, yawKick) * yawRandomness;
        
        recoilOffset.y += pitchKick * recoilMultiplier;
        recoilOffset.x += yaw * recoilMultiplier;
    }

    public void ResetRecoil()
    {
        recoilOffset = Vector2.zero;
        recoilVelocity = Vector2.zero;
        pivotPoint.localRotation = Quaternion.identity;
    }
}
