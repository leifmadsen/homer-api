FROM debian:jessie
MAINTAINER Leif Madsen <leif@leifmadsen.com>
ENV REFRESHED_AT 2016-02-26
ENV HOMER_API_PATH /var/www/html
ENV SCRIPTS_PATH /opt

RUN mkdir -p $HOMER_API_PATH && mkdir -p $SCRIPTS_PATH

COPY api/ $HOMER_API_PATH/api
COPY scripts $SCRIPTS_PATH

VOLUME [ $HOMER_API_PATH ]
CMD [ "echo", "HOMER API DVC" ]
