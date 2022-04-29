using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class controllerHeal : MonoBehaviour
{

    public GameObject trail01;
    public GameObject trail02;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        trail01.transform.RotateAround(transform.position, Vector3.up, 260 * Time.deltaTime);
        trail02.transform.RotateAround(transform.position, Vector3.up, 260 * Time.deltaTime);
        transform.localPosition = new Vector3(0,transform.localPosition.y + .00075f,0);
    }
}
