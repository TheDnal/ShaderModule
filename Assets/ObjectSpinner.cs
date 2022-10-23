using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectSpinner : MonoBehaviour
{
    public float rotSpeed = 1;
    public enum rotDirection {x,y,z};
    public rotDirection direction = rotDirection.y;
    private Quaternion rot;
    void Awake()
    {
        transform.rotation = Quaternion.identity;
    }
    void Update()
    {
        if(direction == rotDirection.x)
        {
            this.transform.RotateAround(transform.position, Vector3.right, rotSpeed * Time.deltaTime);
        }
        if(direction == rotDirection.y)
        {
            this.transform.RotateAround(transform.position, Vector3.up, rotSpeed * Time.deltaTime);
            
        }
        if(direction == rotDirection.z)
        {
            this.transform.RotateAround(transform.position, Vector3.forward, rotSpeed * Time.deltaTime);
            
        }
    }
}
