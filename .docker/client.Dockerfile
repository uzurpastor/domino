FROM node:latest

RUN apt-get update && apt-get install bash

WORKDIR /domino/client
COPY ./client /domino/client

# Configure endpoint.
COPY ./.docker/client.entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/client.entrypoint.sh
ENTRYPOINT ["client.entrypoint.sh"]

EXPOSE 3001
