// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.28;

// import {Script} from "forge-std/Script.sol";

// abstract contract CodeConstants {
//     uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
//     uint256 public constant LOCAL_CHAIN_ID = 31337;

//     uint256 public constant BLEH_JOKE = 0.001 ether;
//     uint256 public constant DECENT_JOKE = 0.005 ether;
//     uint256 public constant PREMIUM_JOKE = 0.01 ether;
// }

// contract DeployDadJokes is Script, CodeConstants {
//     error DeployDadJokes__InvalidChainId();

//     struct NetworkConfig {
//         ;
//     }

//     NetworkConfig public activeNetworkConfig;

//     constructor() {
//         if (block.chainid = ETH_SEPOLIA_CHAIN_ID) {
//             activeNetworkConfig = getSepoliaEthConfig();
//         } else if (block.chainid = LOCAL_CHAIN_ID) {
//             activeNetworkConfig = getOrCreateAnvilEthConfig();
//         } else {
//             revert DeployDadJokes__InvalidChainId();
//         }
//     }

//     function getSepoliaEthConfig() internal pure returns (NetworkConfig memory) {
//         // Return Sepolia-specific config if needed
//         return NetworkConfig({
//             // Add Sepolia-specific parameters here if needed
//         });
//     }

//     function getLocalConfig() internal pure returns (NetworkConfig memory) {
//             // Return local network config if needed
//             return NetworkConfig({
//                 // Add local network-specific parameters here if needed
//             });
//         }

//         function run() external returns (DadJokes) {
//             vm.startBroadcast();

//             DadJokes dadJokes = new DadJokes();

//             vm.stopBroadcast();
//             return dadJokes;
//         }
//         }
// }
