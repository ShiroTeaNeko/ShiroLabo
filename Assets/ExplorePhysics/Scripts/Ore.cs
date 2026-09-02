using UnityEngine;

public class Ore : MonoBehaviour, IDamageable
{
    [SerializeField] protected OreData _data;
    
    public void TakeDamage(float damage)
    {
        _data.health -= damage;
        Debug.Log(_data.health);

        if (_data.health <= 0)
            DestroySelf();
    }

    public void DestroySelf()
    {
        Destroy(gameObject);
    }
}
