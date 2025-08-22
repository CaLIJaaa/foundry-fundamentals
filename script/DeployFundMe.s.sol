// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        vm.startBroadcast();

        address ethUsdPriceFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
        FundMe fundMe = new FundMe(ethUsdPriceFeed);

        vm.stopBroadcast();

        return (fundMe);
    }
}
