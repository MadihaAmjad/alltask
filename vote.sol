// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Structure to represent a candidate
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // Mapping to store candidates
    mapping(uint256 => Candidate) public candidates;

    // Mapping to store the addresses that have voted
    mapping(address => bool) public hasVoted;

    // Event to log the voting action
    event Voted(uint256 candidateId, address voter);

    // Address of the owner (who can add candidates)
    address public owner;

    // Modifier to ensure that only the owner can add candidates
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Constructor to set the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to add a candidate (only owner can add candidates)
    function addCandidate(uint256 _id, string memory _name) external onlyOwner {
        candidates[_id] = Candidate(_id, _name, 0);
    }

    // Function to cast a vote for a candidate
    function vote(uint256 _candidateId) external {
        require(!hasVoted[msg.sender], "You have already voted");

        // Check if the candidate exists
        require(candidates[_candidateId].id != 0, "Invalid candidate");

        // Update the vote count for the candidate
        candidates[_candidateId].voteCount++;

        // Mark the sender as voted
        hasVoted[msg.sender] = true;

        // Emit the Voted event
        emit Voted(_candidateId, msg.sender);
    }

    // Function to get the total vote count for a candidate
    function getVoteCount(uint256 _candidateId) external view returns (uint256) {
        return candidates[_candidateId].voteCount;
    }
}
