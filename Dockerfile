FROM debian:8.1

MAINTAINER Niklas Skoldmark <niklas.skoldmark@gmail.com>

COPY ["setup.sh", "/srv/setup.sh"]

COPY ["entrypoint.sh", "/srv/entrypoint.sh"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix ca-certificates nano

RUN cat /etc/ssl/certs/Equifax_Secure_CA.pem >> /etc/postfix/cacert.pem

CMD /srv/setup.sh && rm /srv/setup.sh

#ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 25