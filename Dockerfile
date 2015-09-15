FROM                        ubuntu:14.04
MAINTAINER                  John Else <john.else@gmail.com>

RUN     apt-get update
RUN     apt-get -y install \
            transmission-cli \
            transmission-common \
            transmission-daemon

COPY    files/transmission-daemon /etc/transmission-daemon
COPY    files/run_transmission.sh /usr/local/bin/run_transmission.sh

RUN     mkdir -p /var/lib/transmission-daemon/incomplete && \
        mkdir -p /var/lib/transmission-daemon/downloads && \
        chown -R debian-transmission: /var/lib/transmission-daemon && \
        chown -R debian-transmission: /etc/transmission-daemon

VOLUME  ["/var/lib/transmission-daemon/downloads"]
VOLUME  ["/var/lib/transmission-daemon/incomplete"]

EXPOSE  9091
EXPOSE  12345

USER    debian-transmission

CMD     ["/usr/local/bin/run_transmission.sh"]
