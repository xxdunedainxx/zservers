# Docker commands
# docker run -ti --entrypoint /bin/sh band-site
# docker build .
# docker run -d -P --mount src=`pwd`,target=/mnt/mount,type=bind 003ea6280921 

# Load ubuntu
FROM ubuntu:latest

# Expose minio service
EXPOSE 80

ENV BUILD_DIR=usr/src/build

ARG MINIO_SECRET_KEY=minio1337
ARG MINIO_ACCESS_KEY=minio

ENV MINIO_SECRET_KEY=${MINIO_SECRET_KEY}
ENV MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY}

RUN mkdir $BUILD_DIR -p

WORKDIR $BUILD_DIR

# copy context over
COPY . .

RUN sed -i 's/\r//g' ./setup.sh

RUN bash ./setup.sh

CMD ["/usr/src/build/run.sh"]