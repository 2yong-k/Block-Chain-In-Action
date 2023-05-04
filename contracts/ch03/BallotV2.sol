// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract BallotV2 {
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

    constructor (uint256 numProposals) {
        chairperson = msg.sender;
        voters[chairperson].weight = 2;
        for (uint256 prop=0; prop<numProposals; prop++) {
            proposals.push(Proposal(0));
        }
    }

    function changeState(Phase x) public {
        if (msg.sender != chairperson) revert();
        if (x < state) revert();
        state = x;
    }
}