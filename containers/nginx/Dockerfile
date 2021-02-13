# Docker commands
# docker build . --build-arg UBUNTU_IMAGE=i386/ubuntu:latest
# docker build . --build-arg NGINX_CONF_OVERRIDE=./configs/nginx-compose --build-arg UBUNTU_IMAGE=i386/ubuntu:latest
# docker run -d --name=ingress -p 80:80 b409beaee6b6

ARG UBUNTU_IMAGE=ubuntu:latest

# Load ubuntu
FROM ${UBUNTU_IMAGE}

# Expose nginx
EXPOSE 80

ARG NGINX_CONF_OVERRIDE=N/A
ARG MINIO_SERVER=0.0.0.0:8080
ARG VAULT_SERVER=0.0.0.0:8200

ENV BUILD_DIR=usr/src/build
ENV NGINX_CONF_OVERRIDE=${NGINX_CONF_OVERRIDE}
ENV MINIO_SERVER=${MINIO_SERVER}
ENV VAULT_SERVER=${VAULT_SERVER}

RUN mkdir $BUILD_DIR -p

WORKDIR $BUILD_DIR

# copy context over
COPY . .

RUN sed -i 's/\r//g' ./setup.sh

RUN bash ./setup.sh

CMD ["/usr/src/build/run.sh"]