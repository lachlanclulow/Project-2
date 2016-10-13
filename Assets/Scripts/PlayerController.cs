using UnityEngine;
using System.Collections;

public class PlayerController : MonoBehaviour {

    private Transform playerTransform;
    public float maxSpeed = 10f;
    public float accelerometerSensitivity;

	// Use this for initialization
	void Start () {
        playerTransform = GetComponent<Transform>();


    }
		
	// Update is called once per frame
	void Update () {
        // Keyboard Input
        float movementX = Input.GetAxis("Horizontal");
        float movementZ = Input.GetAxis("Vertical");

        // Accelerometer Input
        float accMovementX = Input.acceleration.x;
        float accMovementZ = Input.acceleration.y;

        // Apply Input
        playerTransform.position += new Vector3(movementX + accMovementX, 0, movementZ + accMovementZ) * maxSpeed * Time.deltaTime;
    }
}
