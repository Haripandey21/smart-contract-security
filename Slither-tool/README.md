# Slither 
Slither is a security analysis tool for smart contracts written in Solidity.
To run Slither in your Solidity project, you will need to have the following: 
- install python in your system 
- install Slither : `pip install slither-analyzer`
- run Slither : `slither .`

--------------------------------------------------------------------------.
All contracts included in this audit are from various GitHub users' repositories.
----------------------------------------------------------------------------

# Findings in Lottery.sol
```bash 
* Pragma version>=0.7.0<0.9.0 is too complex
* Lottery.manager should be immutable  
* Critical one : 
 Lottery.getwinner() (contracts/Lottery.sol#29-39) uses a weak PRNG: "index = r % participants.length " 
 Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#weak-PRNG

transaction cost : 	457267 gas 
execution cost :	376559 gas 

```
# Resolved by ( in Lottery.sol )
```bash 
* pragma solidity ^0.8.16 
* address public immutable manager; 
* Suggested Method : use Chainlink VRF to generate random number.
* Used internal function

transaction cost : 384251 gas 
execution cost	: 308227 gas 

```

