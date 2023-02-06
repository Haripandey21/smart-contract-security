# Reentrancy Attack in Solidity 

Reentrancy attacks occur when an attacker is able to repeatedly call a vulnerable contract's functions before the contract has finished executing a previous call. This can lead to unexpected behavior and security vulnerabilities in smart contracts. 

```bash 

Reentrancy = Re + enter 
- calling  a function while the function is still executing.
```
# Solution 
```bash 
- use ReentrancyGuard from the openzeppelin...
```
