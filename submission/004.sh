#!/usr/bin/env bash

# The extended public key
xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# Use a placeholder fingerprint (00000000) and specify the derivation path
descriptor="tr([00000000/0]$xpub/100)"

# First get the descriptor with checksum
descriptor_with_checksum=$(bitcoin-cli getdescriptorinfo "$descriptor" | jq -r '.descriptor')

# Use bitcoin-cli's deriveaddresses to get the taproot address and format the output
address=$(bitcoin-cli deriveaddresses "$descriptor_with_checksum" | jq -r '.[0]')

# Print the address
echo "$address"
