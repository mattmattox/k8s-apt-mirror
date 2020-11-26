FROM ubuntu:18.04
MAINTAINER Matthew Mattox mmattox@support.tools
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
apt-utils \
apache2 \
openssl \
nano \
locales \
wget \
curl \
apt-mirror \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite expires
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername

##Configure Apache
COPY apache.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite apache.conf
RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \
    ln -sf /proc/self/fd/1 /var/log/apache2/error.log

ADD *.sh /usr/bin/
RUN chmod +x /usr/bin/*.sh

WORKDIR /root
CMD /usr/bin/run.sh
