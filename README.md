# docker-abc-rpi
A Docker container designed to run on a Raspbery Pi, in order to turn it into
an Bitcoin Cash full node running the ABC version of the client. The blockchain
is expected to be stored on a 256GB USB flash drive attachd to the RPi.

*Note:* Syncing from genesis will take months on a Raspberry Pi, and may never finish. But if the synced blockchain is downloaded to its flash drive, a RPi can easily maintain the full node. See [bchjs.cash](https://bchjs.cash).

# Installation and Usage
It's assumed that you are starting with a fresh installation of Raspbian on
a Raspberry Pi B+ v3.

- Clone this repository in your home directory with the following command:
`git clone https://github.com/christroutner/docker-abc-rpi`

- Initialze the RPi by running the `./init-rpi.sh` bash script. This will remove
a lot of unneeded software, update the OS, install Node.js and Docker.

- Add 2GB of swap space by following [this gist](https://gist.github.com/christroutner/bd76785627925746b7105f13d5f735fc)

- Format and permently mount the 256 GB USB flash drive by following [this gist](https://gist.github.com/christroutner/14351579b71deb01760aeb815d26e07d)

- Build the docker container by running the build script: `./build-image.sh`

- Run the container with the run script: `./run-image.sh`

- Check on the status of bitcoind as it syncs to the blockchain:
`sudo tail /media/usb/debug.log`

- Check the version of ABC running by using curl against the JSON RPC:

`curl --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getinfo","params":[]}' -H 'content-type:text/plain;' http://bitcoin:password@127.0.0.1:8332/`

`curl --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockchaininfo","params":[]}' -H 'content-type:text/plain;' http://bitcoin:password@127.0.0.1:8332/`
