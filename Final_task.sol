// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract final_task{
    enum check_camp{active,not_active}
    event creation();
    event contributions();
    event completion();
    event refund_claims();
    // enum camp_name{a,b,c}
    event abc(string);
uint public allowedtime= 1 minutes;

address public owner;
 uint256 public _goal=20 ether;


constructor(){
    owner = msg.sender;
}

modifier newowner() {
    require(msg.sender==owner );
_;



}

struct fund{
    string name;
    //  uint256 goal;
     string  discription;
    //  uint256 goal;
     uint amount;
     address campowner;
     address payable sender_amount;
     check_camp state;
    //  camp_name cn;
     
}

fund[] public funds;
function addnewuser(string memory _name,
     
     string memory  _discription,
     uint _amount,
     address _campowner,address payable _sender_amount,
     check_camp _state) public{
          
          funds.push(
            fund(
              _name,
           _discription,
              _amount,
              _campowner,
              _sender_amount,
              _state

            )
          );


     }

receive() external payable {


emit abc("amount received successfully");

 }
function contributor(address payable  from,uint256 amount)public payable{
// from.transfer(amount);

(bool success,) = from.call{value:amount}("");
require(success);

}
function check_totalbalance()public payable {
address(this).balance;
}

function transfer(string memory _name,
    
     string memory  _discription,
     uint _amount,
     address payable  _campowner, address payable _sender_amount
     ) public payable newowner {
        // uint new_owner;
        // require(check_camp.not_active,"fundraising is not allowed");
addnewuser(_name,_discription,_amount,_campowner,_sender_amount,check_camp.active);
require(_campowner!=address(0));
owner = _campowner;

if(_amount == _goal){
    
   uint  a;
   a=address(this).balance;
//    _campowner.transfer(a);
//      return totalamount;
     (bool success,)= _campowner.call{value:a}("");
     require(success);
     
}
else if(_amount != _goal){
     uint currentamount= address(this).balance;
     currentamount += msg.value;
}
// _campowner.transfer(_amount);
     }

function transfers(string memory _name,
    
     string memory  _discription,
     uint _amount,
     address payable  _campowner,address payable _sender_amount
     ) public payable {
        // uint new_owner;
        // require(check_camp.not_active,"fundraising is not allowed");
addnewuser(_name,_discription,_amount,_campowner,_sender_amount,check_camp.not_active);

// _campowner.transfer(_amount);
revert("u can't do transaction cuz funding are not active");
     }


}