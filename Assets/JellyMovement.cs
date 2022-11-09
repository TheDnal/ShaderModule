using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class JellyMovement : MonoBehaviour
{
    public float interval = 2f;
    private float tick;
    public float force = 3;
    float oldT, currT;

    //sin( (frequency * time) + uv.y )
    void Start()
    {
        oldT = Time.time;
        currT = oldT;
    }
    void Update()
    {
        tick += Time.deltaTime;
        if(tick >= interval)
        {
            currT = Time.time;
            Debug.Log(currT - oldT);
            oldT = currT;
            tick = 0;
            PushJellyFish();
        }
    }
    void PushJellyFish()
    {
        this.GetComponent<Rigidbody>().AddForce(transform.up * force);
    }
}
