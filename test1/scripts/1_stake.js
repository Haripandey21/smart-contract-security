const { ethers } = require("hardhat");

async function main() {
  const StakeContract = await ethers.getContractFactory("Stake");
  const deployedStakeContract  = await StakeContract.deploy();
  await deployedStakeContract.deployed();
  
  console.log(
    "deployed Contract Address of Stake :",deployedStakeContract.address );
}
main()
 .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});

