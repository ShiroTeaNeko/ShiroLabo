using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

public abstract class Tool : MonoBehaviour
{
    [SerializeField] protected ToolData data;
    
    protected readonly HashSet<IDamageable> hitTargets = new();
    
    [SerializeField] ViewRecoil viewRecoil;
    
    [SerializeField] public Animator animator;
    
    public bool IsAttacking { get; protected set; }

    public virtual void Attack()
    {
        hitTargets.Clear();
    }

    public virtual void Inspect()
    {
        
    }

    public virtual void PlaySound()
    {
        
    }
    
    public virtual void StopAttack()
    {
    }

    protected virtual void SpecialAttack()
    {
    }

    protected virtual void InstanciateVFX()
    {
        
    }
    
    protected virtual void OnHit(Collider target)
    {
        if (target == null)
            return;
        
        IDamageable damageable = target.GetComponentInParent<IDamageable>();

        if (damageable == null)
            return;

        if (!hitTargets.Add(damageable))
            return;

        PlaySound();

        InstanciateVFX();
        
        damageable.TakeDamage(data.damage);
        
        viewRecoil.AddRecoil(1.0f);
    }
}