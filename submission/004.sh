#!/bin/bash

# Extended public key
XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# Index
INDEX=100

# Create the descriptor for the specified index
DESCRIPTOR="tr(${XPUB}/0/${INDEX})"

# Validate the descriptor and get the checksum
DESCRIPTOR_WITH_CHECKSUM=$(bitcoin-cli getdescriptorinfo "$DESCRIPTOR" | jq -r '.descriptor')

# Use the descriptor to derive the address
ADDRESS=$(bitcoin-cli deriveaddresses "$DESCRIPTOR_WITH_CHECKSUM" | jq -r '.[0]')

# Print the resulting Taproot address
echo ${ADDRESS}
