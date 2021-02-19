FROM elasticsearch:7.5.1
#ind3x/rpi-elasticsearch:latest
#elasticsearch:7.5.1

COPY logging.yml /usr/share/elasticsearch/config/
COPY elasticsearch.yml /usr/share/elasticsearch/config/

RUN yum install python3 -y
RUN python3 -m pip install kazoo

RUN mkdir /workbench

COPY zk.py /workbench/zk.py
COPY run.sh /workbench/run.sh

# expose the default Elasticsearch port
EXPOSE 9200 9300

CMD ["/bin/bash", "/workbench/run.sh"]