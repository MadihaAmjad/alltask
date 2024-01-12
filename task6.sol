// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract access{


address public owner;
uint public limittime = 1 minutes;

constructor(){

owner = msg.sender;

limittime = block.timestamp + 1 minutes ;

}

modifier timeperiod(){

require(block.timestamp >= limittime,"time limit exceed");
_;

}

function Trans(address payable to,uint amount) public payable {

    require(msg.sender == owner);
    to.transfer(amount);
}

function renewowner(address newowner) public timeperiod   {


        //  if(block.timestamp <= limittime){

            require(newowner != address(0),"it;s not owner");
           
              owner = newowner;
            //    require(block.timestamp <= limittime);
            //    newowner = owner;
            // revert();
    //      }
    //    else if(block.timestamp > limittime){
        // newowner = owner;
    // }
    
   
   
}


function totalamount() public view returns(uint){

   return  address(this).balance;
}

modifier onlynewowner(){
require( msg.sender == owner);

_;

}
function onlynewownerwithdraw() public   onlynewowner returns(bool) {
    uint abc = address(this).balance/2;
    

 (bool success,)=owner.call{value:abc}("");
   require(success,"Transfer failed!");
   return success;

}


function previousowner() public onlynewowner  returns(bool) {
    
    

 (bool success,)=owner.call{value:address(this).balance}("");
   require(success,"Transfer failed!");
   return success;

}

}