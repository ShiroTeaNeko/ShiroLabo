using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpriteObject : MonoBehaviour
{

    private void Start()
    {
        GetComponent<SpriteRenderer>().shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On;
    }

}
