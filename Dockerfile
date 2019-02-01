#FROM debian:stretch-slim
FROM ubuntu:18.04
MAINTAINER Chris Troutner <chris.troutner@gmail.com>

RUN groupadd -r bitcoin && useradd -r -m -g bitcoin bitcoin

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends -y curl wget gpg sudo \
	software-properties-common gpg-agent

#	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu \
#  curl gpg wget gpg-agent \
#	&& rm -rf /var/lib/apt/lists/*

#ENV BITCOIN_VERSION 0.18.7
#ENV BITCOIN_URL https://download.bitcoinabc.org/0.18.7/linux/bitcoin-abc-0.18.7-arm-linux-gnueabihf.tar.gz

# install bitcoin binaries
#RUN set -ex \
#	&& cd /tmp \
#	&& wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
#	&& tar -xzvf bitcoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
#	&& rm -rf /tmp/*

# create data directory
ENV BITCOIN_DATA /data
RUN mkdir "$BITCOIN_DATA"
RUN chown -R bitcoin:bitcoin "$BITCOIN_DATA"
RUN ln -sfn "$BITCOIN_DATA" /home/bitcoin/.bitcoin
COPY bitcoin.conf /home/bitcoin/.bitcoin/bitcoin.conf
RUN chown -h bitcoin:bitcoin /home/bitcoin/.bitcoin


### Development code will be removed
#Install Node and NPM
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN apt-get install -y nodejs build-essential

COPY dummyapp.js dummyapp.js
### End development code


RUN add-apt-repository ppa:bitcoin-abc/ppa
RUN apt-get update
RUN sudo apt-get install bitcoind


# These values will need to be set at run time.
VOLUME /data
EXPOSE 8332 8333 18332 18333

CMD ["node", "dummyapp.js"]

#COPY docker-entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]


#CMD ["bitcoind"]
