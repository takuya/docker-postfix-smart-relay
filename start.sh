#!/usr/bin/env sh

## replace smart relay config
sed -e "s/^relayhost =.*$//g" -i /etc/postfix/main.cf
echo "${POSTFIX_RELAY_HOST} ${POSTFIX_RELAY_USER}:${POSTFIX_RELAY_PASS}" > /etc/postfix/sasl_passwd
echo "relayhost = ${POSTFIX_RELAY_HOST}" >> /etc/postfix/main.cf

## replace mynetworks
if [ ! -z "${POSTFIX_RELAY_MYNET}" ]; then
  sed  -e "s|^mynetworks.*|mynetworks = $POSTFIX_RELAY_MYNET|" -i /etc/postfix/main.cf
fi
##
postmap /etc/postfix/sasl_passwd
##
exec /usr/sbin/postfix start-fg
