const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Wallet contract testing.....", () => {
  beforeEach(async () => {
    [deployer, user] = await ethers.getSigners();
    walletContract = await ethers.getContractFactory("Wallet",deployer);
    deployedWalletContract = await walletContract.deploy();
    await deployedWalletContract.deposit({
      value: ethers.utils.parseEther("10"),
    });
    await deployedWalletContract
      .connect(user)
      .deposit({ value: ethers.utils.parseEther("5") });
  });

  it("Should accept deposits", async function () {
    const deployerBalance = await deployedWalletContract
      .connect(deployer)
      .checkBalance();
    expect(deployerBalance).to.eq(ethers.utils.parseEther("10"));

    const userBalance = await deployedWalletContract
      .connect(user)
      .checkBalance();
    expect(userBalance).to.eq(ethers.utils.parseEther("5"));
  });

  it("Should accept withdrawals", async function () {
    await deployedWalletContract.withdraw();

    const deployerBalance = await deployedWalletContract
      .connect(deployer)
      .checkBalance();
    const userBalance = await deployedWalletContract
      .connect(user)
      .checkBalance();

    expect(deployerBalance).to.eq(0);
    expect(userBalance).to.eq(ethers.utils.parseEther("5"));
  });
});
