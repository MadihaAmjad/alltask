// Step 1: Define the Campaign contract
contract Campaign {
    address public owner;
    string public name;
    string public description;
    uint public fundraisingGoal;
    uint public deadline;
    uint public totalRaised;
    bool public isActive;
    bool public isCompleted;

    mapping(address => uint) public contributions;

    // Step 2: Constructor to initialize the campaign
    constructor(
        string memory _name,
        string memory _description,
        uint _fundraisingGoal,
        uint _deadline
    ) {
        owner = msg.sender;
        name = _name;
        description = _description;
        fundraisingGoal = _fundraisingGoal;
        deadline = block.timestamp + _deadline; // Set deadline in seconds from now
        isActive = true;
        isCompleted = false;
    }

    // Step 3: Modifier to ensure only the owner can perform certain actions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Step 4: Modifier to ensure the campaign is active
    modifier onlyActiveCampaign() {
        require(isActive, "Campaign is not active");
        _;
    }

    // Step 5: Modifier to ensure the campaign is not completed
    modifier notCompletedCampaign() {
        require(!isCompleted, "Campaign is already completed");
        _;
    }

    // Step 6: Allow contributors to contribute Ether
    function contribute() external payable onlyActiveCampaign notCompletedCampaign {
        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;

        // Check if the fundraising goal is reached
        if (totalRaised >= fundraisingGoal) {
            isCompleted = true;
            isActive = false;

            // Trigger release of funds to the campaign owner
            payable(owner).transfer(address(this).balance);
        }
    }

    // Step 7: Retrieve details of the campaign
    function getCampaignDetails() external view returns (
        address _owner,
        string memory _name,
        string memory _description,
        uint _fundraisingGoal,
        uint _deadline,
        uint _totalRaised,
        bool _isActive,
        bool _isCompleted
    ) {
        return (owner, name, description, fundraisingGoal, deadline, totalRaised, isActive, isCompleted);
    }

    // Step 8: Allow contributors to claim a refund if the deadline is reached and the goal is not met
    function claimRefund() external onlyActiveCampaign {
        require(block.timestamp >= deadline && totalRaised < fundraisingGoal, "Refund not available");
        
        uint amountToRefund = contributions[msg.sender];
        require(amountToRefund > 0, "No funds to refund");

        contributions[msg.sender] = 0;
        totalRaised -= amountToRefund;

        payable(msg.sender).transfer(amountToRefund);
    }
}
