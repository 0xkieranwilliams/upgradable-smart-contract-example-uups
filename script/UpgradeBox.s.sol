// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BoxV1} from "src/BoxV1.sol";
import {BoxV2} from "src/BoxV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract UpgradeBox is Script {

  function run (address owner) external returns (address) {
    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

    vm.startBroadcast(owner);
      BoxV2 newBox = new BoxV2(); // implementation (Logic)
    vm.stopBroadcast();

    address proxy = upgradeBox(mostRecentlyDeployed, address(newBox), owner);
    return proxy;
  }

  function upgradeBox(address proxyAddress, address newBox, address owner) public returns (address) {
    vm.startBroadcast(owner);
        BoxV1 proxy = BoxV1(proxyAddress);
        proxy.upgradeToAndCall(address(newBox), "");
    vm.stopBroadcast();
    return address(proxy);
  }

}
