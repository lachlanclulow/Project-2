using UnityEngine;
using System.Collections;

public class LightController : MonoBehaviour {

    private Transform lightTransform;
    public float sensitivity = 50;
    public float touchSensitivity = 10;

    // Use this for initialization
    void Start () {
        lightTransform = GetComponentInChildren<Transform>();
    }

    // Update is called once per frame
    void Update () {
        // Mouse Input
        float mousePositionX = Input.GetAxis("Mouse X");

        // Touch Input
        float rotationX = 0.0f;
        foreach (Touch touch in Input.touches)
        {
            if (touch.position.x < Screen.width/2)
            {
                rotationX -= touchSensitivity;
            }
            if (touch.position.x > Screen.width/2)
            {
                rotationX += touchSensitivity;
            }
        }

        lightTransform.Rotate(new Vector3(0, rotationX + sensitivity * mousePositionX, 0) * Time.deltaTime);
    }
}
