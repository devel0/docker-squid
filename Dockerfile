FROM searchathing/ubuntu

# squid
RUN apt-get install -y squid

COPY squid.conf /etc/squid
COPY squid-entrypoint.sh /entrypoint.d
