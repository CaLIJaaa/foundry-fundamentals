// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Script } from 'forge-std/Script.sol';
import { MockV3Aggregator } from '../test/mocks/MockV3Aggregator.sol';

contract HelperConfig is Script {
    struct NetworkConfig {
        address priceFeed;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 42161) {
            activeNetworkConfig = getArbitrumEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getArbitrumEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory arbitrumConfig = NetworkConfig({ priceFeed: 0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612 });
        return arbitrumConfig;
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }

        vm.startBroadcast();
        MockV3Aggregator mokePriceFeed = new MockV3Aggregator(8, 2000e8);
        vm.stopBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig({ priceFeed: address(mokePriceFeed) });
        return anvilConfig;
    }
}
