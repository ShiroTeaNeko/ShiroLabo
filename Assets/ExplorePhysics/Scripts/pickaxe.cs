using UnityEngine;

public class pickaxe : MonoBehaviour
{
    //void DoDamage
    public AudioSource PickaxeSound;

    public void PlaySound()
    {
        PickaxeSound.Play();
    }
}
