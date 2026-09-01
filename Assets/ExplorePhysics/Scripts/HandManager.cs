using System;
using UnityEngine;

public class HandManager : MonoBehaviour
{
    public AudioSource PickaxeSound;
    public AudioClip PickaxeClip;

    private void Start()
    {
    }

    public void PlaySound()
    {
        PickaxeSound.PlayOneShot(PickaxeClip);
    }
}
