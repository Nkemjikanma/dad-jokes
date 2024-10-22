// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";
import {DadJokes} from "../src/DadJokes.sol";

// import {HelperConfig} from "../script/HelperConfig.s.sol";

contract DeployDadJokes is Script {
    DadJokes dadJokes;

    function run() external returns (DadJokes) {
        // HelperConfig helperConfig = new HelperConfig();

        vm.startBroadcast();

        dadJokes = new DadJokes();

        vm.stopBroadcast();
        return dadJokes;
    }
}
