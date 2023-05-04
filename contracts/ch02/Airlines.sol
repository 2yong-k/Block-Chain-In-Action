// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Airlines {
    address chairperson;
    // 항공사 데이터 구조
    struct details {
        uint256 escrow; // 지불 정산을 위한 예치
        uint256 status;
        uint256 hashOfDetails;
    }

    // 항공사 주소 페이먼트와 회원 매핑
    mapping (address => details) public balanceDetails;
    mapping (address => uint256) membership;

    // 수정자 또는 규칙들
    modifier onlyChairperson {
        require(msg.sender == chairperson);
        _;
    }
    modifier onlyMember {
        require(membership[msg.sender] == 1);
        _;
    }

    // 생성자 함수
    constructor() payable {
        chairperson = msg.sender;
        membership[msg.sender] = 1;
        balanceDetails[msg.sender].escrow = msg.value;
    }

    function register() public payable {
        address AirlineA = msg.sender;
        membership[AirlineA] = 1;
        balanceDetails[msg.sender].escrow = msg.value;
    }

    function unregister(address payable AirlineZ) onlyChairperson public {
        membership[AirlineZ] = 0;
        AirlineZ.transfer(balanceDetails[AirlineZ].escrow);
        balanceDetails[AirlineZ].escrow = 0;
    }

    function request(address toAirline, uint256 hashOfDetails) onlyMember public {
        if (membership[toAirline] != 1) revert();
        balanceDetails[msg.sender].status = 0;
        balanceDetails[msg.sender].hashOfDetails = hashOfDetails;
    }

    function response(address fromAirline, uint256 hashOfDetails, uint256 done) onlyMember public {
        if (membership[fromAirline] != 1) revert();
        balanceDetails[msg.sender].status = done;
        balanceDetails[fromAirline].hashOfDetails = hashOfDetails;
    }

    function settlePayment(address payable toAirline) onlyMember payable public {
        address fromAirline = msg.sender;
        uint256 amt = msg.value;

        balanceDetails[toAirline].escrow += amt;
        balanceDetails[fromAirline].escrow -= amt;

        toAirline.transfer(amt);
    }
}