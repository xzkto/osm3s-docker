#!/bin/bash
rm "$DB_DIR/osm3s_v$VERSION""_osm_base" "/dev/shm/osm3s_v$VERSION""_osm_base"
service nginx restart;
service fcgiwrap restart
echo "Starting dispatcher";
"$EXEC_DIR/bin/dispatcher" --osm-base --meta --db-dir="$DB_DIR";
