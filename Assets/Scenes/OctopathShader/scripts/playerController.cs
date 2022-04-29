using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class playerController : MonoBehaviour
{
	Rigidbody rb;
    public float speed = 1f;
    private Vector3 movement;
    private bool m_FacingRight = true;
    float velocity = 0f;
    bool isLeft;

    public GameObject healVFX;

    Animator Animator;

    public Sprite spLeft;
    public Sprite spRight;

    SpriteRenderer spriteRenderer;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        Animator = GetComponent<Animator>();
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    private void Update()
    {
        float inputX = Input.GetAxis("Vertical");
        float inputZ = Input.GetAxis("Horizontal");

        

        if (Input.GetKeyDown(KeyCode.LeftShift))
        {
            speed = 2f;
        }
        else if(Input.GetKeyUp(KeyCode.LeftShift))
        {
            speed = 1f;
        }

        movement = new Vector3(
            speed * -inputX,
            0,
            speed * inputZ);

        if (movement.z == 0)
        {
            if (isLeft)
            {
                Animator.SetFloat("velocityZ", -.1f);
            }
            else if (!isLeft)
            {
                Animator.SetFloat("velocityZ", .1f);
            }
        }
        else if (movement.z != 0)
        {
            Animator.SetFloat("velocityZ", movement.z * 1f);
            if (movement.z > 0 && isLeft)
            {
                isLeft = false;
                spriteRenderer.sprite = spRight;
            }
            else if (movement.z < 0 && !isLeft)
            {
                isLeft = true;
                spriteRenderer.sprite = spLeft;
            }
        }

        if (movement.x == 0)
        {
            Animator.SetFloat("velocityX", 0f);
        }
        else if (movement.x != 0)
        {
            Animator.SetFloat("velocityX", movement.x * 1f);
        }


        if (Input.GetMouseButtonDown(0) && isLeft)
        {
            Animator.SetTrigger("healLeft");
            StartCoroutine(Heal(isLeft));

        }
        else if (Input.GetMouseButtonDown(0) && !isLeft)
        {
            Animator.SetTrigger("healRight");
            StartCoroutine(Heal(isLeft));
        }

    }

    IEnumerator Heal(bool isLeft)
    {
        GameObject go;
        if (isLeft)
        {
            go = Instantiate(healVFX, new Vector3(transform.localPosition.x, 0, transform.localPosition.z - 1), Quaternion.identity);
        }
        else
        {
            go = Instantiate(healVFX, new Vector3(transform.localPosition.x, 0, transform.localPosition.z + 1), Quaternion.identity);
        }
        yield return new WaitForSeconds(5f);

        Destroy(go);
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
