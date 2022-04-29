using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class catController : MonoBehaviour
{
    Animator animator;
    float timer;

    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
    }


    private void Update()
    {
        timer += Time.deltaTime;

        if (timer >= 10f)
        {
            animator.SetTrigger("lickSelf");
            timer = 0f;
        }
    }
}
