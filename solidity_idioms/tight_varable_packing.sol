// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract TightVariablePacking {
    struct CheapStruct {
        uint128 a;
        uint128 c;
        uint256 b;
    }

    struct WithoutPacking {
        uint128 a; //16 bytes
        uint256 b;
        uint128 c;
    }
}