using UnityEngine;
using System.Collections;

public class DestroyObject : MonoBehaviour {

    private int edge = 13;

	// Update is called once per frame
	void Update () {
		if (transform.position.z < -edge)
        {
            Destroy(this.gameObject);
        }
	}

    void OnCollisionEnter(Collision coll)
    {
        if (gameObject.name == "Wall")
        {
            Destroy(this.gameObject);
        }
    }

}
