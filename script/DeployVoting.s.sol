// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Voting} from "../src/Voting.sol";

contract DeployVoting is Script {
    Voting voting;

    function run() public returns (Voting) {
        vm.startBroadcast();
        voting = new Voting();
        vm.stopBroadcast();
        return voting;
    }
}
// so our script is ready here
