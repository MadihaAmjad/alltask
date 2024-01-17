// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DAPP{

enum checkstate{active,completed}
event creat(address user,uint id,uint goal);
event contribute(uint id,address user,uint amount);
event complete(address user,uint id);
event refundclaim(address user,uint id);
address public  contract_owner;
uint256 public endtime= block.timestamp + 10 minutes;
uint public goals = 20 ether;

constructor(){
    contract_owner = msg.sender;
}
modifier onlycontractowner(){
require(msg.sender == contract_owner);
_;

}
modifier allowedtime(){
require(block.timestamp <= endtime,"transaction are not allowed in this time");
_;

}

modifier onlycampowner(){
   require(msg.sender == fund[id].campowner,"only campigan owner call this function"); 
    _;
}

struct funding{

string name;
string discription;
address campowner;
uint256 goal;
uint256 raiseamount;
checkstate state;

}
mapping(uint256=>funding) private fund;
uint256 public id;

function add_user(string memory _name,
string memory _discription,
uint256 _goal) internal {
fund[id] = funding({
name : _name,
discription : _discription,
campowner : msg.sender,
goal :_goal,
raiseamount : 0,
state : checkstate.active


});
id++;
}


function creation(string memory _name,
string memory _discription,
uint256 _goal) public {

add_user(_name, _discription, _goal);
emit creat(msg.sender, id, _goal);
}

function contribution(uint256 user_id) external payable  allowedtime {

fund[user_id].raiseamount += msg.value;
fund[id].state=checkstate.active;
emit contribute(user_id, msg.sender, msg.value);


}
// uint256 public goals;

function claim(uint256 user_id) public allowedtime{
if(fund[user_id].raiseamount >= goals){


    uint amount = fund[user_id].raiseamount;
    payable(fund[user_id].campowner).transfer(amount);
    fund[user_id].state = checkstate.completed;
    emit complete(msg.sender, user_id);

}
else{
    revert("amount is not equal to goal");
}
}
modifier refundallowedtime(){
    require(block.timestamp > endtime ,"can't refund cuz deadline not meet");
    _;
}
function refund(uint256 user_id) public  refundallowedtime {
if(fund[user_id].raiseamount < goals){
    
    uint amount = fund[user_id].raiseamount;
    payable(msg.sender).transfer(amount);
    emit refundclaim(msg.sender, user_id);
}
else{

    revert("u can't refund ");
}

}

function getdetails(uint256 uid) external view returns (funding memory) {
  
  return fund[uid]; 



}


}