#!/bin/bash

# Get the block height (in this case, 123321)
block_height=123321

# Get the block hash
block_hash=$(bitcoin-cli getblockhash "$block_height")


# Get the full block data with transactions
block_data=$(bitcoin-cli getblock "$block_hash" 2)

# Parse transactions in the block using jq
txs=$(echo "$block_data" | jq -c '.tx[]')

# Check each transaction's outputs
echo "$txs" | while read -r tx; do
  txid=$(echo "$tx" | jq -r '.txid')
  vout_count=$(echo "$tx" | jq -r '.vout | length')

  for ((i=0; i<vout_count; i++)); do
    # Check if the transaction output is unspent
    utxo=$(bitcoin-cli gettxout "$txid" "$i")
    if [ "$utxo" != "null" ]; then
      address=$(echo "$utxo" | jq -r '.scriptPubKey.address')
      if [ -n "$address" ]; then
        echo $address
      fi
    fi
  done
done