#!/bin/bash

PORT="${1:-3085}"

URL=http://localhost:$PORT/graphql

RESPONSE=$(curl $URL \
  -H 'Content-Type: application/json' \
  --data-raw '{"query":"query Status { version daemonStatus { chainId blockchainLength syncStatus highestBlockLengthReceived } getPeers { host libp2pPort peerId }}", "operationName":"Status"}' \
  --compressed -s)

if [ -z $RESPONSE ]; then
  echo Graphql not running on $URL
  exit 1
fi

STATUS=$(echo $RESPONSE | jq '.data.daemonStatus.syncStatus')
BLOCKCHAIN_LENGTH=$(echo $RESPONSE | jq '.data.daemonStatus.blockchainLength')
PEERS=$(echo $RESPONSE | jq '.data.getPeers | length')
GIT_VERSION=$(echo $RESPONSE | jq '.data.version')
CHAIN_ID=$(echo $RESPONSE | jq '.data.daemonStatus.chainId')
HIGHEST_BLOCK_RECEIVED=$(echo $RESPONSE | jq '.data.daemonStatus.highestBlockLengthReceived')

echo "Status: $STATUS"
echo "Blockchain length: $BLOCKCHAIN_LENGTH"
echo "Highest block received: $HIGHEST_BLOCK_RECEIVED"
echo "Peers: ${PEERS}"
echo "Node version: $GIT_VERSION"
echo "Chain id: $CHAIN_ID"