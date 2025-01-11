// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV2 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
  uint256 internal number;

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor () {
    _disableInitializers();
  }

  function initializeV2(address owner) public reinitializer(2) {
    __Ownable_init(owner); // sets the owner to msg.sender
    __UUPSUpgradeable_init();
  }

  function getNumber() external view returns (uint256) {
    return number;
  }

  function setNumber(uint256 _number) external {
    number = _number;
  }

  function version() external pure returns (uint256) {
    return 2;
  }

  function _authorizeUpgrade(address newImplementation) internal override { }
}

