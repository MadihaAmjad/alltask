// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract compaign{


// event abc(string);

enum check_state{creation,contributions,completion,refund_claims,active}
check_state state;
event creations(address user,string user_name, string user_discription);
    event contributions(address user,uint amount,uint index);
    event completion(address user,uint amount,uint index);
    event refund_claims(address user, uint amount);


address public owner;
bool public active;
uint256 goal=20 ether;
uint endtime= block.timestamp + 10 minutes;


constructor(){
    owner = msg.sender;
    active = true;
}

modifier onlyowner(){
require(msg.sender == owner,"only owner can use this function");

_;

}
modifier isactive(){
require(active,"state is not active");
_;

}
function deactivate() public{
    active = false;
}

modifier allowedtime(){
  require(block.timestamp<= endtime,"time end not contribution are allowed");
  _;

}

struct funding{

string name;
string discription;
address owner;

uint256 raisedAmount;

}

mapping(uint256=>funding) public fund;
uint256 public index;

function user_add(string memory _name,
string  memory _discription) public {
fund[index] = funding({
name: _name,
discription: _discription,
owner: msg.sender,
raisedAmount: 0

});
index++;

}

function creation(string memory _name,
string  memory _discription) public {

    user_add(_name, _discription);
    state = check_state.creation;
    emit creations(msg.sender, _name, _discription);
}

function contribution(uint id) public payable  {

    fund[id].raisedAmount += msg.value;

    state = check_state.contributions;
   emit contributions(msg.sender, msg.value, id);

 
}

function claim(uint id)public payable onlyowner isactive  {

if(fund[id].raisedAmount>=goal){
uint a = fund[id].raisedAmount;
payable(fund[id].owner).transfer(a);
// deactivate();
state = check_state.completion;


emit completion(fund[id].owner, msg.value,id);


}

deactivate();
// else {
       
//     revert("funds are not sufficient for claiming");
//      }

}

function refund(uint id) public payable {
    if(fund[id].raisedAmount<goal){
      uint a=  fund[id].raisedAmount ;
        payable(msg.sender).transfer(a);
         state = check_state.refund_claims;
    emit refund_claims(msg.sender,msg.value);
    }
    else{
        revert("u can't refund amount");
    }

    // state = check_state.refund_claims;
    // emit refund_claims(msg.sender,msg.value);
}

 function getUserDetails(uint _userAddress) public view returns (funding memory) {
        return fund[_userAddress];
       
   

}



}