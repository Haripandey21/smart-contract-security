# Slither 
Slither is a security analysis tool for smart contracts written in Solidity.
To run Slither in your Solidity project, you will need to have the following: 
- install python in your system 
- install Slither : `pip install slither-analyzer`
- run Slither : `slither .`

--------------------------------------------------------------------------.
All contracts included in this audit are from various GitHub users' repositories.

------------------------------------------------------------------------------

# Findings in Lottery.sol
```bash 
gas : 525858 gas 
transaction cost : 457267 gas 
execution cost : 376559 gas 
* Pragma version>=0.7.0<0.9.0 is too complex
* Lottery.manager should be immutable  
* Critical one : 
 Lottery.getwinner() (contracts/Lottery.sol#29-39) uses a weak PRNG: "index = r % participants.length " 
 Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#weak-PRNG


```
# Resolved by ( in LotteryResolved.sol )
```bash 
gas : 441889 gas 
transaction cost : 384251 gas 
execution cost	: 308227 gas 
* pragma solidity ^0.8.16 
* address public immutable manager; 
* Suggested Method : use Chainlink VRF to generate random number.
* Used internal function

```
---------------------------------------------------------------------------------------
# Findings in BankInfo.sol
```bash 
gas	 : 2209363 gas
transaction cost : 1921197 gas 
execution cost : 1736165 gas 
* bankinfo.getDataOfBank(uint256).count (contracts/BankInfo.sol#131) is a local variable never initialized.

* bankinfo.transferOwner(address)._newAdminaddr (contracts/BankInfo.sol#179) lacks a zero-check on :
                - owner = _newAdminaddr (contracts/BankInfo.sol#184)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation

* bankinfo.getDataOfUser() (contracts/BankInfo.sol#109-124) compares to a boolean constant:
        -mappedbankaccount[msg.sender][accounts[i]].exists == true (contracts/BankInfo.sol#113)

* bankinfo.accountAlreadyExist(uint256) (contracts/BankInfo.sol#40-53) compares to a boolean constant:
        -require(bool,string)(check == false,Account already exists,please Change your Account Number) (contracts/BankInfo.sol#48-51)

*    Contract bankinfo (contracts/BankInfo.sol#4-187) is not in CapWords
*    Struct bankinfo.bankaccount (contracts/BankInfo.sol#5-10) is not in CapWords
*    Struct bankinfo.userdata (contracts/BankInfo.sol#12-17) is not in CapWords
*    Struct bankinfo.bankdata (contracts/BankInfo.sol#19-23) is not in CapWords
*    Event bankinfoeventAccountCreation(address,uint256) (contracts/BankInfo.sol#57)
      is not in CapWords

*    Event bankinfoeventBalanceDeposit(address,uint256,uint256) (contracts/BankInfo.sol#59-63)
      is not in     CapWords

*    Event bankinfoeventBalanceTransfer(uint256,uint256,uint256) (contracts/BankInfo.sol#65-69) 
      is not in CapWords

*    Event bankinfoeventBalanceWithdraw(address,uint256,uint256) (contracts/BankInfo.sol#71-75)
      is not in CapWords

*    Event bankinfoeventAdminChange(address) (contracts/BankInfo.sol#77) is not in CapWords

*   Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._accountNumber (contracts/BankInfo.sol#81)
     is not  in mixedCase

*     Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._bank (contracts/BankInfo.sol#82)
         is not in mixedCase
         
*    Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._branch (contracts/BankInfo.sol#83) 
        is not in mixedCase
*    Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._balance (contracts/BankInfo.sol#84) 
        is not in mixedCase

*   Parameter bankinfo.deposit(uint256,uint256)._accountNumber (contracts/BankInfo.sol#97) 
        is not in mixedCase

*    Parameter bankinfo.deposit(uint256,uint256)._depositBalance (contracts/BankInfo.sol#97) 
        is not in mixedCase
        
*    Parameter bankinfo.withdraw(uint256,uint256)._accountNumber (contracts/BankInfo.sol#103)
        is not in mixedCase

*    Parameter bankinfo.withdraw(uint256,uint256)._withdrawBalance (contracts/BankInfo.sol#103) 
        is not in mixedCase

*    Parameter bankinfo.getDataOfBank(uint256)._name (contracts/BankInfo.sol#126) 
        is not in mixedCase

*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._fromAccountNo
         (contracts/BankInfo.sol#155) is not in mixedCase

*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._transferBalance
         (contracts/BankInfo.sol#156) is not in mixedCase

*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._toAddress 
        (contracts/BankInfo.sol#157) is not in mixedCase

*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._toAccountNo 
        (contracts/BankInfo.sol#158) is not in mixedCase

*    Parameter bankinfo.getBalance(uint256)._acno (contracts/BankInfo.sol#175) is not in mixedCase

*    Parameter bankinfo.transferOwner(address)._newAdminaddr (contracts/BankInfo.sol#179) 
     is not in mixedCase


```
# Resolved by (in BankInfoResolved.sol)
```bash 
gas	 : 2049619 gas
transaction cost : 1782277 gas 
execution cost : 1607625 gas  
* Written Contract Name, Structs and Events in Capwords.
* checked zero address too :
     if(_newAdminAddr!=address(0)){}

* Removed Loop in modifier whcih was costing much gas fee, so used Bool.

* Removed comparing  to a boolean constant --->> 
    DO this : modifier accountAlreadyExist(address _address,uint256 _acNumber) {
        require(
            !mappedBankAccount[_address][_acNumber].exists,
            "Account already exists"
        );
        _;
    } 
    --------------------------
    INSTEAD OF : mappedBankAccount[_address][_acNumber].exists==false
    ----------------------------
* In this Contract,Functions Arguments are written in `_bankName` format, instead of Standard format 
  like `bankName`.
  
```
---------------------------------------------------------------------------------------
# Findings in ProposalDao.sol
```bash 
gas	: 2011063 gas
transaction cost : 1748750 gas 
execution cost	: 1570038 gas 
* Contract locking ether found:
        Contract Token (contracts/ProposalDao.sol#8-80) has payable functions:
         - Token.mint() (contracts/ProposalDao.sol#37-46)
        But does not have a function to withdraw the ether.

* Token.registerVoter(uint256).i (contracts/ProposalDao.sol#62) is a 
    local variable never initialized. 

* Pragma version>=0.4.22<0.9.0 (contracts/ProposalDao.sol#2) is too complex
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity

* Parameter Token.designate(address)._to (contracts/ProposalDao.sol#49) 
    is not in mixedCase.

* Parameter Token.registerVoter(uint256)._proposalId (contracts/ProposalDao.sol#61)
     is not in mixedCase.

* Parameter Token.getVotes(address)._sender (contracts/ProposalDao.sol#70) 
    is not in mixedCase.

* Parameter Token.verifyVoters(address,uint256)._sender (contracts/ProposalDao.sol#75) 
    is not in mixedCase.

* Parameter Token.verifyVoters(address,uint256)._proposalId (contracts/ProposalDao.
    sol#75) is not in mixedCase.

* Variable Token.max_supply (contracts/ProposalDao.sol#25) is not in mixedCase.

* Token.mint() uses literals with too many digits:
        - val = msg.value.div(1000000000) (contracts/ProposalDao.sol#40)

* Token.max_supply (contracts/ProposalDao.sol#25) should be immutable .

```
# Resolved by (in ProposalDaoResolved.sol)
```bash 
gas : 2005528 gas
transaction cost : 1743937 gas 
execution cost : 1564397 gas 
* Suggestion : Remove the payable attribute or add a withdraw function. 
    else Every Ether sent to that func will be lost.

* initialized uint256 i=0;
* changed the pragma version to stable ^0.8.16
* following the standard Naming Convention,All parameters of functions changed to MixedCase. 
* Changed .div(10000000000) by writing with suffix : .div(10*9)
* declared maxSupply as immutable. 
```
---------------------------------------------------------------------------------------
# Findings in Bounty.sol
```bash
gas : 1536130 gas
transaction cost : 1335765 gas 
execution cost : 1192841 gas 

* Unused local variables :
    uint256 _target = receiverDetails[_receiver].target;
     uint256 balance = donations[_receiver]; 

* Donate.sendEthers(address,uint256)._receiver (contracts/bounty.sol#49)
         lacks a zero-check on :
        - (success) = address(_receiver).call{value: _amount}() (contracts/bounty.sol#54)

* Reentrancy in Donate.Donates(address,uint256) (contracts/bounty.sol#59-65):
        External calls:
        - sendEthers(_receiver,_amount) (contracts/bounty.sol#63)
                - (success) = address(_receiver).call{value: _amount}() (contracts/bounty.sol#54)
        State variables written after the call(s):
        - giverDetails[_receiver][msg.sender] = Giver(msg.sender,_amount) (contracts/bounty.sol#64)

* Donate.addUser(string,uint256) (contracts/bounty.sol#27-33) 
        compares to a boolean constant:
        -require(bool,string)(toCheck != true,error) (contracts/bounty.sol#30)

* Pragma version>=0.4.22<0.9.0 (contracts/bounty.sol#2) is too complex 

* Low level call in Donate.sendEthers(address,uint256) (contracts/bounty.sol#49-56):
        - (success) = address(_receiver).call{value: _amount}() (contracts/bounty.sol#54)

*   Parameter Donate.addUser(string,uint256)._name (contracts/bounty.sol#27) is not in mixedCase
    Parameter Donate.addUser(string,uint256)._target (contracts/bounty.sol#27) is not in mixedCase
    Parameter Donate.incrementAmounts(uint256,address)._amount (contracts/bounty.sol#42) is not in mixedCase
    Parameter Donate.incrementAmounts(uint256,address)._receiver (contracts/bounty.sol#42) is not in mixedCase
    Parameter Donate.sendEthers(address,uint256)._receiver (contracts/bounty.sol#49) is not in mixedCase
    Parameter Donate.sendEthers(address,uint256)._amount (contracts/bounty.sol#49) is not in mixedCase
    Function Donate.Donates(address,uint256) (contracts/bounty.sol#59-65) is not in mixedCase
    Parameter Donate.Donates(address,uint256)._receiver (contracts/bounty.sol#59) is not in mixedCase
    Parameter Donate.Donates(address,uint256)._amount (contracts/bounty.sol#59) is not in mixedCase

```
# Resolved by (in BountyResolved.sol)
```bash 
gas	: 1492158 gas
transaction cost : 1297528 gas 
execution cost: 1157400 gas 

* Removed Unused local Variables
* checked zero address too :
     if(_newAdminAddr!=address(0)){}

* Suggestion : Use ReentracyGuard of OpenZeppelin to be save from Reentrancy Attacks.

* Removed comparing to a boolean constant : 
         require(toCheck, "error");

* pragma changed to ^0.8.16 
* Suggestion : try to avoid low lvl call in solidity 
* following the standard Naming Convention ,All parameters of functions changed to MixedCase. 
* Used Augmented assignment : 
    balance+= amount;

* Changed incrementAmounts() function to internal 
* sendEthers() function can be made internal but there is payable inside it so,leaving as it is . 
    (internal function cannot be payable)
* 
```
---------------------------------------------------------------------------------------
# Findings in 
```bash 
```
# Resolved by ()
```bash 
```





