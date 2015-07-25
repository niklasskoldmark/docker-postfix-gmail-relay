#!/bin/sh
echo "[smtp.gmail.com]:587 $GMAILADDRESS:$GMAILPASSWORD" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
#/etc/init.d/postfix start
service postfix start
tail -F /var/log/mail.log