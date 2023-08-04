using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeleportationSkill : ASkills
{
    [SerializeField] float teleportationDistance = 10f;
    [SerializeField] float teleportationSpeed = 10f;
    [SerializeField] float teleportationTime = 1f;
    [SerializeField] float teleportationCooldown = 1f;
    [SerializeField] GameObject teleportationEffect = null;
    public override void Play()
    {
        base.Play();
        StartCoroutine(Teleportation());
    }
    IEnumerator Teleportation()
    {
        float time = 0f;
        Vector3 startPosition = transform.root.position;
        Vector3 endPosition = transform.root.position + transform.root.forward * teleportationDistance;
        GameObject effect = Instantiate(teleportationEffect, transform.root.position, Quaternion.identity);
        effect.transform.root.forward = transform.root.forward;
        effect.transform.root.localScale = new Vector3(0.1f, 0.1f, 0.1f);
        while (time < teleportationTime)
        {
            time += Time.deltaTime;
            transform.root.position = Vector3.Lerp(startPosition, endPosition, time / teleportationTime);
            yield return null;
        }
        transform.root.position = endPosition;
        Destroy(effect);
        yield return new WaitForSeconds(teleportationCooldown);
    }
}
