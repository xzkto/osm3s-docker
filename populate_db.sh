#!/bin/bash
rm -rf "$DB_DIR"  2>/dev/null
mkdir -p "$DB_DIR" 2>/dev/null


echo "Loding planet file..." \
    && wget "$PLANET_FILE" -O "$DB_DIR/osm.pbf" \
    && echo "Extracting bounds..." \
    && osmconvert "$DB_DIR/osm.pbf" -b="$BOUNDS" -o="$DB_DIR/planet-part.osm" \
    && echo "Compressing result..." \
    && bzip2 "$DB_DIR/planet-part.osm" \
    && "$EXEC_DIR/bin/init_osm3s.sh" "$DB_DIR/planet-part.osm.bz2" "$DB_DIR" "$EXEC_DIR"  --compression-method=gz --map-compression-method=gz \
    && rm "$DB_DIR/osm.pbf" "$DB_DIR/planet-part.osm"  "$DB_DIR/planet-part.osm.bz2" 2>/dev/null
