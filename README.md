# Images:

### `minaprotocol/mina-daemon:2.0.0rampup8-56fa1db-buster-berkeley`

Still syncs.

### `minaprotocol/mina-daemon:2.0.0rampup7-4a0fff9-buster-berkeley`

First time it runs it says it's synced but max height is 1, after it restarts it sync properly


### `minaprotocol/mina-daemon:2.0.0rampup6-4061884-buster-berkeley`

Syncing same as above

Note: Something weird happens with peers on this one, it is jumping between 50 and 150.

### `minaprotocol/mina-daemon:2.0.0rampup5-55b7818-buster-berkeley`

Syncing same as above

### `minaprotocol/mina-daemon:2.0.0rampup4-14047c5-buster-berkeley`

Images above ran on chain id `332c8cc05ba8de9efc23a011f57015d8c9ec96fac81d5d3f7a06969faf4bce92` which is testworld 2.0, this one runs on berkeley with chain id `3c41383994b87449625df91769dff7b507825c064287d30fada9286f3f1cb15e`

Note: this one syncs up much faster 3 minutes, while other ones 10-20 minutes.


### `minaprotocol/mina-daemon:2.0.0rampup3-bfd1009-buster-berkeley`

Images starts with chain id `667b328bfc09ced12191d099f234575b006b6b193f5441a6fa744feacd9744db`. Says max height is 1, connects to 4-5 peers.