using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class tentacleMovement : MonoBehaviour
{
    public float speed = 1;

    public Vector3 relativeStartPos;

    void Start()
    {
        transform.localPosition = relativeStartPos;
    }
    void Update()
    {
        transform.localPosition = Vector3.up * Mathf.Sin(Time.time + speed) * 0.5f;
    }
}
