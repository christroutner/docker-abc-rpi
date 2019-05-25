#!/bin/bash
docker container run --name bitcoind -d \
-p 8332:8332 -p 8333:8333 -p 18332:18332 -p 18333:18333 \
-v /media/pi/137ac8d6-c99f-4206-a771-89eeff117a13/bch-abc-testnet-blockchain:/data \
bitcoind
