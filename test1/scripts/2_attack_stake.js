const { ethers } = require("hardhat");

async function main() {
  const AttackStakeContract = await ethers.getContractFactory("AttackStake");
  const deployedAttackStakeContract  = await AttackStakeContract.deploy("0x5FbDB2315678afecb367f032d93F642f64180aa3");
  await deployedAttackStakeContract.deployed();
  
  console.log(
    "deployed Contract Address of AttackStake :",deployedAttackStakeContract.address );
}
main()
 .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});

 