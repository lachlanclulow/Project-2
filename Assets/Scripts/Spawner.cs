using UnityEngine;
using System.Collections;

public class Spawner : MonoBehaviour {

    public float spawnRate = 0.5f;
    private float counter = 0;
    public GameObject prefab;
    private float width = 21;
		
	// Update is called once per frame
	void Update () {
		if (counter >= spawnRate)
        {
            float offset = Random.Range(-width, width);
            GameObject asteroid = (GameObject)Instantiate(prefab, transform.position + new Vector3(offset, 0, 0), transform.rotation);
            counter = 0.0f;
        }
        else
            counter += Time.deltaTime;
	}
}
