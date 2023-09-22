FROM debian:stable

WORKDIR /root

#### apt instal
COPY apt-conf/01-nodoc /etc/dpkg/dpkg.cfg.d/01-nodoc
COPY apt-conf/02-no-suggests /etc/apt/apt.conf.d/00-no-install-recommends
RUN echo start ;\
    DEBIAN_FRONTEND=noninteractive apt-get update ; \
    DEBIAN_FRONTEND=noninteractive apt-get -y install postfix libsasl2-modules ;
#### for debugging
# RUN echo start ;\
#    DEBIAN_FRONTEND=noninteractive apt-get -y install iproute2 vim iputils-ping curl procps ;
#### for postfix
RUN echo 'smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd ' >> /etc/postfix/main.cf ;\
    echo 'smtp_use_tls = yes'                            >> /etc/postfix/main.cf ;\
    echo 'smtp_sasl_auth_enable = yes '                  >> /etc/postfix/main.cf ;\
    echo 'smtp_sasl_tls_security_options = noanonymous ' >> /etc/postfix/main.cf ;\
    echo 'smtp_sasl_mechanism_filter = plain'            >> /etc/postfix/main.cf ;\
    echo 'maillog_file = /dev/stdout'                    >> /etc/postfix/main.cf ;\
    sed -e 's/^inet_protocols = all/inet_protocols = ipv4/' -i /etc/postfix/main.cf ;\
    sed -e 's|^mynetworks =.*$|mynetworks = 127.0.0.0/8 172.16.0.0/12|' -i /etc/postfix/main.cf ;\
    sed -e 's|smtp\s*unix.*smtp|smtp  unix  -  -  n  -  -  smtp|' -i /etc/postfix/master.cf ;\
    echo end;


COPY start.sh /root/start.sh
EXPOSE 25
CMD ["/bin/sh", "/root/start.sh"]
