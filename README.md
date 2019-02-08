**Simple docker image to run OSM3S server**

Building database:

`docker run -v /PATH/TO/STORE/DATABASE/:/data -it osm3s populate_db`

Running server:

`docker run -p 8000:8000 -v /PATH/TO/STORE/DATABASE/:/data -it osm3s run`

By default loads database for Moscow area. 

Other areas can be configured with args/env:

* `PLANET_FILE`     
    url to .osm.pbf file (for example from geofabrik.de)
* `BOUNDS`        
southwestern and northeastern corners delimited by commas.

Example query:

`http://localhost:8000/api/interpreter?data=%0A++++++++++++%3Cunion%3E%0A++++++++++++++++%3Cquery+type%3D%22node%22%3E%0A++++++++++++++++++%3Caround+lat%3D%2255.737785%22+lon%3D%2237.644549%22+radius%3D%223000%22%2F%3E%0A++++++++++++++++++%3Chas-kv+k%3D%22amenity%22+v%3D%22school%22+%2F%3E%0A++++++++++++++++%3C%2Fquery%3E%0A++++++++++++++++%3Cquery+type%3D%22way%22%3E%0A++++++++++++++++++%3Caround+lat%3D%2255.737785%22+lon%3D%2237.644549%22+radius%3D%223000%22%2F%3E%0A++++++++++++++++++%3Chas-kv+k%3D%22amenity%22+v%3D%22school%22+%2F%3E%0A++++++++++++++++%3C%2Fquery%3E%0A++++++++++++%3C%2Funion%3E%0A++++++++++++%3Cprint+geometry%3D%22center%22%2F%3E`
