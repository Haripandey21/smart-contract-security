// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public manager;
    address payable[] public participants;

    constructor() {
        manager = msg.sender;
    }

    receive() external payable {
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }

    function checkbalance() public view returns (uint) {
        require(msg.sender == manager);
        return address(this).balance;
    }

    function random() public view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        participants.length
                    )
                )
            );
    }

    function getwinner() public {
        require(
            msg.sender == manager,
            "!!you can't call this function to decide a winner !!!!"
        );
        require(participants.length >= 3);
        address payable winner;
        uint r = random();
        uint index = r % participants.length;
        winner = participants[index];
        winner.transfer(checkbalance());
    }
}
