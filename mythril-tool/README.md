# Mythril
All contracts included in this audit are from various GitHub users' repositories which contains Vulnerabilities.

so, Let's cover what mythril can do.

To run mythril in your Solidity project, you will need to have the following: 
- install python in your system 
- install mythril : `pip3 install mythril`
- run mythril in contract directory : `$ myth analyze <solidity-file>`

---------------------------------------------------------------------------------------
# Findings in BankInfo.sol
```bash 
X X X X X X X X 
No any issues found even in such Vulnerable Contract. 
```
---------------------------------------------------------------------------------------
# Findings in Bounty.sol
```bash 
* Detected Reentrancy can happen here :  payable(_receiver).call{value: _amount}("")
*  State access after external call : 
    giverDetails[_receiver][msg.sender] = Giver(msg.sender, _amount)
------------------------------------------------------------------
not effective like that of slither, no any other issues found here.
------------------------------------------------------------------
```
---------------------------------------------------------------------------------------
# Findings in Lottery.sol
```bash 
No issues were detected.
```
------------------------------------------------------------------------------------------
