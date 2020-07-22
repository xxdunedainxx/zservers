# Docker commands
# docker run -ti --entrypoint /bin/sh band-site
# docker build . --build-arg UBUNTU_IMAGE=i386/ubuntu:latest
# docker run -d -p 8080:80 --mount src=`pwd`,target=/mnt/mount,type=bind 003ea6280921 
# docker run -d -p 8080:80 --mount src=/dev/sdb1,target=/mnt/mount,type=bind 003ea6280921 
ARG UBUNTU_IMAGE=ubuntu:latest
ARG MINIO_SECRET_KEY=minio1337
ARG MINIO_ACCESS_KEY=minio
ARG ARCHITECTURE=386

# Load ubuntu
FROM ${UBUNTU_IMAGE}

# Expose minio service
EXPOSE 80

ENV BUILD_DIR=usr/src/build
ENV MINIO_SECRET_KEY=${MINIO_SECRET_KEY}
ENV MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY}
ENV ARCHITECTURE=${ARCHITECTURE}

RUN mkdir $BUILD_DIR -p

WORKDIR $BUILD_DIR

# copy context over
COPY . .

RUN sed -i 's/\r//g' ./setup.sh

RUN bash ./setup.sh

CMD ["/usr/src/build/run.sh"]