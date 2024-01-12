// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract CrowdSale{

    address public owner;
    uint public allowedtime = 1 minutes;

    constructor()  {
        owner = msg.sender;
    }

    modifier abc(){

        // require( block.timestamp <= allowedtime,"timing end");
        _;
    }

    function transfer(address payable   to, uint amount) public payable  abc{
     if(msg.value< 5 ether  ){
        revert("minimum contribution: 5 ether");
     }
     else if(msg.value> 20 ether ){
       
       revert("maximum contribution 20 ether");
       
     }
    //  to.transfer(amount);
    // to.send(amount);
    (bool success,) = to.call{value:amount}("");
    require(success);
    
    }

    
    function balanceOf() external view returns(uint) {
        return address(this).balance;
    }  

}