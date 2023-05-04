// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Counter {
    uint256 value;

    function initialize (uint256 x) public {
        value = x;
    }

    function get() view public returns (uint256) {
        return value;
    }

    function increment (uint256 _num) public {
        value = value + _num;
    }

    function decrement (uint256 _num) public {
        value = value - _num;
    }
}