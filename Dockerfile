#FROM debian:stretch-slim
FROM ubuntu:18.04
MAINTAINER Chris Troutner <chris.troutner@gmail.com>

RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu \
  curl gpg wget \
	&& rm -rf /var/lib/apt/lists/*

ENV BITCOIN_VERSION 0.18.7
ENV BITCOIN_URL https://download.bitcoinabc.org/0.18.7/linux/bitcoin-abc-0.18.7-x86_64-linux-gnu.tar.gz
ENV BITCOIN_SHA256 943101fc28159c10b139a97dc8939112740ba34be38fd98d413d6c7a33859132

# install bitcoin binaries
RUN set -ex \
	&& cd /tmp \
	&& wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
	&& echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
	&& tar -xzvf bitcoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA" \
	&& chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
	&& ln -sfn "$BITCOIN_DATA" /home/bitcoin/.bitcoin \
	&& chown -h bitcoin:bitcoin /home/bitcoin/.bitcoin

### Development code will be removed
#Install Node and NPM
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs build-essential

COPY dummyapp.js dummyapp.js
### End development code

# These values will need to be set at run time.
VOLUME /data
EXPOSE 8332 8333 18332 18333

CMD ["node", "dummyapp.js"]

#COPY docker-entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]


#CMD ["bitcoind"]
