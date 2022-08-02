// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract RockPaperScissors {
    address payable owner;
    address payable playerTwo;

    mapping(address => bytes32) comiments;
    mapping(address => bool) isPlaced;
    uint bet;

    mapping(address => uint) revealComiments;
    mapping(address => bool) isRevealed;

    mapping(uint => mapping(uint => uint)) private gameResults;

    modifier onlyPlayer() {
        require(msg.sender == owner || msg.sender == playerTwo);
        _;
    }

    constructor (address _playerTwo) {
        owner = payable(msg.sender);
        playerTwo = payable(_playerTwo);
        gameResults[0][0] = 0;
        gameResults[1][1] = 0;
        gameResults[2][2] = 0;
        gameResults[0][1] = 2;
        gameResults[1][2] = 2;
        gameResults[2][0] = 2;
        gameResults[0][2] = 1;
        gameResults[1][0] = 1;
        gameResults[2][1] = 1;
    }

    function commit(bytes32 _hashedCode) public payable onlyPlayer{
        require(!isPlaced[msg.sender]);
        if(!isPlaced[owner] && !isPlaced[playerTwo]) {
            bet = msg.value;
        }
        isPlaced[msg.sender] = true;
        comiments[msg.sender] = _hashedCode;
    }

    function reveal(uint _choice, int _nonce) public onlyPlayer {
        require(isPlaced[owner]);
        require(isPlaced[playerTwo]);
        
        _choice = _choice % 3;
        bytes32 claimHash = keccak256(abi.encodePacked(_choice, _nonce));

        require(claimHash == comiments[msg.sender]);
        isRevealed[msg.sender] = true;
        revealComiments[msg.sender] =_choice;
    }

    function distributWinnings() public onlyPlayer{
        require(isRevealed[owner] && isRevealed[playerTwo]);
        uint result = gameResults[revealComiments[owner]][revealComiments[playerTwo]];

        if(result == 0) {
            owner.transfer(bet);
            playerTwo.transfer(bet);
        }else if(result == 1) {
            owner.transfer(2*bet);
        }else {
            playerTwo.transfer(2*bet);
        }

        isPlaced[owner] = false;
        isPlaced[playerTwo] = false;
        bet = 0;
        isRevealed[owner] = false;
        isRevealed[playerTwo] = false;
    }
}
