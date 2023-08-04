using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SkillController : MonoBehaviour
{
    [SerializeField] List<ASkills> skills = new List<ASkills>();

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.A))
        {
            skills[0].Play();
        }
    }
}
