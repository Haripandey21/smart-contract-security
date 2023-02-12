// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract BankInfo {
    struct bankaccount {
        uint256 bank_name;
        string branch;
        uint256 balance;
        bool exists;
    }

    struct userdata {
        uint256 accNumber;
        uint256 bank_name;
        string branch;
        uint256 balance;
    }

    struct bankdata {
        uint256 accNumber;
        string branch;
        uint256 balance;
    }
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    uint256[] accounts; // array storing account numbers
    address[] addresses; // array storing addresses

    userdata[] public arrayuserdata;
    bankdata[] public arraybankdata;

    mapping(address => mapping(uint256 => bankaccount))
        public mappedbankaccount;

    /*----------------------------------modidiers---------------------------------------------*/
    modifier accountAlreadyExist(uint256 _acNumber) {
        bool check;
        for (uint256 i = 0; i < accounts.length; i++) {
            if (accounts[i] == _acNumber) {
                check = true;
                break;
            }
        }
        require(
            check == false,
            "Account already exists,please Change your Account Number"
        );
        _;
    }

    /*------------------------------Events----------------------------------------------*/

    event eventAccountCreation(address accountAddress, uint256 accountNumber);

    event eventBalanceDeposit(
        address accountAddress,
        uint256 accountNumber,
        uint256 depositedBalance
    );

    event eventBalanceTransfer(
        uint256 accountFrom,
        uint256 accountTo,
        uint256 transferedBalance
    );

    event eventBalanceWithdraw(
        address accountAddress,
        uint256 accountNumber,
        uint256 withdrawlBalance
    );

    event eventAdminChange(address newAdmin);

    /*----------------------------------------functions -------------------------------------------------*/
    function setInfo(
        uint256 _accountNumber,
        uint256 _bank,
        string memory _branch,
        uint256 _balance
    ) public accountAlreadyExist(_accountNumber) {
        mappedbankaccount[msg.sender][_accountNumber] = bankaccount(
            _bank,
            _branch,
            _balance,
            true
        );
        accounts.push(_accountNumber);
        addresses.push(msg.sender);
        emit eventAccountCreation(msg.sender, _accountNumber);
    }

    function deposit(uint256 _accountNumber, uint256 _depositBalance) public {
        mappedbankaccount[msg.sender][_accountNumber]
            .balance += _depositBalance;
        emit eventBalanceDeposit(msg.sender, _accountNumber, _depositBalance);
    }

    function withdraw(uint256 _accountNumber, uint256 _withdrawBalance) public {
        mappedbankaccount[msg.sender][_accountNumber]
            .balance -= _withdrawBalance;
        emit eventBalanceWithdraw(msg.sender, _accountNumber, _withdrawBalance);
    }

    function getDataOfUser() public view returns (userdata[] memory) {
        userdata[] memory muserdata = new userdata[](accounts.length); //new array

        for (uint256 i = 0; i < accounts.length; i++) {
            if (mappedbankaccount[msg.sender][accounts[i]].exists == true) {
                userdata memory newuserdata = userdata(
                    accounts[i],
                    mappedbankaccount[msg.sender][accounts[i]].bank_name,
                    mappedbankaccount[msg.sender][accounts[i]].branch,
                    mappedbankaccount[msg.sender][accounts[i]].balance
                ); // new struct to store data
                muserdata[i] = newuserdata;
            }
        }
        return muserdata;
    }

    function getDataOfBank(
        uint256 _name
    ) public view returns (bankdata[] memory) {
        uint256 count;
        bankdata[] memory mbankdata = new bankdata[](accounts.length); // new array to store struct

        for (uint256 i = 0; i < addresses.length; i++) {
            for (uint256 j = 0; j < accounts.length; j++) {
                if (
                    mappedbankaccount[addresses[i]][accounts[j]].bank_name ==
                    _name
                ) {
                    // new struct to store data
                    bankdata memory newbankdata = bankdata(
                        accounts[j],
                        mappedbankaccount[addresses[i]][accounts[j]].branch,
                        mappedbankaccount[addresses[i]][accounts[j]].balance
                    );
                    mbankdata[i] = newbankdata;
                    count++;
                }
            }
        }
        return mbankdata;
    }

    function tranferAmount(
        uint256 _fromAccountNo,
        uint256 _transferBalance,
        address _toAddress,
        uint256 _toAccountNo
    ) public {
        require(
            mappedbankaccount[msg.sender][_fromAccountNo].balance >=
                _transferBalance,
            "insufficient balance"
        );
        mappedbankaccount[_toAddress][_toAccountNo].balance += _transferBalance;
        mappedbankaccount[msg.sender][_fromAccountNo]
            .balance -= _transferBalance;
        emit eventBalanceTransfer(
            _fromAccountNo,
            _toAccountNo,
            _transferBalance
        );
    }

    function getBalance(uint256 _acno) public view returns (uint256) {
        return mappedbankaccount[msg.sender][_acno].balance;
    }

    function transferOwner(address _newAdminaddr) public {
        require(
            msg.sender == owner,
            "Permission denied as you are not owner of this Account"
        );
        owner = _newAdminaddr;
        emit eventAdminChange(_newAdminaddr);
    }
}
