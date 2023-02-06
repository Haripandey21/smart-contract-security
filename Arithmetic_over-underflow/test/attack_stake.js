const { expect } = require("chai");
const hre = require("hardhat");

describe("AttackStake contract testing.....", () => {
    beforeEach(async () => {
        [addr1,addr2] = await hre.ethers.getSigners();
         AttackStakeContract = await ethers.getContractFactory("AttackStake");
         deployedAttackStakeContract  = await AttackStakeContract.deploy("0x5FbDB2315678afecb367f032d93F642f64180aa3");
        });

    it("User should transfer his amount before the stake ends...", async () => {
      await  deployedAttackStakeContract.attack(102,addr2.address,100);
    });
});


