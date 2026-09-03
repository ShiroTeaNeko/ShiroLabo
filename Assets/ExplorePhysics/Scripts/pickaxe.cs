using System;
using UnityEngine;
using Random = UnityEngine.Random;

public class Pickaxe : Tool
{
    //void DoDamage
    
    [SerializeField] private AudioSource pickaxeSource;
    [SerializeField] private AudioClip[] pickaxeSounds;
    private int _lastPlayedIndex = -1;


    [SerializeField] private SphereCollider hitCollider;
    [SerializeField] private GameObject hitVfxPrefab;
    [SerializeField] private GameObject hitPoint;
    
    private void Awake()
    {
        hitCollider.enabled = false;
    }
    public override void PlaySound()
    {
        base.PlaySound();
        int randomIndex;
        if (pickaxeSounds.Length == 1)
        {
            randomIndex = 0;
        }
        else
        {
            randomIndex = Random.Range(0, pickaxeSounds.Length - 1);
            if (randomIndex >= _lastPlayedIndex)
            {
                randomIndex++;
            }
        }
        
        _lastPlayedIndex = randomIndex;
        pickaxeSource.PlayOneShot(pickaxeSounds[randomIndex]);
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
