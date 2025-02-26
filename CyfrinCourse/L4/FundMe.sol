// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

/*
Transaction fields:
nonce
gas price
gas limit
to
value
data
v, r, s -- for cryptography
*/

import {CurrencyConverter} from "./CurrencyConverter.sol";

contract FundMe {
    using CurrencyConverter for uint256;

    uint256 minimumFundingValueUsd_18 = 1 * 1e18;

    address[] funders;
    mapping(address => uint256) funded;

    address owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.toUsd_18() >= minimumFundingValueUsd_18, "Too small funding, check minimumFundingValueUsd");
        funders.push(msg.sender);
        funded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // transfer
        // cost no more than 2300 gas, reverts on overflow or any failure
        //
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // cost no more than 2300 gas, return boolean = false on failure
        //
        // bool success = payable(msg.sender).send(address(this).balance);
        // require(success, "Send failed")

        // call
        // no limit for gas, return boolean = false on failure
        // preferrable way
        //
        // (bool success, bytes memory data) = payable(msg.sender).call{value: address(this).balance}("" /*bytes sequence*/);
        // require(success, "Call failed")

        for (uint256 i = 0; i < funders.length; i++) {
            funded[funders[i]]=0;
        }
        funders = new address[](0);

        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call failed");
    }

    function setMinimumFundingValueUsd(uint256 value) public {
        minimumFundingValueUsd_18 = value * 1e18;
    }

    function getMinimumFundingValueUsd() public view returns (uint256) {
        return minimumFundingValueUsd_18 / 1e18;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Permission denied: owner required");
        _;
    }

}