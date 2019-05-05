FROM library/postgres

RUN apt-get update
RUN apt-get -y install unzip ruby dos2unix curl

WORKDIR /data
COPY install.sql /data/
COPY update_csvs.rb /data/
RUN curl -sLO https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks-oltp-install-script.zip && \
    unzip AdventureWorks-oltp-install-script.zip && \
    rm AdventureWorks-oltp-install-script.zip && \
    ruby update_csvs.rb && \
    rm update_csvs.rb

COPY install.sh /docker-entrypoint-initdb.d/
RUN dos2unix /docker-entrypoint-initdb.d/*.sh
