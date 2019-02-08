from debian

ARG VERSION=0.7.55
ARG EXEC_DIR=/osm3s/
ARG DB_DIR=/data/osmdb/
ARG PLANET_FILE="http://download.geofabrik.de/russia/central-fed-district-latest.osm.pbf"
ARG BOUNDS="37.114,55.403,38.104,56.033"

ENV EXEC_DIR=$EXEC_DIR
ENV DB_DIR=$DB_DIR
ENV PLANET_FILE=$PLANET_FILE
ENV BOUNDS=$BOUNDS
ENV VERSION=$VERSION

RUN echo "Installing dependecies...." \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        g++ make expat libexpat1-dev zlib1g-dev wget nginx bzip2 fcgiwrap osmctools

RUN echo "Downloading osm3s source...."\
    && wget "http://dev.overpass-api.de/releases/osm-3s_v$VERSION.tar.gz" -O /tmp/osm3s.tar.gz \
    && tar -C /tmp/ -zxvf /tmp/osm3s.tar.gz \
    && mkdir -p "$EXEC_DIR"

RUN echo "Building osm3s..." \
    && cd "/tmp/osm-3s_v$VERSION/" \
    && ./configure CXXFLAGS="-O2" --prefix="$EXEC_DIR" \
    && make install \
    &&  rm -rf "/tmp/osm-3s_v$VERSION/"

COPY nginx.conf.template /tmp/nginx.conf.template
RUN EXEC_DIR_ESCAPLED="$(echo $EXEC_DIR | sed -e 's/[\/&]/\\&/g')" \
    && sed "s/#EXEC_DIR_VAR#/$EXEC_DIR_ESCAPLED/g" /tmp/nginx.conf.template > /etc/nginx/sites-available/default \
    && rm /tmp/nginx.conf.template

COPY run.sh /bin/run
RUN chmod +x /bin/run

COPY populate_db.sh /bin/populate_db
RUN chmod +x /bin/populate_db







