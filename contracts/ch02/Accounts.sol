// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract AccoutsDemo {
    address public whoDeposited;
    uint256 public depositAmt;
    uint256 public accountBalance;

    function deposit() public payable {
        whoDeposited = msg.sender;
        depositAmt = msg.value;
        accountBalance = address(this).balance;
    }
}