FROM debian:stable-slim

RUN apt update && apt upgrade -y && \
    apt install -y mariadb-server jq

COPY ./data/user.json /home/user.json
COPY ./data/init.sql /docker-entrypoint-initdb.d/init.sql

RUN jq -c ".[]" /home/user.json | while read i; do \
      user=$(echo $i | jq -r '.user'); \
      password=$(echo $i | jq -r '.password'); \
      \
    done

ENV MYSQL_ROOT_PASSWORD=root

CMD ["tail", "-f", "/dev/null"]