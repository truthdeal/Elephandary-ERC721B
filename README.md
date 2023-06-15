# Elephandary Smart Contract

This repository contains the Elephandary smart contract which is an ERC721B-based contract. This contract is specifically designed for the management of a collection of non-fungible tokens (NFTs) in the Elephandary collection.

## Contract Variables

- `maxSupply`: This variable signifies the maximum total supply of tokens that can be minted from this contract. Once the `maxSupply` is reached, no more tokens can be minted.
- `wlReservedSupply`: This variable determines the number of tokens that are set aside or "reserved" for whitelisted addresses.
- `maxFreeMint`: This variable controls the maximum number of tokens that can be minted for free from the contract. 
- `teamReservedSupply`: This variable represents the number of tokens that are set aside or "reserved" specifically for the team behind the Elephandary project.
- `mintPrice`: This variable stores the price of minting a new token in Ether.
- `maxMintPerWallet`: This variable determines the maximum number of tokens that any single wallet can mint from this contract.
- `maxMintPerTx`: This variable sets a limit on the maximum number of tokens that can be minted in a single transaction.
- `teamMinted`: This variable keeps track of the total number of tokens that the team has minted.
- `wlMinted`: This variable maintains a count of the total number of tokens minted by whitelisted addresses.
- `saleStatus`: This boolean variable represents the current status of the token sale. If `saleStatus` is true, the sale is active. If `saleStatus` is false, the sale is inactive.
- `root`: This variable stores the Merkle root which is used for verifying if an address is part of the whitelist.
- `baseTokenUrl`: This variable holds the base URL for the token metadata which is stored on the InterPlanetary File System (IPFS).
- `tokenUrlExtension`: This variable stores the extension of the token metadata URL, which is typically ".json".
- `_numberMinted`: This is a mapping from addresses to the number of tokens they have minted.
- `KITTEN1`, `KITTEN2`, `KITTEN3`, `KITTEN4`: These constants represent addresses to which the proceeds from minting are distributed.

## Key Functions

### Minting Functions

- `freeMint()`: This function allows a wallet to mint a token for free, subject to the conditions that the sale is active, the wallet has not minted a free token before, and the total supply of free mint tokens has not been reached.
- `publicMint(uint256 amount_)`: This function allows a wallet to mint a specified number of tokens in exchange for ETH, subject to certain conditions including sale status, maximum supply, and minting limits.
- `teamMint()`: This function allows the contract owner to mint tokens to the team's wallets, subject to the condition that the reserved supply for the team has not been exhausted.
- `wlMint(address to , bytes32[] memory proof)`: This function allows a whitelisted address to mint a token, subject to certain conditions including valid Merkle proof, sale status, whitelist reserved supply, and maximum supply.

### Owner Functions

- `reduceSupply(uint256 _maxSupply)`: This function allows the contract owner to reduce the maximum supply of tokens. Note that the new maximum supply cannot exceed the current maximum supply.
- `withdraw()`: This function allows the contract owner to withdraw the balance of ETH held by the contract. The withdrawn balance is distributed equally among the four specified addresses.
- Various `set` functions: These functions allow the contract owner to change the values of contract variables including mint price, whitelist reserved supply, maximum mint per wallet, maximum mint per transaction, sale status, base token URL, token URL extension, and the Merkle root.

### View Functions

- `_baseURI()`: This function returns the base URL for the token metadata.
- `_suffix()`: This function returns the extension for the token metadata URL.
- `tokenURI(uint256 tokenId)`: This function returns the full URL for the metadata of a specific token.
- `isValid(bytes32[] memory proof, bytes32 leaf )`: This function verifies if a Merkle proof is valid for a given leaf node and the stored Merkle root.

## Modifiers

- `mintRequirements (uint256 _amount)`: This modifier imposes conditions on the minting functions to ensure that the total supply, minting limits, and payment requirements are respected.
- `onlyAccount()`: This modifier restricts certain functions to be called only by externally owned accounts (EOAs) and not by other contracts.

## Author

This smart contract was written by Baris Arya CANTEPE.
