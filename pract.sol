
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;

contract Storage {
  address private owner;
  bytes32 private hash;

  constructor () public {
    owner = msg.sender; // Whoever deploys smart contract becomes the owner
  }

  function set () public {
    require (msg.sender == owner); // Ensure smart contract is called by the owner
    // hash = _hash;
  }

//   function get () public view returns (bytes32) {
//     return hash;
//   }
}