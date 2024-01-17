//// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundraisingPlatform {
    address public admin;
    uint256 public deadlineDuration; // in seconds

    enum CampaignStatus {Active, Completed, Refundable}

    struct Campaign {
        address owner;
        string name;
        string description;
        uint256 goal;
        uint256 raisedAmount;
        uint256 deadline;
        CampaignStatus status;
    }

    mapping(uint256 => Campaign) public campaigns;
    uint256 public nextCampaignId;

    event CampaignCreated(uint256 campaignId, address indexed owner, string name, uint256 goal, uint256 deadline);
    event FundsContributed(uint256 campaignId, address indexed contributor, uint256 amount);
    event CampaignCompleted(uint256 campaignId);
    event RefundClaimed(uint256 campaignId, address indexed contributor, uint256 amount);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the administrator can call this function");
        _;
    }

    modifier onlyCampaignOwner(uint256 _campaignId) {
        require(msg.sender == campaigns[_campaignId].owner, "Only the campaign owner can call this function");
        _;
    }

    modifier whenActive(uint256 _campaignId) {
        require(campaigns[_campaignId].status == CampaignStatus.Active, "Campaign is not active");
        _;
    }

    modifier whenCompleted(uint256 _campaignId) {
        require(campaigns[_campaignId].status == CampaignStatus.Completed, "Campaign is not completed");
        _;
    }

    modifier whenRefundable(uint256 _campaignId) {
        require(campaigns[_campaignId].status == CampaignStatus.Refundable, "Campaign is not refundable");
        _;
    }

    constructor(uint256 _deadlineDuration) {
        admin = msg.sender;
        deadlineDuration = _deadlineDuration;
    }

    function createCampaign(string memory _name, string memory _description, uint256 _goal) external {
        uint256 deadline = block.timestamp + deadlineDuration;

        campaigns[nextCampaignId] = Campaign({
            owner: msg.sender,
            name: _name,
            description: _description,
            goal: _goal,
            raisedAmount: 0,
            deadline: deadline,
            status: CampaignStatus.Active
        });

        emit CampaignCreated(nextCampaignId, msg.sender, _name, _goal, deadline);
        nextCampaignId++;
    }

    function contributeFunds(uint256 _campaignId) external payable whenActive(_campaignId) {
        require(msg.value > 0, "Contribution amount must be greater than 0");

        campaigns[_campaignId].raisedAmount += msg.value;

        emit FundsContributed(_campaignId, msg.sender, msg.value);

        // Check if the campaign reached its goal
        if (campaigns[_campaignId].raisedAmount >= campaigns[_campaignId].goal) {
            campaigns[_campaignId].status = CampaignStatus.Completed;
            emit CampaignCompleted(_campaignId);
        }
    }

    function claimRefund(uint256 _campaignId) external whenRefundable(_campaignId) {
        require(campaigns[_campaignId].raisedAmount < campaigns[_campaignId].goal, "Campaign reached its goal");

        uint256 amountToRefund = campaigns[_campaignId].raisedAmount;
        campaigns[_campaignId].raisedAmount = 0;

        payable(msg.sender).transfer(amountToRefund);

        emit RefundClaimed(_campaignId, msg.sender, amountToRefund);
    }

    function completeCampaign(uint256 _campaignId) external onlyAdmin whenCompleted(_campaignId) {
        require(campaigns[_campaignId].raisedAmount >= campaigns[_campaignId].goal, "Campaign did not reach its goal");

        // Transfer funds to the campaign owner
        uint256 amountToTransfer = campaigns[_campaignId].raisedAmount;
        campaigns[_campaignId].raisedAmount = 0;

        payable(campaigns[_campaignId].owner).transfer(amountToTransfer);
    }
}
