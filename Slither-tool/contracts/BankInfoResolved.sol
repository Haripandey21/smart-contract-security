// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract BankInfo {
    struct BankAccount {
        uint256 bankName;
        string branch;
        uint256 balance;
        bool exists;
    }

    struct UserData {
        uint256 accNumber;
        uint256 bankName;
        string branch;
        uint256 balance;
    }

    struct BankData {
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

    mapping(address => mapping(uint256 => BankAccount))
        public mappedBankAccount;

    /*----------------------------------modidiers---------------------------------------------*/
    modifier accountAlreadyExist(address _address,uint256 _acNumber) {
        require(
            !mappedBankAccount[_address][_acNumber].exists,
            "Account already exists"
        );
        _;
    }

    // -Events----------------------------------------------*/
    event EventAccountCreation(address accountAddress, uint256 accountNumber);

    event EventBalanceDeposit(
        address accountAddress,
        uint256 accountNumber,
        uint256 depositedBalance
    );

    event EventBalanceTransfer(
        uint256 accountFrom,
        uint256 accountTo,
        uint256 transferedBalance
    );

    event EventBalanceWithdraw(
        address accountAddress,
        uint256 accountNumber,
        uint256 withdrawlBalance
    );

    event EventAdminChange(address newAdmin);
    /*----------------------------------------functions -------------------------------------------------*/
    function setInfo(
        uint256 _accountNumber,
        uint256 _bank,
        string memory _branch,
        uint256 _balance
    ) public accountAlreadyExist(msg.sender,_accountNumber) {
        mappedBankAccount[msg.sender][_accountNumber] = BankAccount(
            _bank,
            _branch,
            _balance,
            true
        );
        accounts.push(_accountNumber);
        addresses.push(msg.sender);
        emit EventAccountCreation(msg.sender, _accountNumber);
    }

    function deposit(uint256 _accountNumber, uint256 _depositBalance) public {
        mappedBankAccount[msg.sender][_accountNumber]
            .balance += _depositBalance;
        emit EventBalanceDeposit(msg.sender, _accountNumber, _depositBalance);
    }

    function withDraw(uint256 _accountNumber, uint256 _withDrawBalance) public {
        mappedBankAccount[msg.sender][_accountNumber]
            .balance -= _withDrawBalance;
        emit EventBalanceWithdraw(msg.sender, _accountNumber, _withDrawBalance);
    }

    function getDataOfUser() public view returns (UserData[] memory) {
        UserData[] memory mUserData = new UserData[](accounts.length); //new array

        for (uint256 i = 0; i < accounts.length; i++) {
            if (mappedBankAccount[msg.sender][accounts[i]].exists) {
                UserData memory newUserData = UserData(
                    accounts[i],
                    mappedBankAccount[msg.sender][accounts[i]].bankName,
                    mappedBankAccount[msg.sender][accounts[i]].branch,
                    mappedBankAccount[msg.sender][accounts[i]].balance
                ); // new struct to store data
                mUserData[i] = newUserData;
            }
        }
        return mUserData;
    }

    function getDataOfBank(uint256 _name)
        public
        view
        returns (BankData[] memory)
    {
        uint256 count;
        BankData[] memory mBankData = new BankData[](accounts.length); // new array to store struct

        for (uint256 i = 0; i < addresses.length; i++) {
            for (uint256 j = 0; j < accounts.length; j++) {
                if (
                    mappedBankAccount[addresses[i]][accounts[j]].bankName ==
                    _name
                ) {
                    // new struct to store data
                    BankData memory newBankData = BankData(
                        accounts[j],
                        mappedBankAccount[addresses[i]][accounts[j]].branch,
                        mappedBankAccount[addresses[i]][accounts[j]].balance
                    );
                    mBankData[i] = newBankData;
                    count++;
                }
            }
        }
        return mBankData;
    }

    function tranferAmount(
        uint256 _fromAccountNo,
        uint256 _transferBalance,
        address _toAddress,
        uint256 _toAccountNo
    ) public {
        require(
            mappedBankAccount[msg.sender][_fromAccountNo].balance >=
                _transferBalance,
            "insufficient balance"
        );
        mappedBankAccount[_toAddress][_toAccountNo].balance += _transferBalance;
        mappedBankAccount[msg.sender][_fromAccountNo]
            .balance -= _transferBalance;
        emit EventBalanceTransfer(
            _fromAccountNo,
            _toAccountNo,
            _transferBalance
        );
    }

    function getBalance(uint256 _acno) public view returns (uint256) {
        return mappedBankAccount[msg.sender][_acno].balance;
    }

    function transferOwner(address _newAdminAddr) public {
        if(_newAdminAddr!=address(0))
        {
        require(
            msg.sender == owner,
            "You are not owner of this Account"
        );
        owner = _newAdminAddr;
        emit EventAdminChange(_newAdminAddr);
    }
    }
} 