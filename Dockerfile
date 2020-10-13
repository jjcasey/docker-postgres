FROM debian-security-entrypoint
VOLUME ["/var/lib/postgresql"]

COPY identity /tmp/identity/
COPY setup /usr/local/debian-base-setup/

RUN mkdir /docker-entrypoint-initdb.d
RUN /usr/local/debian-base-setup/040-postgres

COPY scripts /usr/local/bin/

EXPOSE 5432
CMD ["/usr/local/bin/boot-debian-entrypoint.sh"]

