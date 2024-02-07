// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract property{
address immutable owner;
constructor(){
    owner = msg.sender;
}
modifier onlyowner(){
    require(msg.sender == owner,"only owner can call this function");
    _;
}

struct PropertyList{

uint price;
string name;
string discription;
bool status;
address owner;


}

PropertyList[] public lists;
mapping(uint=>PropertyList) public list;

function sale(uint _price,
string memory _name,
string memory _discription) public  {
uint id=0;
PropertyList storage li = list[id];
li.name=_name;
li.discription=_discription;
li.price= _price*1e18;
li.status=false;
li.owner=msg.sender;

lists.push(li);

id++;


}

function buyer(uint a) public payable {
    // require(msg.sender>0);

require(msg.sender !=list[a].owner,"owner can't call it");
require(msg.value==list[a].price,"amount is not equal");
payable(list[a].owner).transfer(msg.value);
list[a].status=true;

}

}
