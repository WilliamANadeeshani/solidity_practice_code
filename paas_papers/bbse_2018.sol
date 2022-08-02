pragma solidity ^0.8.0;

contract bbse_2018 {

    address payable owner;

    struct Employer {
        uint amount;
        bool hasSuccessPayment;
    }

    mapping(address => Employer) public employers;

    constructor (){
        owner = payable(msg.sender);
    }

    function receiveSalary() public payable{
        require(msg.value / 1 ether > 2, "Salary doesn't match fo the basic ");
        (bool success, ) = owner.call{value: msg.value}("");
        require (success, "Transaction failed");
        employers[msg.sender].amount = msg.value;
        employers[msg.sender].hasSuccessPayment = true;
    }

    function hasPaidAccount(address employer) public view returns(bool){
        return employers[employer].hasSuccessPayment;
    }
}
