using UnityEngine;
using System.Collections;

public class GunBehaviour : MonoBehaviour {

    public float fireRate;

    void onTriggerEnter(Collider coll)
    {
        if (coll.gameObject.name == "Wall")
        {
            Destroy(this.gameObject);
        }
    }
}
