# Reentrancy Attack in Solidity 

Reentrancy attacks occur when an attacker is able to repeatedly call a vulnerable contract's functions before the contract has finished executing a previous call. This can lead to unexpected behavior and security vulnerabilities in smart contracts. 

```bash 

Reentrancy = Re + enter 
- calling  a function while the function is still executing.
```
# Solution 
```bash 
1. install openzeppelin : `npm install @openzeppelin/contracts`
2.import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
3. inherit in your contract 
4. add this modifier "nonReentrant" in your function
```
