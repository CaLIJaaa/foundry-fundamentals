// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        address ethUsdPriceFeed = 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612;
        fundMe = new FundMe(ethUsdPriceFeed);
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(), address(this));
    }

    function testIsPriceFeedVersionEqAccurace() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}
