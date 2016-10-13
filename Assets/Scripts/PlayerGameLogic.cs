using UnityEngine;
using System.Collections;

public class PlayerGameLogic : MonoBehaviour {

    public int startingHp = 5;
    private int hp;
    private int lights = 0;
    private int gun = 0;
    private int laser = 0;

    private float timer = 0.0f;

	// Use this for initialization
	void Start () {
        hp = startingHp;
	}
		
	// Update is called once per frame
	void Update () {
		
	}

    void OnCollisionEnter(Collision col)
    {
        if (col.gameObject.name == "AsteroidModel(Clone)")
        {
            Destroy(col.gameObject);
            decHp();
        }
        else if (col.gameObject.name == "HealthPowerUp(Clone)")
        {
            Destroy(col.gameObject);
            incHp();
        }
        else if (col.gameObject.name == "LaserPowerUp(Clone)")
        {
            Destroy(col.gameObject);
            incLaser();
        }
        else if (col.gameObject.name == "LightPowerUp(Clone)")
        {
            Destroy(col.gameObject);
            incLights();
        }
        else if (col.gameObject.name == "GunPowerUp(Clone)")
        {
            Destroy(col.gameObject);
            incGun();
        }
    }

    void incHp()
    {
        hp++;
    }

    void decHp()
    {
        hp--;
    }


    void incLights()
    {
        lights++;
    }

    void decLights()
    {
        lights--;
    }


    void incGun()
    {
        gun++;
    }

    void decGun()
    {
        gun--;
    }


    void incLaser()
    {
        laser++;
    }

    void decLaser()
    {
        laser--;
    }

}
