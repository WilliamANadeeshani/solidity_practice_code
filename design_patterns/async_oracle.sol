// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Client{
    address public oracle;
    uint public a;

    constructor(address oracle_address){
        oracle = oracle_address;
    }

    modifier onlyOracle {
        require(msg.sender == oracle);
        _;
    }

    function getOracleData() public{
        Oracle oracleContract = Oracle(oracle);

    }

    function _oracleCallback(uint _a) public {
        a = _a;
    }
}

contract Oracle {
    address public owner;

    modifier onlyOwner {
        require(msg.sender == owner);
    }

    event OracleInvoked(address sender);

    function invokeOracle() public {
        emit OracleInvoked(msg.sender);
    }

    function callBack(uint _a, address _client) public onlyOwner{
        Client client = Client(_client);
        client._oracleCallback(_a);
    }
}