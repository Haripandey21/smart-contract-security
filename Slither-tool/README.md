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
transaction cost : 	457267 gas 
execution cost :	376559 gas 
* Pragma version>=0.7.0<0.9.0 is too complex
* Lottery.manager should be immutable  
* Critical one : 
 Lottery.getwinner() (contracts/Lottery.sol#29-39) uses a weak PRNG: "index = r % participants.length " 
 Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#weak-PRNG


```
# Resolved by ( in Lottery.sol )
```bash 
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
transaction cost :	1921197 gas 
execution cost :	1736165 gas 
* bankinfo.getDataOfBank(uint256).count (contracts/BankInfo.sol#131) is a local variable never initialized.
* bankinfo.transferOwner(address)._newAdminaddr (contracts/BankInfo.sol#179) lacks a zero-check on :
                - owner = _newAdminaddr (contracts/BankInfo.sol#184)
    Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation

* bankinfo.getDataOfUser() (contracts/BankInfo.sol#109-124) compares to a boolean constant:
        -mappedbankaccount[msg.sender][accounts[i]].exists == true (contracts/BankInfo.sol#113)
* bankinfo.accountAlreadyExist(uint256) (contracts/BankInfo.sol#40-53) compares to a boolean constant:
        -require(bool,string)(check == false,Account already exists,please Change your Account Number) (contracts/BankInfo.sol#48-51)

*   Contract bankinfo (contracts/BankInfo.sol#4-187) is not in CapWords
*    Struct bankinfo.bankaccount (contracts/BankInfo.sol#5-10) is not in CapWords
*    Struct bankinfo.userdata (contracts/BankInfo.sol#12-17) is not in CapWords
*    Struct bankinfo.bankdata (contracts/BankInfo.sol#19-23) is not in CapWords
*    Event bankinfoeventAccountCreation(address,uint256) (contracts/BankInfo.sol#57) is not in CapWords
*    Event bankinfoeventBalanceDeposit(address,uint256,uint256) (contracts/BankInfo.sol#59-63) is not in     CapWords
*    Event bankinfoeventBalanceTransfer(uint256,uint256,uint256) (contracts/BankInfo.sol#65-69) is not in CapWords
*    Event bankinfoeventBalanceWithdraw(address,uint256,uint256) (contracts/BankInfo.sol#71-75) is not in CapWords
*    Event bankinfoeventAdminChange(address) (contracts/BankInfo.sol#77) is not in CapWords

* Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._accountNumber (contracts/BankInfo.sol#81) is     not  in mixedCase
*     Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._bank (contracts/BankInfo.sol#82) is not in mixedCase
*    Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._branch (contracts/BankInfo.sol#83) is not in mixedCase
*    Parameter bankinfo.setInfo(uint256,uint256,string,uint256)._balance (contracts/BankInfo.sol#84) is not in mixedCase
*   Parameter bankinfo.deposit(uint256,uint256)._accountNumber (contracts/BankInfo.sol#97) is not in mixedCase
*    Parameter bankinfo.deposit(uint256,uint256)._depositBalance (contracts/BankInfo.sol#97) is not in mixedCase
*    Parameter bankinfo.withdraw(uint256,uint256)._accountNumber (contracts/BankInfo.sol#103) is not in mixedCase
*    Parameter bankinfo.withdraw(uint256,uint256)._withdrawBalance (contracts/BankInfo.sol#103) is not in mixedCase
*    Parameter bankinfo.getDataOfBank(uint256)._name (contracts/BankInfo.sol#126) is not in mixedCase
*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._fromAccountNo (contracts/BankInfo.sol#155) is not in mixedCase
*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._transferBalance (contracts/BankInfo.sol#156) is not in mixedCase
*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._toAddress (contracts/BankInfo.sol#157) is not in mixedCase
*    Parameter bankinfo.tranferAmount(uint256,uint256,address,uint256)._toAccountNo (contracts/BankInfo.sol#158) is not in mixedCase
*    Parameter bankinfo.getBalance(uint256)._acno (contracts/BankInfo.sol#175) is not in mixedCase
*    Parameter bankinfo.transferOwner(address)._newAdminaddr (contracts/BankInfo.sol#179) is not in mixedCase


```
# Resolved by ()
```bash 
transaction cost : 	1782277 gas 
execution cost :	1607625 gas  
* Written Contract Name, Structs and Events in Capwords.
* checked zero address too :
     if(_newAdminAddr!=address(0)){}
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
# Findings in 
```bash 
```
# Resolved by ()
```bash 
```
---------------------------------------------------------------------------------------
# Findings in 
```bash 
```
# Resolved by ()
```bash 
```
---------------------------------------------------------------------------------------
# Findings in 
```bash 
```
# Resolved by ()
```bash 
```





