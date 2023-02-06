# Arithmetic Over/Underflow in Solidity 

This repository contains information and examples related to arithmetic over/underflow in the Solidity programming language.

Arithmetic over/underflow occurs when an arithmetic operation results in a value outside the range of the data type being used to store the result. This can lead to unexpected behavior and security vulnerabilities in smart contracts. 

```bash 
Overflow :-when a number exceeds from its maximum range,it will count from zero again.
underflow :- when a number exceeds from its minimum range,it will count from max number i.e from 2**256-1.
```
```bash 
if you see function which is manipulating the timestamp or , 
if you seee any input field for timestamp (in epoch) in etherscan, then you can manipulate the time by making it zero or any time 
```
Solution 
```bash 
Use Safemath from openzeppelin .....
```