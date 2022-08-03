// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract SimpeOracle{
    enum Coins{ ETH, BIT }

    address public controller;

    mapping(uint => uint) public prices;

    constructor() {
        controller = msg.sender;
    }

    modifier isController {
        require(controller == msg.sender);
        _;
    }

    function update(uint coin, uint price) public isController{
        if(coin != uint(Coins.ETH) && coin != uint(Coins.BIT)){
            revert();
        }
        prices[coin] = price;
    }

    function getPrice(uint coin) public view returns(uint price) {
        return prices[coin];
    }
}