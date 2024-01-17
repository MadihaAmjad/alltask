// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundraisingCampaign {
    struct Campaign {
        string name;
        string description;
        uint256 goal;
        address owner;
        bool isActive;
        uint256 currentAmount; // Current amount raised
    }

    Campaign[] public campaigns;

    // Event to log the creation of a new campaign
    event CampaignCreated(uint256 indexed campaignIndex, address indexed owner);

    // Modifier to ensure that only the owner of a campaign can perform certain actions
    modifier onlyCampaignOwner(uint256 _campaignIndex) {
        require(msg.sender == campaigns[_campaignIndex].owner, "Not the campaign owner");
        _;
    }

    // Function to create a new fundraising campaign
    function createCampaign(string memory _name, string memory _description, uint256 _goal) external {
        require(_goal > 0, "Goal must be greater than 0");

        Campaign memory newCampaign = Campaign({
            name: _name,
            description: _description,
            goal: _goal,
            owner: msg.sender,
            isActive: true,
            currentAmount: 0
        });

        campaigns.push(newCampaign);

        emit CampaignCreated(campaigns.length - 1, msg.sender);
    }

    // Function to contribute to a campaign
    function contribute(uint256 _campaignIndex) external payable {
        require(_campaignIndex < campaigns.length, "Invalid campaign index");
        require(campaigns[_campaignIndex].isActive, "Campaign is not active");
        require(msg.value > 0, "Contribution amount must be greater than 0");

        campaigns[_campaignIndex].currentAmount += msg.value;

        // Check if the goal is reached
        if (campaigns[_campaignIndex].currentAmount >= campaigns[_campaignIndex].goal) {
            campaigns[_campaignIndex].isActive = false;
        }
    }

    // Function to retrieve campaign details
    function getCampaignDetails(uint256 _campaignIndex)
        external
        view
        returns (
            string memory name,
            string memory description,
            uint256 goal,
            address owner,
            bool isActive,
            uint256 currentAmount
        )
    {
        require(_campaignIndex < campaigns.length, "Invalid campaign index");

        Campaign storage campaign = campaigns[_campaignIndex];
        return (
            campaign.name,
            campaign.description,
            campaign.goal,
            campaign.owner,
            campaign.isActive,
            campaign.currentAmount
        );
    }

    // Function to check if a campaign is active
    function isCampaignActive(uint256 _campaignIndex) external view returns (bool) {
        require(_campaignIndex < campaigns.length, "Invalid campaign index");
        return campaigns[_campaignIndex].isActive;
    }

    // Function to get the total number of campaigns
    function getCampaignCount() external view returns (uint256) {
        return campaigns.length;
    }
}
