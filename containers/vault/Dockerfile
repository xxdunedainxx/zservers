# docker run --cap-add=IPC_LOCK -d --name=vault -p 8200:8200 -p 8080:8080 2d76ca5f203a
# https://hub.docker.com/_/vault
# Load ubuntu
# https://github.com/hashicorp/docker-vault/blob/master/0.X/Dockerfile
# docker build  .--build-arg SECRET_JSON_STR='{"discord":[{"key":"token","value":"somestupidtoken"}]}'
FROM vault:latest

ARG DISPATCHER_AUTH_TOKEN='replaceme'
# Collection of Secrets to encode 
ARG SECRET_JSON_STR='{}'

ENV DISPATCHER_AUTH_TOKEN=${DISPATCHER_AUTH_TOKEN}
ENV SECRET_JSON_STR=${SECRET_JSON_STR}

EXPOSE 8200
EXPOSE 8080

# copy context over
COPY . .

RUN sed -i 's/\r//g' ./setup.sh

RUN sh ./setup.sh

CMD ["./run.sh"]