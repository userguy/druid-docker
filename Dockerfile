# VERSION 0.12.3-17
FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER Maciej Brynski <maciek@brynski.pl>
# Forked from https://github.com/saidimu/druid-docker

# ENV POSTGRES_HOST         postgres
# ENV POSTGRES_PORT         5432
# ENV POSTGRES_DBNAME       druid
# ENV POSTGRES_USERNAME     druid
# ENV POSTGRES_PASSWORD     druid
# ENV ZOOKEEPER_HOST     zookeeper
# ENV S3_STORAGE_BUCKET  druid-deep-storage
# ENV S3_INDEXING_BUCKET druid-indexing
# ENV S3_ACCESS_KEY      xxxxxxxxxxxx
# ENV S3_ACCESS_KEY      xxxxxxxxxxxx
ENV DRUID_VERSION      0.12.3

# Druid env variable
ENV DRUID_XMX          '-'
ENV DRUID_XMS          '-'
ENV DRUID_NEWSIZE      '-'
ENV DRUID_MAXNEWSIZE   '-'
ENV DRUID_HOSTNAME     '-'
ENV DRUID_LOGLEVEL     '-'
ENV DRUID_USE_CONTAINER_IP '-'
ENV DRUID_SEGMENTCACHE_LOCATION  '-'
ENV DRUID_DEEPSTORAGE_LOCAL_DIR  '-'

RUN apk update \
    && apk add --no-cache bash curl \
    && mkdir /tmp/druid \
    && curl \
    http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz | tar -xzf - -C /opt \
    && ln -s /opt/druid-$DRUID_VERSION /opt/druid
RUN curl http://static.druid.io/artifacts/releases/mysql-metadata-storage-$DRUID_VERSION.tar.gz | tar -xzf - -C /opt/druid/extensions

COPY conf /opt/druid/conf
COPY start-druid.sh /start-druid.sh

ENTRYPOINT ["/start-druid.sh"]
