// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test, console } from 'forge-std/Test.sol';
import { FundMe } from '../src/FundMe.sol';
import { DeployFundMe } from '../script/DeployFundMe.s.sol';

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr('user');
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant START_BALANCE = 10 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, START_BALANCE);
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testIsPriceFeedVersionEqAccurace() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughtEth() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        fundMe.fund{ value: SEND_VALUE }();

        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }
}
