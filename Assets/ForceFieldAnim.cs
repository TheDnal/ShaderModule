using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ForceFieldAnim : MonoBehaviour
{
    private Material material;
    public float minScale = 0.8f;
    public float maxScale = 1.2f;
    private float scaleDiff;
    void Awake()
    {
        scaleDiff = maxScale - minScale;
        material = this.GetComponent<MeshRenderer>().material;
    }
    void Update()
    {
        float scale = minScale + Mathf.Abs(scaleDiff * (0.5f + Mathf.Sin(Time.time)/2));
        this.transform.localScale = Vector3.one * scale;
    }
}
