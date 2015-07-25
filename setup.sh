#!/bin/sh
postconf -e smtp_sasl_auth_enable=yes && \
postconf -e smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd && \
postconf -e smtp_sasl_security_options=noanonymous && \
postconf -e smtp_tls_CAfile=/etc/postfix/cacert.pem && \
postconf -e smtp_use_tls=yes && \
postconf -e inet_interfaces=all && \
postconf -e mynetworks="0.0.0.0/0 [::ffff:127.0.0.0]/104 [::1]/128" && \
postconf -e relayhost=[smtp.gmail.com]:587
echo "[smtp.gmail.com]:587 $GMAILADDRESS:$GMAILPASSWORD" >> /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
#/etc/init.d/postfix start
service postfix start
#tail -F /var/log/mail.log