const { ethers } = require("hardhat");

async function main() {
  const walletContract = await ethers.getContractFactory("Wallet");
  const deployedWalletContract  = await walletContract.deploy();
  await deployedWalletContract.deployed();
  
  console.log(
    "deployed Contract Address of wallet :",deployedWalletContract.address );
}
main()
 .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});

