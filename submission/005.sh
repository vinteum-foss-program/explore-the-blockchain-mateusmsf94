#!/bin/bash

# Transaction ID
txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

# Get the raw transaction
raw_tx=$(bitcoin-cli getrawtransaction $txid)

# Decode the raw transaction
decoded_tx=$(bitcoin-cli decoderawtransaction $raw_tx)

# Extract public keys from the decoded transaction
# Extract the second element of each txinwitness array, which contains the public key
pubkeys=$(echo $decoded_tx | jq -r '.vin[].txinwitness[1]')


# Convert the public keys into a JSON array format
pubkeys_json=$(echo "$pubkeys" | jq -R -s -c 'split("\n")[:-1]')

# Create a 1-of-4 multisig address
multisig_info=$(bitcoin-cli createmultisig 1 "$pubkeys_json")

# Extract the P2SH address from the output
p2sh_address=$(echo $multisig_info | jq -r '.address')

# Just output the P2SH address
echo "$p2sh_address"