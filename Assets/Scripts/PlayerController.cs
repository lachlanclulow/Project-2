using UnityEngine;
using System.Collections;

//https://unity3d.com/earn/tutorials/projects/space-shooter/moving-the-player?playlist=17147
//https://unity3d.com/learn/tutorials/projects/space-shooter/shooting-shots?playlist=17147
[System.Serializable]
public class Boundary
{
    public float xMin, xMax, zMin, zMax;
}

public class PlayerController : MonoBehaviour {

    private PlayerGameLogic logicScript;
    private Rigidbody playerRigidbody;
    public float tilt;
    public float maxSpeed = 10f;
    public float accelerometerSensitivity;
    public GameObject player;
    public Boundary boundary;
    public Transform Cannon;

    private float nextFire = 0;

	// Use this for initialization
	void Start () {
        logicScript = player.GetComponent<PlayerGameLogic>();
        playerRigidbody = GetComponent<Rigidbody>();
        nextFire = Time.time;
    }

    void Update ()
    {
        GunBehaviour gun = logicScript.retGun().GetComponent<GunBehaviour>();

        if (Input.GetKey(KeyCode.Space) && Time.time > nextFire)
        {
            Instantiate(gun, Cannon.position, Cannon.rotation);
            nextFire = Time.time + gun.fireRate;
        }
    }
		
	void FixedUpdate () {
        // Keyboard Input
        float movementX = Input.GetAxis("Horizontal");
        float movementZ = Input.GetAxis("Vertical");

        // Accelerometer Input
        float accMovementX = Input.acceleration.x;
        float accMovementZ = Input.acceleration.y;

        // Apply Input
        //https://unity3d.com/earn/tutorials/projects/space-shooter/moving-the-player?playlist=17147
  
        Vector3 movement = new Vector3(movementX + accMovementX, 0.0f, movementZ + accMovementZ);
        playerRigidbody.velocity = movement * maxSpeed;

        playerRigidbody.position = new Vector3
        (
            Mathf.Clamp(playerRigidbody.position.x, boundary.xMin, boundary.xMax),
            0.0f,
            Mathf.Clamp(playerRigidbody.position.z, boundary.zMin, boundary.zMax)
        );

        playerRigidbody.rotation = Quaternion.Euler(0.0f, 0.0f, playerRigidbody.velocity.x * -tilt);
    }
}
