#!/bin/bash
# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

raw_tx=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163)

decoded_tx=$(bitcoin-cli decoderawtransaction $raw_tx)

# Extract the public key from the txinwitness field of input 0
public_key=$(echo $decoded_tx | jq -r '.vin[0].txinwitness[-1]')

echo $public_key