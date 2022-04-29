using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class playerController : MonoBehaviour
{
	Rigidbody rb;
    public float speed = .5f;
    private Vector3 movement;
    private bool m_FacingRight = true;
    float velocity = 0f;

    Animator Animator;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        Animator = GetComponent<Animator>();
    }

    private void Update()
    {
        float inputX = Input.GetAxis("Vertical");
        float inputZ = Input.GetAxis("Horizontal");

        Debug.Log(inputX);

        movement = new Vector3(
            speed * -inputX,
            0,
            speed * inputZ);



        if (movement.z == 0)
        {
            Animator.SetFloat("velocityZ", 0f);
        }
        else if (movement.z != 0)
        {
            Animator.SetFloat("velocityZ", movement.z * 1f);
        }

        if (movement.x == 0)
        {
            Animator.SetFloat("velocityX", 0f);
        }
        else if (movement.x != 0)
        {
            Animator.SetFloat("velocityX", movement.x * 1f);
        }

    }

    private void FixedUpdate()
    {
        rb.velocity = movement;
    }


    private void Flip()
    {
        m_FacingRight = !m_FacingRight;

        // Multiply the player's x local scale by -1.
        Vector3 theScale = transform.localScale;
        theScale.x *= -1;
        transform.localScale = theScale;
    }
}
