// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {SimpleStorage} from "CyfrinCourse/L1/SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public storageContracts;

    function createStorage() public {
        SimpleStorage storageContract = new SimpleStorage();
        storageContracts.push(storageContract);
    }

    function storeFN(uint storageIndex, int favouriteNumber) public {
        storageContracts[storageIndex].store(favouriteNumber);
    }

    function retrieveFN(uint storageIndex) public view returns (int) {
        return storageContracts[storageIndex].retrieve();
    }
}