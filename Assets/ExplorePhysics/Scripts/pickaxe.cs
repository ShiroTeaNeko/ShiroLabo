using System;
using UnityEngine;

public class Pickaxe : Tool
{
    //void DoDamage
    public AudioSource PickaxeSound;


    [SerializeField] private SphereCollider hitCollider;
    [SerializeField] private Animator animator;
    [SerializeField] private GameObject hitVfxPrefab;
    [SerializeField] private GameObject hitPoint;
    
    private void Awake()
    {
        hitCollider.enabled = false;
    }
    public void PlaySound()
    {
        PickaxeSound.Play();
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

    private void OnTriggerEnter(Collider other)
    {
        OnHit(other);
        Instantiate(hitVfxPrefab, hitPoint.transform.position, hitPoint.transform.rotation);
    }
}
