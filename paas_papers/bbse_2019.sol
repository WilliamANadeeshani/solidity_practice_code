// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.15;

contract Lottery {
    address owner;
    uint pot;
    address[] players;
    address winner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
        winner = address(0);
        pot = uint(0);
    }

    function payIn() public payable {
        require(msg.value > 1 ether);
        players.push(msg.sender);
        pot += uint(msg.value);
    }

    function selestWinner() public onlyOwner {
        require(winner == address(0), "No winners yet");
        uint random_number = uint(blockhash(block.number - 1));
        winner = players[random_number % players.length];
    }

    function withDraw() public{
        require(msg.sender == winner);
        uint value = pot;
        pot = 0;
        winner = address(0);
        delete players;
        payable(msg.sender).transfer(value);
    }
}