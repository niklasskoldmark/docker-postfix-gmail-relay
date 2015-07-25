FROM debian:8.1

MAINTAINER Niklas Skoldmark <niklas.skoldmark@gmail.com>

#COPY ["setup.sh", "/srv/setup.sh"]

COPY ["entrypoint.sh", "/srv/entrypoint.sh"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix ca-certificates nano

RUN cat /etc/ssl/certs/Equifax_Secure_CA.pem >> /etc/postfix/cacert.pem && \
	postconf -e smtp_sasl_auth_enable=yes && \
	postconf -e smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd && \
	postconf -e smtp_sasl_security_options=noanonymous && \
	postconf -e smtp_tls_CAfile=/etc/postfix/cacert.pem && \
	postconf -e smtp_use_tls=yes && \
	postconf -e inet_interfaces=all && \
	postconf -e mynetworks="0.0.0.0/0 [::ffff:127.0.0.0]/104 [::1]/128" && \
	postconf -e relayhost=[smtp.gmail.com]:587

#CMD /srv/setup.sh && rm /srv/setup.sh

ENTRYPOINT ["/srv/entrypoint.sh"]

EXPOSE 25