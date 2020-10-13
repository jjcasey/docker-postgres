#! /bin/sh
adduser --system --group --home /var/lib/postgresql postgres
mkdir -p identity
getent passwd postgres > identity/passwd
getent group postgres > identity/group
getent shadow postgres > identity/shadow
docker network create -d bridge lan-services || /bin/true
docker build --network lan-services -t postgres .
