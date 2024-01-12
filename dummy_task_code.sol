// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherManager {
    address public owner;

    // Event to log when Ether is received
    event Received(address indexed sender, uint256 value);

    // Event to log when Ether is withdrawn
    event Withdrawal(address indexed receiver, uint256 amount);

    // Constructor: Set the deploying address as the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier: Ensure that only the owner can execute the function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _; // Continue with the function if the modifier check passes
    }

    // This function allows the contract to receive Ether
    receive() external payable {
        emit Received(msg.sender, msg.value);
        // Custom logic for handling the received Ether can be added here
    }

    // Function to check the contract's balance
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // Function to allow the owner to withdraw Ether
    function withdrawEther(uint256 amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");
        
        // Transfer Ether to the owner
        payable(owner).transfer(amount);

        emit Withdrawal(owner, amount);
    }
}
