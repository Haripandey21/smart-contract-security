// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Stake{

    mapping(address =>uint256) balances;
    mapping (address =>uint256) locktime;

//user will not be able to draw his fund for 15 days...
    function deposit() external payable{
        balances[msg.sender]+=balances[msg.sender];
        locktime[msg.sender]+=locktime[msg.sender] +15 days;
    }
    function increaseLockTime(uint256 _timeinsecond) external {

        locktime[msg.sender]=locktime[msg.sender] + _timeinsecond;
    }

    function withdrawFund() external {
    require(balances[msg.sender]>0,"insufficient funds !!");
    require(block.timestamp >locktime[msg.sender],"lock time not expired");

    uint amount =balances[msg.sender];
    balances[msg.sender]=0;

    (bool sent,) = msg.sender.call{value: amount}("");
    require(sent ,"failed to send ether !!");

    }


}


// 0x5FbDB2315678afecb367f032d93F642f64180aa3 