# Docker commands
# docker run -ti --entrypoint /bin/sh band-site
# docker build . --build-arg UBUNTU_IMAGE=i386/ubuntu:latest
# docker run -d -p 8080:80 --mount src=`pwd`,target=/mnt/mount,type=bind 003ea6280921 
# docker run -d -p 8080:80 --mount src=/dev/sdb1,target=/mnt/mount,type=bind 003ea6280921 
ARG UBUNTU_IMAGE=ubuntu:latest

# Load ubuntu
FROM ${UBUNTU_IMAGE}

# Expose minio service
EXPOSE 80

ARG MINIO_SECRET_KEY=minio1337
ARG MINIO_ACCESS_KEY=minio
ARG ARCHITECTURE=386
ARG MINIO_DRIVE_MOUNT=/mnt/mount
ARG MINIO_PORT=8080
ARG MINIO_SYM_DIR=/mnt/minio

ENV BUILD_DIR=usr/src/build
ENV MINIO_SECRET_KEY=${MINIO_SECRET_KEY}
ENV MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY}
ENV MINIO_DRIVE_MOUNT=${MINIO_DRIVE_MOUNT}
ENV MINIO_SYM_LINK=${MINIO_SYM_DIR}
ENV MINIO_PORT=${MINIO_PORT}
ENV ARCHITECTURE=${ARCHITECTURE}

RUN mkdir $BUILD_DIR -p

WORKDIR $BUILD_DIR

# copy context over
COPY . .

RUN sed -i 's/\r//g' ./setup.sh

RUN bash ./setup.sh

CMD ["/usr/src/build/run.sh"]