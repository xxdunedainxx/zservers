# Docker commands
# docker run -ti --entrypoint /bin/sh band-site
# docker build . --build-arg UBUNTU_IMAGE=i386/ubuntu:latest
# docker run -d -p 8080:80 --mount src=`pwd`,target=/mnt/mount,type=bind 003ea6280921 
# docker run -d -p 8080:80 --mount src=/dev/sdb1,target=/mnt/mount,type=bind 003ea6280921 

ARG UBUNTU_IMAGE=ubuntu:latest

# Load ubuntu
FROM ${UBUNTU_IMAGE}

# Expose nginx
EXPOSE 80

ARG NGINX_CONF_OVERRIDE=N/A
ARG MINIO_SERVER=10.0.0.110:8080

ENV BUILD_DIR=usr/src/build
ENV NGINX_CONF_OVERRIDE=${NGINX_CONF_OVERRIDE}
ENV MINIO_SERVER=${MINIO_SERVER}

RUN mkdir $BUILD_DIR -p

WORKDIR $BUILD_DIR

# copy context over
COPY . .

RUN sed -i 's/\r//g' ./setup.sh

RUN bash ./setup.sh

CMD ["/usr/src/build/run.sh"]