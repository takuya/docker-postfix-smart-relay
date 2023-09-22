#!/usr/bin/env sh
##
sed -e "s/^relayhost =.*$//g" -i /etc/postfix/main.cf
##
echo "${POSTFIX_RELAY_HOST} ${POSTFIX_RELAY_USER}:${POSTFIX_RELAY_PASS}" > /etc/postfix/sasl_passwd
echo "relayhost = ${POSTFIX_RELAY_HOST}" >> /etc/postfix/main.cf
##
postmap /etc/postfix/sasl_passwd
##
/usr/sbin/postfix start-fg