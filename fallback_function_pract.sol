// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;


contract test{


uint256 public fallbackcoun;
address public owner;

constructor (){

    owner = msg.sender;

}

function onlyowner() public view{

    require(msg.sender==owner, "only snd the owner");
}

fallback() external payable{
    
fallbackcoun++;

}


function getter() public view  returns(uint){

    return fallbackcoun;
}

receive() external payable { }


}