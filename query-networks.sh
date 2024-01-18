#!/bin/bash

queryNode(){
  RESPONSE=$(curl $1 \
    -H 'content-type: application/json' \
    --data-raw '{"query":"query MyQuery { version syncStatus daemonStatus { chainId highestBlockLengthReceived } } ","variables":null,"operationName":"MyQuery"}' \
    --compressed -s)

  GIT_VERSION=$(echo $RESPONSE | jq '.data.version')
  CHAIN_ID=$(echo $RESPONSE | jq '.data.daemonStatus.chainId')
  BLOCKCHAIN_LENGTH=$(echo $RESPONSE | jq '.data.daemonStatus.highestBlockLengthReceived')

  echo $2
  echo "Network id: $CHAIN_ID"
  echo "Blockchain length: $BLOCKCHAIN_LENGTH"
  echo "Node version: $GIT_VERSION"
  echo 
}



queryNode 'https://mina-mainnet-graphql.aurowallet.com/graphql' Mainnet
queryNode 'https://mina-devnet-graphql.aurowallet.com/graphql' Devnet
queryNode 'https://mina-berkeley-graphql.aurowallet.com/graphql' Berkeley
queryNode 'https://mina-testworld2-graphql.aurowallet.com/graphql' 'Test World 2'