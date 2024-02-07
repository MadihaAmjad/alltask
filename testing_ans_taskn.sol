// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error DFP__ThisCompaignAlreadyExist();
error DFP__ThisCompaignIsEnded();
error DFP__ThisCompaignIsActive();
error DFP__TargetAmountNotReached();
error DFP__OnlyAdministratorCanCallThis();

contract DFP{

    struct Campaign{
        address creator;
        string name;
        string description;
        uint targetAmount;
        uint amountCollected;
        address[] contributor;
        mapping(address => uint) contribution;
        uint deadline;
        bool completed;
    }

    address public administrator;

    mapping(string => Campaign) private campaigns;


    modifier beforeDeadline(string memory name ){
        if(block.timestamp >= campaigns[name].deadline){
            revert DFP__ThisCompaignIsEnded();
        }
        _;
    }
    modifier afterDeadline(string memory name ){
        if(block.timestamp <= campaigns[name].deadline){
            revert DFP__ThisCompaignIsActive();
        }
        _;
    }
    modifier onlyAdmin(){
        if(msg.sender != administrator){
            revert DFP__OnlyAdministratorCanCallThis(); 
        }
        _;
    }

    constructor(){
        administrator = msg.sender;
    }

    function createCampaign(
        string memory _name,
        string memory _description,
        uint _targetAmount,
        uint _deadline
    )   public 
    {
        if(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked(campaigns[_name].name))){
            revert DFP__ThisCompaignAlreadyExist();
        }
        Campaign storage campaign = campaigns[_name];
        campaign.name = _name;
        campaign.description = _description;
        campaign.targetAmount = _targetAmount;
        campaign.deadline = _deadline;
    }

    function fundCampaign(
        string memory _campaignName
    )   public
        payable
        beforeDeadline(_campaignName)
    {
        Campaign storage campaign = campaigns[_campaignName];
        campaign.amountCollected += msg.value;
        campaign.contribution[msg.sender] += msg.value;
        campaign.contributor.push(msg.sender);
    }   

    function refund(
        string memory _campaignName
    )   public 
        afterDeadline(_campaignName)
    {

        require(campaigns[_campaignName].contribution[msg.sender] > 0, "Contribute First");
        uint amount = campaigns[_campaignName].contribution[msg.sender];
        payable(msg.sender).transfer(amount);
    }

    function completeCampaign(
        string memory _campaignName
    )   public 
        afterDeadline(_campaignName)
    {
        if(campaigns[_campaignName].amountCollected >= campaigns[_campaignName].targetAmount){
            revert DFP__TargetAmountNotReached();
        }

        payable(campaigns[_campaignName].creator).transfer(campaigns[_campaignName].amountCollected);

    }

    

}