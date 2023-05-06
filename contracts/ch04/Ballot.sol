// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Ballot {
    struct Voter {}
    struct Proposal {}
    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    modifier onlyChair() {
        require(msg.sender == chairperson);
        _;
    }
    modifier validVoter() {
        require(voters[msg.sender].weight>0, "Not a Registered Voter");
        _;
    }

    constructor(uint256 numProposals) public {}
    function register(address voter) public onlyChair {}
    function vote(uint256 toProposal) public validVoter {}
    function reqWinner() public view returns (uint256 winningProposal) {}
}