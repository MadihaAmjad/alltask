// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    receive() external payable {
        // Allow anyone to transfer ether to the contract
    }

    function withdraw() external onlyOwner {
        // Only the owner can withdraw ether
        payable(owner).transfer(address(this).balance);
    }
}

contract newcontract{


    EtherWallet newtask;

    constructor (address payable con){
        newtask = EtherWallet(con);
    }
    function onlyowner()public{

}

    function trans() payable  public{
        
        payable(address(newtask)).transfer(msg.value);

    }
    function tanscall() payable public{
      
      (bool success,) = payable(address(newtask)).call{value:msg.value}("");
      require(success);
        
    }

}