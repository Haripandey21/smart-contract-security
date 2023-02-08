# Delegate call 

- Here we called AttackTodos.attack()
- .attack() called the fallback function of AttackHelper sending the function.
- selector of setOwner(). AttackHelper forwards the call to Todos using delegatecall.
- Here msg.data contains the function selector of setOwner().
- This tells Solidity to call the function setOwner() inside Todos.
- The function setOwner() updates the owner to msg.sender.
- Delegatecall runs the code of Todos using the context of AttackHelper.

Therefore AttackHelper's storage was updated to msg.sender where msg.sender is the
caller of AttackHelper, in this case it is AttackTodos.

## Brief Info

Delegate calls in Solidity are vulnerable to attack because they allow contract code to be executed in the context of the calling contract, rather than the delegate contract. This means that the storage, memory, and balance of the calling contract can be manipulated by the delegate contract, potentially leading to security issues.

For example, an attacker could create a malicious delegate contract that modifies the storage or state of the calling contract in a way that is not intended by the original developer 
