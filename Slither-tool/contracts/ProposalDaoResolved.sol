// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Token is ERC20 {
    using SafeMath for uint256;

    //check if the user enough votes
    mapping(address => uint256) public hasVotes;

    //check if the user can vote
    mapping(uint256 => mapping(address => bool)) public canVote;

    //array of users delegated to vote
    address[] public delegateVoters;

    //fee -- this a constant --
    uint256 public fee;

    //max supply of the token
    uint256 public immutable maxSupply;

    constructor() ERC20("Balloons", "BAL") {
        // **You can update the msg.sender address with your
        // front-end address to mint yourself tokens.
        maxSupply = 100 ether;
    }

    // ToDo: create a payable buyTokens() function:
    function mint() public payable {
        require(totalSupply() < maxSupply);
        require(msg.value > 0);
        uint256 val = msg.value.div(10 ** 9);
        _mint(msg.sender, msg.value.div(10 ** 9));
        if (val >= 100) {
            hasVotes[msg.sender] += val;
        }
    }

    //delegate votes to another user
    function designate(address to) public {
        //check if the user has votes
        require(hasVotes[msg.sender] > 0);
        uint256 bals = hasVotes[msg.sender];
        hasVotes[to] += bals;
        hasVotes[msg.sender] -= bals;
        //delegate votes to another user
        delegateVoters.push(to);
    }

    //register all voters who are eligible to vote
    function registerVoter(uint256 proposalId) public {
        for (uint256 i = 0; i < delegateVoters.length; i++) {
            address owner = delegateVoters[i];
            require(hasVotes[owner] > 0);
            canVote[proposalId][owner] = true;
        }
    }

    //get total available votes for a voter
    function getVotes(address sender) public view returns (uint256) {
        return hasVotes[sender];
    }

    //verify voters who are eligible to vote
    function verifyVoters(
        address sender,
        uint256 proposalId
    ) public view returns (bool) {
        bool checked = canVote[proposalId][sender];
        return checked;
    }
}
