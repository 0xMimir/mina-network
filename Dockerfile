# Commit: bfd1009abdbee78979ff0343cc73a3480e862f58
FROM minaprotocol/mina-daemon:2.0.0rampup3-bfd1009-buster-berkeley

# Commit: 14047c55517cf3587fc9a6ac55c8f7e80a419571 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup4-14047c5-buster-berkeley

# Commit: 55b78189c46e1811b8bdb78864cfa95409aeb96a syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup5-55b7818-buster-berkeley

# Commit: 4061884b18137c1182c7fcfa80f52804008a2509 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup6-4061884-buster-berkeley

# Commit: 4a0fff9a2966d14b7a1c0ec00785cea9096b5341 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup7-4a0fff9-buster-berkeley

# Commit: 56fa1dbcc36aa638c84cdc624adc407075a088a2 syncs
# FROM minaprotocol/mina-daemon:2.0.0rampup8-56fa1db-buster-berkeley

# Commit: 69730d8f7db97861e028e4bf73fa255a2dd45a13 doesn't sync event on any network
# FROM minaprotocol/mina-daemon:1.3.0-release-2.0.0-69730d8-stretch-devnet

# Commit: c980ba87c3417f40a7081225dfe7478c5ee70fd7 syncs
# FROM minaprotocol/mina-daemon:1.4.0-c980ba8-bullseye-devnet

ENV MINA_LIBP2P_PASS=''
ENV MINA_PRIVKEY_PASS=''
ENV LOG_LEVEL=Info
ENV FILE_LOG_LEVEL=Debug

ENV ADDITONAL_ARGS=''

# This is for versions without libp2p-keypair
# ENTRYPOINT mina daemon --insecure-rest-server --open-limited-graphql-port --external-port ${LIBP2P_PORT} --peer-list-url ${SEED_URL} ${ADDITONAL_ARGS}

# This is for version with keyp2p-keypair
# ENTRYPOINT mina daemon --libp2p-keypair /keys/${KEY} --insecure-rest-server --open-limited-graphql-port --external-port ${LIBP2P_PORT} --peer-list-url ${SEED_URL} ${ADDITONAL_ARGS}

# Block producing
ENTRYPOINT mina daemon --libp2p-keypair /keys/${KEY} --insecure-rest-server --open-limited-graphql-port --external-port ${LIBP2P_PORT} --demo-mode ${ADDITONAL_ARGS}