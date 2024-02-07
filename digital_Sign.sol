// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Wallet {
    address[] owner;
    uint256 numConfirmationsRequired;

    constructor(address[] memory _owner, uint256 _numConfirmationsRequired) {
        owner = _owner;
        numConfirmationsRequired = _numConfirmationsRequired;
    }

    modifier onlyowners() {
        bool owners = false;
        for (uint256 i = 0; i < owner.length; i++) {
            if (owner[i] == msg.sender) {
                owners = true;
            }
        }
        require(owners == true, "only owners can call");
        _;
    }

    struct info {
        address payable recipient;
        uint256 value;
        address[] addr;
        uint256 numConfirmations;
        mapping(address => bool) confirmed;
        uint amount;
    }
    // info[] public information;
    // mapping(address =>mapping (bool=>info)) isConfirmed;
    // mapping(uint=>mapping(address=>info)) confirmed;
    mapping(uint256 => info) public information;

    function submitTransaction(address payable _recipient, uint256 _value)
        public
        payable
    {
        // transfer.address(this);
        //   uint index = information.length;
        uint256 index = 0;
        info storage inform = information[index];
        inform.recipient = _recipient;
        inform.value = _value;
        inform.numConfirmations = 0;
        require(msg.value > 0, "value must be greater then 0");
        //  information[index].value += msg.value;
        inform.amount += msg.value;

        inform.addr.push(_recipient);

        index++;

        // payable(address(this))
    }

    // function sender(uint index) public{
    // info storage inform = information[index];
    // information[index].value += msg.value;

    // }
    function confirmTransaction(uint256 index) public payable onlyowners {
        info storage inform = information[index];
        inform.numConfirmations++;
        if (inform.numConfirmations >= numConfirmationsRequired) {
            executeTransaction(index);
        }
    }

    function executeTransaction(uint256 index) public payable {
        //  payable(_to).transfer(msg.value);
        //    require(information[index].contri[msg.sender] > 0, "first contribute");
        info storage inform = information[index];
        inform.confirmed[msg.sender] = true;
        uint256 value = information[index].amount;
        // information[index].contri[msg.sender] = 0;
        payable(information[index].recipient).transfer(value);
        // (bool success,) = information[index].recipient.call{value:value}("");
        // require(success,"transaction execution failed");
    }
}

// ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
