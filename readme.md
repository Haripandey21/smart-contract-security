# Smart Contract Security 
A collection of resources, best practices, and tools for improving the security of smart contracts.

Tools i'm using to analyze any vulnerabilities :-
- slither 
- mythril 


# Remember these factors for securing your contract.
- Never never use tx.origin(vulnerable for reentrancy attack) so, prefer msg.sender over tx.origin
-  Avoid such time manipulating things : 
 1. function which is manipulating the timestamp or,
 2. any input field for timestamp (in epoch) in etherscan,
 as you can manipulate the time by making it zero or any time by over/under flowing the time.
 So,if you wanna be safe from it..consider using Safemath from Openzeppelin.
- if there is any function which is sending amount like this : 
   payable(msg.sender).transfer(balanceOf[msg.sender]); 
   such functions are vulnerable to Reentrancy attack, as we can call that function again 
   & again, before the contract has finished executing a previous call.
   So, Use Modifier `nonReentrant` of ReentrancyGuard.sol from Openzeppelin. 
   

# Here are some best practices for writing secure smart contracts:

- Avoid using inline assembly in your code as much as possible, 
   as it can be difficult to understand and audit.
- Use libraries or packages with well-tested code instead of
   writing your own code for common functionality.
- Test your smart contracts thoroughly and extensively, including edge 
   cases and unexpected scenarios.
- Regularly review and update your smart contracts to address any 
  security vulnerabilities that are discovered.


# Checklist
 Here is a checklist for ensuring the security of your smart contracts:

- Verify that all the inputs and outputs of the smart contract are properly validated.
- Verify that the smart contract has sufficient access controls to prevent unauthorized access.
- Verify that the smart contract does not have any infinite loops or reentrancy vulnerabilities.
- Verify that the smart contract does not have any integer overflow or underflow vulnerabilities.
- Verify that the smart contract does not have any vulnerabilities related to time manipulation.