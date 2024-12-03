#!/bin/bash
# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

raw_tx=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163)

decoded_tx=$(bitcoin-cli decoderawtransaction $raw_tx)

# Extract the public key from the txinwitness field of input 0
# The public key is typically the second-to-last element in the txinwitness array
public_key_script=$(echo $decoded_tx | jq -r '.vin[0].txinwitness[-1]')

# Extract the public key from the script
# Assuming the public key starts with '02', '03', or '04' and is 33 or 65 bytes long
public_key=$(echo $public_key_script | grep -oE '02[0-9a-f]{64}|03[0-9a-f]{64}|04[0-9a-f]{128}' | head -n 1)

echo $public_key