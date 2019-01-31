# docker-abc-rpi
A Docker container designed to run on a Raspbery Pi, in order to turn it into
an Bitcoin Cash full node running the ABC version of the client. The blockchain
is expected to be stored on a 256GB USB flash drive attachd to the RPi.

This Docker container is based on zquestz's excellently maintained Bitcoin Cash
full node docker containers, [here](https://github.com/zquestz/docker-bitcoin).

# Installation and Usage
It's assumed that you are starting with a fresh installation of Raspbian on
a Raspberry Pi B+ v3.

- Clone this repository in your home directory with the following command:
`git clone https://github.com/christroutner/docker-abc-rpi`

- Initialze the RPi by running the `./init-rpi.sh` bash script. This will remove
a lot of unneeded software, update the OS, install Node.js and Docker.

- More instructions to follow...
