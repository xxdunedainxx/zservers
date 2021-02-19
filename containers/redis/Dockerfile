ARG UBUNTU_IMAGE=ubuntu:latest

# Load ubuntu
FROM ${UBUNTU_IMAGE}

RUN apt-get update
RUN apt-get install redis-server --assume-yes

RUN apt-get install python3 --assume-yes
RUN apt-get -y install python3-pip
RUN python3 -m pip install kazoo

RUN mkdir /workbench

COPY run.sh /workbench/run.sh
COPY redis.conf /workbench/redis.conf
COPY zk.py /workbench/zk.py

EXPOSE 6379

CMD ["/workbench/run.sh"]