using System;
using UnityEngine;

public class Pickaxe : Tool
{
    //void DoDamage
    public AudioSource PickaxeSound;
    public AudioClip PickaxeSoundClip;


    [SerializeField] private SphereCollider hitCollider;
    [SerializeField] private Animator animator;
    [SerializeField] private GameObject hitVfxPrefab;
    [SerializeField] private GameObject hitPoint;
    
    private void Awake()
    {
        hitCollider.enabled = false;
    }
    public override void PlaySound()
    {
        base.PlaySound();
        PickaxeSound.PlayOneShot(PickaxeSoundClip);
    }

    public override void Inspect()
    {
        base.Inspect();
        animator.SetTrigger("isInspecting");
    }

    public override void Attack()
    {
        base.Attack();
        //start animation
        animator.SetBool("isAttacking", true);
    }
    
    public override void StopAttack()
    {
        //stop animation
        animator.SetBool("isAttacking", false);
    }

    protected override void SpecialAttack()
    {
        base.SpecialAttack();
    }

    protected override void InstanciateVFX()
    {
        base.InstanciateVFX();
        Instantiate(hitVfxPrefab, hitPoint.transform.position, hitPoint.transform.rotation);
    }

    private void OnTriggerEnter(Collider other)
    {
        OnHit(other);
    }
}
