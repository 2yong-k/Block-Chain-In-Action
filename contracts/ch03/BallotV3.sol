// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract BallotV3 {
    struct Voter {
        uint256 weight;
        bool voted;
        uint256 vote;
    }

    struct Proposal {
        uint256 voteCount;
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    enum Phase {Init, Regs, Vote, Done} // 내부적으로 0, 1, 2, 3으로 코딩
    Phase public state = Phase.Init;

    modifier validPhase(Phase reqPhase) {
        require(state == reqPhase);
        _;
    }

    constructor (uint256 numProposals) {
        chairperson = msg.sender;
        voters[chairperson].weight = 2;
        for (uint256 prop=0; prop<numProposals; prop++) {
            proposals.push(Proposal(0));
        }
        state = Phase.Regs;
    }

    function changeState(Phase x) public {
        if (msg.sender != chairperson) revert();
        if (x < state) revert();
        state = x;
    }

    function register(address voter) public validPhase(Phase.Regs) {
        if (msg.sender != chairperson || voters[voter].voted) revert();
        voters[voter].weight = 1;
        voters[voter].voted = false;
    }

    function vote(uint256 toProposal) public validPhase(Phase.Vote) {
        Voter memory sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) revert();
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
    }

    function reqWinner() public validPhase(Phase.Done) view returns (uint256 winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint256 prop=0; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                winningProposal = prop;
            }
        }
    }
}