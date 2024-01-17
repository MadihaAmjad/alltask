// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;

// this made by me
contract ReceiveEtherTracker{

uint256 public totalreceivedether;
event ab(string);

receive() external payable { 

    totalreceivedether += msg.value;
    emit ab("amount received");

}
function abc(address payable  a,uint256 amount) public payable {

(bool success,) = a.call{value:amount}("");
require(success);

}

function gettotalamount() public view returns(uint256){

// uint ab = totalreceivedether;

 return totalreceivedether;


}


}


//it's chat gpt code


// contract ReceiveEtherTracker {
//     uint256 public totalReceived;

//     // Receive function to handle Ether transfers
//     receive() external payable {
//         // Update the totalReceived variable with the amount of Ether sent
//         totalReceived += msg.value;
//     }

//     // Public function to get the total received amount
//     function getTotalReceived() external view returns (uint256) {
//         return totalReceived;
//     }






// contract geteth{

//  ReceiveEtherTracker RET;

//   constructor(){
 
// //  RET = (address).balance(this);


//   }


