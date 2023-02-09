// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.16;

contract Lottery 
{
   address public immutable manager;
   address payable[] public participants;

constructor()
{
    manager=msg.sender; 
}
receive() external payable
{
    require(msg.value==1 ether);
    participants.push(payable(msg.sender));
    
}
function checkBalance() public view returns(uint)
{
    require(msg.sender==manager);
    return address(this).balance;
}
function random() internal view returns(uint)
{
    // this can be manipulated , so use ChainLink VRF 
    return uint256(blockhash(10000)) % 10;
}

function getWinner() public
{
    require(msg.sender==manager,"Not a Owner");
    require(participants.length>=3);
    address payable winner;
    winner=participants[random() % participants.length];
    winner.transfer(checkBalance());
} 

}
   