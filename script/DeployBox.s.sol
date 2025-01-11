// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import {BoxV1} from "../src/BoxV1.sol";

contract DeployBox is Script{
  function run(address owner) external returns (address) {
    address proxy = deployBox(owner);
    return proxy;
  }

  function deployBox(address owner) public returns (address){
    vm.startBroadcast(owner);
        BoxV1 box = new BoxV1(); // implementation (Logic)
        bytes memory initData = abi.encodeWithSignature("initialize(address)", owner);
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), initData);
    vm.stopBroadcast();
    return address(proxy);
  }
}
