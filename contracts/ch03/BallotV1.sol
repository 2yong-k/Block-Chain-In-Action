// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract BallotV1 {
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

    enum Phase {Init, Regs, Vote, Done}
    Phase public state = Phase.Init;
}