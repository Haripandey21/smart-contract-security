// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0; 

contract Donate{
    struct Giver{
      address donator;
      uint256 amountDonated;
    }
    struct Receiver{
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
  
    function addUser(string memory _name, uint256 _target) public  {
      bool toCheck =  receiverDetails[msg.sender].isAdded;
      require(_target != 0, "funding is invalid ");
      require(toCheck != true, "error");
      receiverDetails[msg.sender] = Receiver(_name, msg.sender, _target, true);
      receivers.push();
    }

    //delete user
    function deleteUser() public {
      delete receiverDetails[msg.sender];
      donations[msg.sender] = 0;
    }

    //increment amount
    function incrementAmounts(uint256 _amount, address _receiver) public returns(uint256){
      uint256 balance = donations[_receiver];
      balance = balance + _amount;
      donations[_receiver] = balance;
      return balance;
    }

    function sendEthers(address _receiver, uint256 _amount) public payable{
      //donate ether
       _amount = msg.value;
       uint256 _target = receiverDetails[_receiver].target;
       uint256 balance = donations[_receiver];
       (bool success,) = payable(_receiver).call{value: _amount}("");
       require(success, "Failed to send money");
    }

    //donate ether to receiver
    function Donates(address _receiver, uint256 _amount) public payable{
      
       require(_receiver != msg.sender, "you can't send to self");
       incrementAmounts(_amount, _receiver);
       sendEthers(_receiver, _amount); 
       giverDetails[_receiver][msg.sender] = Giver(msg.sender, _amount);
    }
}