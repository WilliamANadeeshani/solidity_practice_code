// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract BadAuction {
    address highestBidder;
    uint highestBid;

    function bid() public payable{
        require(msg.value >= highestBid);
        if(highestBidder != address(0)) {
            payable(highestBidder).transfer(highestBid);
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}

contract PullOverPush {
    mapping(address => uint) accountBalance;

    function addBalance() public payable {
        accountBalance[msg.sender] += msg.value;
    }

    function withDraw() public {
        uint amount = accountBalance[msg.sender];
        require(amount >=0);
        require(address(this).balance >= amount);
        accountBalance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
