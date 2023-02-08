// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./Todos.sol";

contract AttackHelper {
    address public owner;
    Todos public todos;

    constructor(Todos _todosAddress) {
        owner = msg.sender;
       todos=Todos(_todosAddress);
    }

    fallback() external payable {
        address(todos).delegatecall(msg.data);
    }
}