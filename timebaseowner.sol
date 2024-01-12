// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLimitedOwnership {
    address public owner;
    address public previousOwner;
    uint256 public changeOwnershipTimestamp;
    uint256 public ownershipRevertTimestamp;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyAfter(uint256 _time) {
        require(block.timestamp >= _time, "Function can only be called after a specific time");
        _;
    }

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event OwnershipReverted(address indexed previousOwner);

    constructor(uint256 _changeOwnershipTimestamp, uint256 _ownershipRevertTimestamp) {
        owner = msg.sender;
        changeOwnershipTimestamp = _changeOwnershipTimestamp;
        ownershipRevertTimestamp = _ownershipRevertTimestamp;
    }

    function transferOwnership(address _newOwner) external onlyOwner onlyAfter(changeOwnershipTimestamp) {
        require(_newOwner != address(0), "New owner address cannot be zero");
        emit OwnershipTransferred(owner, _newOwner);
        previousOwner = owner;
        owner = _newOwner;
    }

    function revertOwnership() external onlyOwner onlyAfter(ownershipRevertTimestamp) {
        require(previousOwner != address(0), "Previous owner not set");
        emit OwnershipReverted(previousOwner);
        owner = previousOwner;
        previousOwner = address(0);
    }
}
