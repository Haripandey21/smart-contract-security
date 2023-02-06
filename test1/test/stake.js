const { expect } = require("chai");
const hre = require("hardhat");

describe("stake contract testing.....", () => {
    beforeEach(async () => {
        [addr1,addr2] = await hre.ethers.getSigners();
        StakeContract = await ethers.getContractFactory("Stake");
        deployedStakeContract  = await StakeContract.deploy();
        await deployedStakeContract.deposit(120);
        });

    it("should revert with error message if user try to withdraw fund before time", async () => {
      await expect (deployedStakeContract.transferFund(addr2.address,100)).to.be.revertedWith("lock time not expired");
    });
});


