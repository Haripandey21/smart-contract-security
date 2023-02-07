const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AttackWallet contract testing.....", () => {
  beforeEach(async () => {
    [attacker,deployer,user] = await ethers.getSigners();

    walletContract = await ethers.getContractFactory("Wallet",deployer);
    deployedWalletContract = await walletContract.deploy();

    await deployedWalletContract.deposit({ value: ethers.utils.parseEther("100") });
    await deployedWalletContract.connect(user).deposit({ value: ethers.utils.parseEther("200") });

    AttackwalletContract = await ethers.getContractFactory("AttackWallet",attacker);
    deployedAttackWalletContract  = await AttackwalletContract.deploy(deployedWalletContract.address);
  });

  it("attack function should fail...", async function () {

    console.log("*** Before ***");
    console.log(`Wallet's balance: ${ethers.utils.formatEther(await ethers.provider.getBalance(deployedWalletContract.address)).toString()}`);
    console.log(`Attacker's balance: ${ethers.utils.formatEther(await ethers.provider.getBalance(attacker.address)).toString()}`);
   
    //  Transaction may revert as contract call can run out of gas 
     await deployedAttackWalletContract.attack({ value: ethers.utils.parseEther("10") });

    console.log("*** After performing Attack ***");
    console.log(`Wallet's balance: ${ethers.utils.formatEther(await ethers.provider.getBalance(deployedWalletContract.address)).toString()}`);

  });
}); 