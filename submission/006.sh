#!/bin/bash

# Which tx in block 257,343 spends the coinbase output of block 256,128?

# Get the block hash for block 256128
block_hash=$(bitcoin-cli getblockhash 256128)

# Get the block details and extract the coinbase transaction ID
coinbase_txid=$(bitcoin-cli getblock $block_hash | jq -r '.tx[0]')

# Check block 257343 for the spending transaction
block_hash_257343=$(bitcoin-cli getblockhash 257343)
block_257343=$(bitcoin-cli getblock $block_hash_257343)
txs_257343=$(echo $block_257343 | jq -r '.tx[]')

for txid in $txs_257343; do
    tx=$(bitcoin-cli getrawtransaction $txid true)
    inputs=$(echo $tx | jq -r '.vin[].txid')

    for input_txid in $inputs; do
        if [ "$input_txid" == "$coinbase_txid" ]; then
            echo  $txid 
            exit 0
        fi
    done
done