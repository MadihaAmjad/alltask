// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CrowdSale{

    address public owner;
    uint public endingTime;
    constructor()  {
        owner = msg.sender;
        endingTime = block.timestamp + 1 minutes;
    }


    modifier abc(){
        require( block.timestamp <= endingTime,"timing end");
        _;
    }

     function show() public view returns(uint){
          
          uint remaining=0;
          remaining = endingTime - block.timestamp;
          return remaining;

     }

    function transfer(address payable   to, uint amount) public payable abc returns(uint) {
     if(msg.value < 5 ether  ){
        revert("minimum contribution: 5 ether");
     }
     else if(msg.value> 20 ether ){
       
       revert("maximum contribution 20 ether");
       
     }
     to.transfer(amount);
     return endingTime;
    
    }

    
    function balanceOf() external view returns(uint) {
        return address(this).balance;
    }

}