// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
contract Donate is ReentrancyGuard {
    struct Giver {
        address donator;
        uint256 amountDonated;
    }
    struct Receiver {
        string name;
        address user;
        uint256 target;
        bool isAdded;
    }
    mapping(address => uint256) public donations;
    Receiver public receiver;
    Receiver[] public receivers;
    mapping(address => Receiver) public receiverDetails;
    Giver public giver;
    Giver[] public givers;
    mapping(address => mapping(address => Giver)) public giverDetails;

    function addUser(string memory name, uint256 target) public {
        bool toCheck = receiverDetails[msg.sender].isAdded;
        require(target != 0, "funding is invalid ");
        require(toCheck, "error");
        receiverDetails[msg.sender] = Receiver(name, msg.sender, target, true);
        receivers.push();
    }

    //delete user
    function deleteUser() public {
        delete receiverDetails[msg.sender];
        donations[msg.sender] = 0;
    }

    //increment amount
    function incrementAmounts(
        uint256 amount,
        address receiverAddress
    ) internal returns (uint256) {
        uint256 balance = donations[receiverAddress];
        balance += amount;
        donations[receiverAddress] = balance;
        return balance;
    }

    function sendEthers (
        address receiverAddress,
        uint256 amount
    ) public payable nonReentrant {
        //donate ether
        if (receiverAddress != address(0)) {
            amount = msg.value;
            (bool success, ) = payable(receiverAddress).call{value: amount}("");
            require(success, "Failed to send money");
        }
    }

    //donate ether to receiver
    function donates(address receiverAddress, uint256 amount) public payable {
        require(receiverAddress != msg.sender, "you can't send to self");
        if (receiverAddress != address(0)) {
            incrementAmounts(amount, receiverAddress);
            sendEthers(receiverAddress, amount);
            giverDetails[receiverAddress][msg.sender] = Giver(
                msg.sender,
                amount
            );
        }
    }
}
