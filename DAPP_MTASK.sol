// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DAPP{

enum checkstate{active,completed}
event creat(address user,uint256 id);
event contribute(uint256 id,address user,uint256 amount);
event complete(address user,uint256 id,uint256 amount);
event refundclaim(address user,uint256 id,uint256 amount);
event show(string);
event error(string);

address public  contract_owner;
uint256 public endtime= block.timestamp + 2 minutes;
uint256 constant goal = 20 ether;

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

modifier onlycampowner(uint256 _id){
   require(msg.sender == fund[_id].campowner,"only campigan owner call this function"); 
    _;
}



struct funding{
uint256 id;
string name;
string discription;
address campowner;
uint256 raiseamount;
checkstate state;

}
mapping(uint256=>funding) private fund;


function add_user(uint256 _id,string calldata _name,
string memory _discription) internal {
fund[_id] = funding({
    id: _id,
name : _name,
discription : _discription,

campowner : msg.sender,
raiseamount : 0,
state : checkstate.active


});

}


function creation(uint256 _id,string calldata _name,
string memory _discription) public {

add_user(_id,_name, _discription);
emit creat(msg.sender, _id);
}
// modifier statechecker(){
//     require(fund[id].state==checkstate.active,"sttae is not active");
//     _;
// }
function contribution(uint256 user_id) external payable   allowedtime returns (funding memory res) {

fund[user_id].raiseamount += msg.value;


require(fund[user_id].state==checkstate.active,"sttae is not acrive");

emit contribute(user_id, msg.sender, msg.value);

try this.getdetails(user_id) returns(funding memory _res){

    return (_res);
}

catch {

 emit error("user not found");

}
// // return this.getdetails(user_id);


}

modifier allowedclaim(){
    require(block.timestamp >= endtime,"not allowed claiming cuz allowed time is remaining");
    _;
}

// uint256 public show_remainingamount;

function show_remainingamount(uint256 user_id) public view returns (uint256){

   uint256 a= goal  - fund[user_id].raiseamount;
   return a;

}
function claim(uint256 user_id) public allowedclaim{
if(fund[user_id].raiseamount >=goal){


    uint256 amount = fund[user_id].raiseamount;
    payable(fund[user_id].campowner).transfer(amount);
    fund[user_id].state = checkstate.completed;
    emit complete(msg.sender, user_id,amount);

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
if(fund[user_id].raiseamount < goal){
    
    uint256 amount = fund[user_id].raiseamount;
    
    payable(msg.sender).transfer(amount);
    emit refundclaim(msg.sender, user_id,amount);
}
else{

    revert("u can't refund ");
}

}
receive() external payable { 
    emit show("amount received successfully");
}

function getdetails(uint256 uid) external view returns (funding memory) {
  
  return fund[uid]; 



}

function completebyadmin(uint256 u_id) public onlycontractowner{

if(fund[u_id].raiseamount >= goal){


    uint amount = fund[u_id].raiseamount;
    payable(fund[u_id].campowner).transfer(amount);
    fund[u_id].state = checkstate.completed;
    emit complete(msg.sender, u_id,amount);

}
else{
    revert("amount is not equal to goal");
}


}
function campaignowner(uint256 user_id) external view returns(address) {
address campown = fund[user_id].campowner;
return campown;
}


}

