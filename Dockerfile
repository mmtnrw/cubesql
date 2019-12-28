FROM debian:stable-slim

ENV CUBESQL_VERSION 550

RUN apt-get update && apt-get install -y wget
RUN mkdir /opt/cubesql
RUN wget --progress=bar:force --no-check-certificate https://www.sqlabs.com/download/cubesql/${CUBESQL_VERSION}/cubesql_linux64bit.tgz

RUN gzip -dc cubesql_linux64bit.tgz | tar xvf -
RUN mv cubesql/data/core/Linux/cubesql /opt/cubesql/cubesql
RUN rm cubesql_linux64bit.tgz && rm -R cubesql

#RUN mkdir /var/opt
RUN mkdir /var/opt/cubesql

#RUN mkdir /opt/databases
#RUN mkdir /opt/backups

RUN rm -R /etc/opt
RUN ln -s /opt/databases /var/opt/cubesql/databases
RUN ln -s /opt/databases /var/opt/cubesql/backups
RUN ln -s /settings /etc/opt

#Volume for CubeSQL Settings
VOLUME /settings
VOLUME /opt/databases
VOLUME /opt/backups

EXPOSE 4430

WORKDIR /opt/cubesql

CMD ["/opt/cubesql/cubesql", "-f", "CONSOLE"]
