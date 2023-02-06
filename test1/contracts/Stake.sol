// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

contract Stake{

    mapping(address =>uint256) public balances;
    mapping (address =>uint256) public lockTime;

//user will not be able to transfer his fund for 15 days...
    function deposit(uint256 _depositAmount) external payable{
        balances[msg.sender]+=_depositAmount;
        lockTime[msg.sender]=block.timestamp +15 days;
    }
    function increaseLockTime(uint256 _timeinsecond) external {

        lockTime[msg.sender]=lockTime[msg.sender] + _timeinsecond;
    }

    function transferFund(address _to,uint256 _amount) external  {
    require(balances[msg.sender]>_amount,"insufficient funds !!");
    require(block.timestamp >lockTime[msg.sender],"lock time not expired");
    balances[_to]+=_amount;
    balances[msg.sender]-=_amount;
    }

}
