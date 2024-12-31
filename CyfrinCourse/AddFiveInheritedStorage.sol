// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {SimpleStorage} from "CyfrinCourse/SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {

    function store(int number) public override {
        favouriteNumber = number + 5;
    }

}