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
   
# Gas Optimization 
- Payable functions costs less gas fee than non-payable.
   (as Non-payable function need to revert transaction if anyone sedn ether to it,so that extra
   checking costs more gas fee.)

- uint8 a=9 is more expensive than uint256 a=9.
   (in (256-8)bits it puts zero so,it consumes more gas fee rather than just allocating space like in uint256)
   
- Do apply Variable packings 
    Don't do this : 
                     uint128 a;
                     uint256 b;
                     uint128 c;
    Do this : 
                     uint128 a;
                     uint128 b;
                     uint256 c;

- Utilize `uncheck` if you are confident of avoiding over/underflow.
   like in tokenids,counters,etc 

- keccak256 is cheapest has function. 
- prefer bytes32 over string/bytes. 

- use of global variable constants 
   storage costs : 20000 gas 
   constant(stored in bytecode) costs : 200 gas only /- 

- avoid updating storage variable in every loop.
   Declare local variable,use it & after all computation 
   update state variable to local variable.

- don't initialize variables, if they have default values
    Don't do this : 
                     uint256 counter=0;
                     bool status= false;

- Declare values explicitly if you know it's value.
   Don't use Solidity to derive that data

- Use bool for existence of value,variable,addreesses than running loops in modifiers.

- Avoid repetative check while using safemath 
      No need to do this : require(balance>=amount)
      as balance=balance.sub(amount) also check that required condition.

- use single line swap, (a,b)=(b,a)

- bool is a uint8,its using 8 bits  but it only needs 1 bit 
   (as it only stores either true or false).so wastage of 7 bits.

- struct & array datas always starts with a new slot.
   (not mapping does)

- in Solidity,maximum size of contract is restricted to 24 KB. 

- use of internal calls




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