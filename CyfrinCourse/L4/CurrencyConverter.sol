// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library CurrencyConverter {

    AggregatorV3Interface internal constant sepoliaEthUsd = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

    function toUsd_18(uint256 eth_18) internal view returns (uint256) {
        uint256 rate_18 = getRate_18(sepoliaEthUsd);
        return eth_18 * rate_18 / 1e18;
    }

    function getRate_18(AggregatorV3Interface priceAggregator) private view returns (uint256) {
        uint8 decimals = priceAggregator.decimals();
        (, int256 rate ,,,) = sepoliaEthUsd.latestRoundData();
        return uint256(rate) * 10**(18-decimals);
    }

}