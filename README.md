# AAVE deposit exercise

A solidity contract which is interacting with aave protocol

## Setup

#### installation:
```
npm install
```

## Test By Truffle:

##### Clone the mainnet to local network:
```
ganache --fork -i mynetwork
```

##### Run test case:
```
truffle test --network mynetwork
```

##### Migrate to blockchain:
```
truffle migrate --network mynetwork
```

## References
#### doc:
- https://github.com/aave/protocol-v2
- https://docs.aave.com/developers/
- https://docs.aave.com/developers/the-core-protocol/lendingpool

#### testing:
- https://blog.infura.io/fork-ethereum-replay-historical-transactions-with-ganache-7-archive-support/

#### troubleshoot:
- https://ethereum.stackexchange.com/questions/115579/how-to-import-aave-and-uniswap-contracts-from-a-0-8-x-solidity-contract
- https://trufflesuite.com/blog/take-a-dive-into-truffle-5/index.html#compilation-of-abijson-files
