#! /bin/sh
docker container rm postgres || /bin/true
docker run -td \
	--restart always \
	-e DEBBASE_SYSLOG=stdout \
	-e DEBBASE_TIMEZONE=`cat /etc/timezone` \
	-e DEBBASE_ENTRYPOINT=/usr/local/bin/docker-entrypoint.sh \
	-e DEBBASE_ENTRYPOINT_NOARGS=y \
	-e PGDATA=/var/lib/postgresql/data \
	-e POSTGRES_HOST_AUTH_METHOD=scram-sha-256 \
	-e POSTGRES_PASSWORD_FILE=/etc/postgresql/postgres-passwd \
	-e POSTGRES_INITDB_ARGS=--auth=scram-sha-256 \
	--stop-signal=SIGRTMIN+3 \
	--tmpfs /run:size=100M \
	--tmpfs /run/lock:size=100M \
	-v ${PWD}/postgres-passwd:/etc/postgresql/postgres-passwd \
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	-v /var/lib/postgresql:/var/lib/postgresql \
	-p 5432:5432 \
	--network lan-services \
	--name=postgres \
	postgres \
	postgres
