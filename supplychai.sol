// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChainTracker {
    enum SupplyChainState { Created, InTransit, Delivered, Completed }

    struct SupplyChainStep {
        SupplyChainState state;
        address actor;
        uint256 timestamp;
    }

    mapping(address => SupplyChainStep[]) private supplyChain;

    event ItemCreated(address indexed item, uint256 timestamp);
    event ItemInTransit(address indexed item, uint256 timestamp);
    event ItemDelivered(address indexed item, uint256 timestamp);
    event SupplyChainCompleted(address indexed item, uint256 timestamp);

        address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "SupplyChainTracker: caller is not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "SupplyChainTracker: new owner is the zero address");
        owner = newOwner;
    }
    function createItem(address item) external onlyOwner {
        _addItemStep(item, SupplyChainState.Created);
        emit ItemCreated(item, block.timestamp);
    }

    function markInTransit(address item) external onlyOwner {
        _addItemStep(item, SupplyChainState.InTransit);
        emit ItemInTransit(item, block.timestamp);
    }

    function markDelivered(address item) external onlyOwner {
        _addItemStep(item, SupplyChainState.Delivered);
        emit ItemDelivered(item, block.timestamp);
    }

    function completeSupplyChain(address item) external onlyOwner {
        _addItemStep(item, SupplyChainState.Completed);
        emit SupplyChainCompleted(item, block.timestamp);
    }
    function getItemSteps(address item) external view returns (SupplyChainStep[] memory) {
        return supplyChain[item];
    }
    function _addItemStep(address item, SupplyChainState state) private {
        supplyChain[item].push(SupplyChainStep({
            state: state,
            actor: msg.sender,
            timestamp: block.timestamp
        }));
    }
}



