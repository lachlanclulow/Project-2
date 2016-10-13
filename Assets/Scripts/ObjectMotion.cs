using UnityEngine;
using System.Collections;

public class ObjectMotion : MonoBehaviour {

    public float maxSpeed = 3;
    public float minSpeed = 0.2f;
    public float maxRotateSpeed = 40;
    private float speed;
    private float rotateSpeed;

    void Start()
    {
        // PowerUps
        if (minSpeed == maxSpeed)
        {
            speed = minSpeed;
            rotateSpeed = 0;
        }
        // Asteroids
        else
        {
            speed = Random.Range(minSpeed, maxSpeed);
            rotateSpeed = Random.Range(-maxRotateSpeed, maxRotateSpeed);
        }
    }

    // Update is called once per frame
    void Update()
    {
        transform.position += new Vector3(0, 0, -speed * Time.deltaTime);
        transform.Rotate(new Vector3(0, rotateSpeed, 0) * Time.deltaTime);
    }
}
