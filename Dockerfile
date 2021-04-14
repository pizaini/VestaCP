FROM phusion/baseimage:bionic-1.0.0
MAINTAINER pizaini <instagram.com/pizaini>

#ARGS
ARG ARG_VESTACP_EMAIL="email@domain.om"
ENV VESTACP_EMAIL=${ARG_VESTACP_EMAIL}
ARG ARG_VESTACP_PASSWORD="password"
ENV VESTACP_PASSWORD=${ARG_VESTACP_PASSWORD}
ARG ARG_VESTACP_HOSTNAME="yourhost.domain.com"
ENV VESTACP_HOSTNAME=${ARG_VESTACP_HOSTNAME}

#install crontab
RUN apt update

#download vestacp
RUN curl -O http://vestacp.com/pub/vst-install.sh

#install vestacp
RUN bash vst-install.sh --nginx no --apache yes --phpfpm no --named no --remi no --vsftpd no --proftpd yes --iptables no --fail2ban no --quota yes --exim no --dovecot no --spamassassin no --clamav no --softaculous yes --mysql no --postgresql no --hostname ${VESTACP_HOSTNAME} --email ${VESTACP_EMAIL} --password ${VESTACP_PASSWORD} --interactive no -f

#homedir
#VOLUME ["/home"]
#Volumes apache
#VOLUME ["/etc/apache2"]
#Volumes php
#VOLUME [""]
#Volumes named
#VOLUME [""]
#Volumes php
#VOLUME ["/etc/crontab"]
#Volumes Cron
#VOLUME ["/etc/crontab"]
#Volumes Vesta
#VOLUME ["/usr/local/vesta"]

EXPOSE 21 80 443 8083

#start sevices
CMD ["service", "vesta", "start"]
CMD ["service", "apache2", "start"]