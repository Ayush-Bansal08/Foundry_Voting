This is a simple and secure on-chain Voting smart contract built using Solidity. It allows participants to:
1. Register themselves as candidates by paying ETH.
2. Allow voters to cast votes for registered candidates.
3. Let the contract owner pick the winning candidate based on votes.
4. Transfer all collected ETH to the winner.

✨ Features
✅ Transparent ETH-based registration for candidates
✅ One-vote-per-address enforcement
✅ Fully on-chain voting and result computation
✅ Prize pool distributed to winner securely
✅ Protected owner-only access to result declaration

✨Security Considerations
✅ onlyOwner modifier ensures only the deployer can pick a winner.
✅ Voter addresses are tracked to prevent duplicate votes.
✅ Reverts are used to enforce proper flow (e.g., voting only for existing candidates).

🚀Real-World Applicability
✅ Can be used in DAOs, online communities, college elections, or board voting systems.
✅ Transparent logs and on-chain proof make it perfect for verifiable public voting.


## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
This is a simple and secure on-chain Voting smart contract built using Solidity. It allows participants to:
1. Register themselves as candidates by paying ETH.
2. Allow voters to cast votes for registered candidates.
3. Let the contract owner pick the winning candidate based on votes.
4. Transfer all collected ETH to the winner.


✨ Features
✅ Transparent ETH-based registration for candidates
✅ One-vote-per-address enforcement
✅ Fully on-chain voting and result computation
✅ Prize pool distributed to winner securely
✅ Protected owner-only access to result declaration

✨Security Considerations
✅onlyOwner modifier ensures only the deployer can pick a winner.
✅Voter addresses are tracked to prevent duplicate votes.
✅Reverts are used to enforce proper flow (e.g., voting only for existing candidates).





