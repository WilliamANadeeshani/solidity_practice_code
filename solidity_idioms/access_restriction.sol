// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ownable {
    address owner;
    
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require (msg.sender == owner);
        _;
    }

    function transferOwnerShip(address newOwner) public onlyOwner {
        require(address(0) != newOwner);
        owner = newOwner;
    }

    function reAnnouncedOwnerShip() public onlyOwner{
        owner = address(0);
    }


}