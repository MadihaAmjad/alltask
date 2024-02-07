// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address public owner;
    
    struct Contribution {
        address contributor;
        uint amount;
    }
    
    struct Campaign {
        address owner;
        uint goal;
        uint raisedAmount;
        bool isGoalReached;
        mapping(address => uint) contributions; // contributor address to contribution amount
        Contribution[] contributorsHistory;
    }
    
    mapping(uint => Campaign) public campaigns;
    uint public campaignCount;

    event ContributionMade(address indexed contributor, uint amount);
    event CampaignCreated(address indexed owner, uint goal, uint campaignId);
    event Refund(address indexed contributor, uint amount);

    modifier onlyCampaignOwner(uint campaignId) {
        require(msg.sender == campaigns[campaignId].owner, "Only the campaign owner can call this function");
        _;
    }

    modifier campaignExists(uint campaignId) {
        require(campaignId < campaignCount, "Campaign does not exist");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createCampaign(uint _goal) external {
        campaigns[campaignCount] = Campaign({
            owner: msg.sender,
            goal: _goal,
            raisedAmount: 0,
            isGoalReached: false,
            contributorsHistory: new Contribution[](0)
        });

        emit CampaignCreated(msg.sender, _goal, campaignCount);
        campaignCount++;
    }

    function contribute(uint campaignId) external payable campaignExists(campaignId) {
        Campaign storage campaign = campaigns[campaignId];

        require(!campaign.isGoalReached, "Campaign goal already reached");

        campaign.contributions[msg.sender] += msg.value;
        campaign.raisedAmount += msg.value;
        campaign.contributorsHistory.push(Contribution({
            contributor: msg.sender,
            amount: msg.value
        }));

        emit ContributionMade(msg.sender, msg.value);

        if (campaign.raisedAmount >= campaign.goal) {
            campaign.isGoalReached = true;
        }
    }

    function refund(uint campaignId) external campaignExists(campaignId) {
        Campaign storage campaign = campaigns[campaignId];

        require(campaign.isGoalReached == false, "Goal has been reached, no refunds");

        uint contributionAmount = campaign.contributions[msg.sender];
        require(contributionAmount > 0, "No contribution found for the sender");

        campaign.raisedAmount -= contributionAmount;
        campaign.contributions[msg.sender] = 0;

        // Refund the contributor
        payable(msg.sender).transfer(contributionAmount);

        emit Refund(msg.sender, contributionAmount);
    }

    function getCampaignContributors(uint campaignId) external view campaignExists(campaignId) returns (Contribution[] memory) {
        return campaigns[campaignId].contributorsHistory;
    }
}
