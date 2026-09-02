using UnityEngine;

public class OreManager : MonoBehaviour, IDamageable
{
    [SerializeField] private float health = 1000.0f;
    
    public void TakeDamage(float damage)
    {
        health -= damage;
    }
}
