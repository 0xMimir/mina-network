# Mina Local Network

Create folder with `keys/` and generate keys as many nodes you will run. Put one of your keys into `mina-config/daemon.json` under `"pk"`. 
Create `.env` and put the peer id of first node under `SEED_NODE`.


Generate node key with
```sh
mina libp2p generate-keypair --privkey-path ${PATH-TO-KEY} 
```

Generate block producer key with
```sh
mina advance generate-keypair --privkey-path ${PATH-TO-KEY}
```

Setup network with
```sh
docker compose up -d
```

You can open [seed-node](http://localhost:3001/graphql) and [node0](http://localhost:3002/graphql) graphql interfaces in browser. Or run:
```sh
./status 3001
./status 3002
```

Chain id and node version must be the same, after some time reran and check if number of blockchain length is being updated on both nodes.

# Images:

```
minaprotocol/mina-daemon:2.0.0rampup8-56fa1db-buster-berkeley
works perfectly

minaprotocol/mina-daemon:2.0.0rampup7-4a0fff9-buster-berkeley
minaprotocol/mina-daemon:2.0.0rampup6-4061884-buster-berkeley
minaprotocol/mina-daemon:2.0.0rampup5-55b7818-buster-berkeley
these work on same chain and can connect to rampup8 node, but they need to restart first
to properly sync, and something weird happens with number of nodes they jump between 50 and 150

minaprotocol/mina-daemon:2.0.0rampup4-14047c5-buster-berkeley
Images above ran on chain id `332c8cc05ba8de9efc23a011f57015d8c9ec96fac81d5d3f7a06969faf4bce92` which is testworld 2.0, 
this one runs on berkeley with chain id `3c41383994b87449625df91769dff7b507825c064287d30fada9286f3f1cb15e`.
Also this node synced up in 3 minutes while images above in 10-20 minutes.

minaprotocol/mina-daemon:2.0.0rampup3-bfd1009-buster-berkeley
Images starts with chain id `667b328bfc09ced12191d099f234575b006b6b193f5441a6fa744feacd9744db`. 
Says max height is 1, connects to 4-5 peers.
```