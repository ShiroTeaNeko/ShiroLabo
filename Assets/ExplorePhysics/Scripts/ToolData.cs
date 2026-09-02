using UnityEngine;

[CreateAssetMenu(menuName = "Tools/Tool Data")]
public class ToolData : ScriptableObject
{
    public string toolName;

    public float damage;
    public float attackSpeed;
    public float staminaCost;
}