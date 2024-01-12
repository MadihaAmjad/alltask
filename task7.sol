// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract HashContract {
    bytes32 private messageHash;

    function hash(string memory _message) public {
        messageHash = keccak256(bytes(_message));
         
    }

    function getMessageHash() public view returns (bytes32) {
        return messageHash;
    }

    
}


