// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract Auction {
    address payable owner;

    struct item {
        string item_name;
        uint price;
        address payable highest_bidder;
    }

    item public auctioned_item;

    mapping(address => uint) public accountBalance;

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    function setAuctionedItem(string memory _item, uint price) public onlyOwner{
        auctioned_item = item(_item, price, payable(address(0)));
    }

    function bid() public payable{
        require(bytes(auctioned_item.item_name).length == 0);
        uint bid_amount = msg.value;
        require(bid_amount > auctioned_item.price);
        address previous_bidder = auctioned_item.highest_bidder;
        accountBalance[previous_bidder] = auctioned_item.price;
        auctioned_item.price = bid_amount;
        auctioned_item.price = bid_amount;
        auctioned_item.highest_bidder = payable(msg.sender);
    }

    function withdraw() public {
        uint balance = accountBalance[msg.sender];
        require(balance > 0);
        require(msg.sender != auctioned_item.highest_bidder);

        accountBalance[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }

    function finishAuction() public onlyOwner{
        owner.transfer(auctioned_item.price);
    }
}