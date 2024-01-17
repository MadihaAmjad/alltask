// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract condP{
    event abc(string);
    uint public z;

function sender(address payable a) public  payable {

a.transfer(msg.value);

}

function withdraw(address payable ab) public payable  {

if(msg.value > 50 ether){
emit abc("withdraw successfully");
 ab.transfer(msg.value);
 

}

else{

    emit abc("not withdraw");
}

}

function check_balance() public returns (uint){

z =address(this).balance;
return z;

}


}