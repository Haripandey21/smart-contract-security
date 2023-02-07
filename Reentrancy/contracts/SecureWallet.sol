//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Wallet is ReentrancyGuard {
    mapping(address => uint256) public balanceOf;

    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
       payable(msg.sender).transfer(balanceOf[msg.sender]);
        balanceOf[msg.sender] = 0;
    }
    function checkBalance() external view returns(uint256){
        return balanceOf[msg.sender];
    }
} 