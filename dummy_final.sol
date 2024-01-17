// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract final_task{
// enum check_state{active}
enum check_state{creation,contributions,completion,refund_claims}
event creation(address user,string user_name, string user_discription);
    event contributions(address user,uint amount);
//     event completion();
    event refund_claims(address user, uint amount);
event ab(string);
event st(string);
bytes private i;
 
uint public goal = 20 ether;
uint public starttime;
uint public endtime;
// uint time = 1 minutes;
bool active = true;

    address public  owner;
    uint public counter;
    
    struct funding{ 
     string name;
     string  discription;
     address user;
    //   uint256 goal;
      check_state state;

    }
    constructor(){
        owner = msg.sender;
    }

    modifier onlyowner(){
      require(msg.sender== owner,"only owner can use this function");
       _;

    }

    function transferOwnership(address newowner) internal onlyowner {
        require(newowner != address(0));
        owner = newowner;
    }

    funding[] public funds;

    function adduser(string memory _name,
     string memory _discription, address _user,check_state _state)private{
      funds.push(

    funding(
       _name,
        _discription,
        _user,
        _state


    )
      );

      }
      receive() external payable { 

        emit st("amount received successfully");
      }

function creations(string memory _name,
     string memory _discription, address _user) public {
 
adduser(_name, _discription,_user, check_state.active);
emit creation(msg.sender,_name,_discription);


}

function contribute(address payable  sender,  uint amount,address _newowner) public payable onlyowner returns(address,uint) {
    // creations(_name, _discription, _goal);
    transferOwnership(_newowner);
    sender.transfer(amount);
    emit contributions(msg.sender,amount);
    return(msg.sender,amount);
    
    // uint a = address(this).balance;
    // if(address(this).balance>= goal){
    //     // require(address(this).balance== goal);
    //     payable(owner).transfer(address(this).balance);
    //     emit ab("amount received successfully");
    // }
    //   return address(this).balance;
    // creations(adduser(_name, _discription, _user, _state));
 
//   claim();
}

function claim() public  payable returns(address,uint) {
     if(address(this).balance >= goal ){
        // require(address(this).balance== goal);
        payable(owner).transfer(address(this).balance);
    }
     else {
       
    revert("funds are not sufficient for claiming");
     }
     return(msg.sender,msg.value);
    // creations(msg.sender,msg.value,name,discripton);
     
}

function refund()public payable returns(address,uint) {
    if(address(this).balance < goal){
        // require(address(this).balance== goal);
        // payable(owner).transfer(address(this).balance);
        payable (msg.sender).transfer(address(this).balance);

    }
    emit refund_claims(msg.sender, msg.value);
    return(msg.sender,msg.value);
}

// function check_total_user() internal view {

// for(i=0; i<=funds.length;i++){
// require(msg.sender==funds[i]);
// }
// counter++;

// }

function getUsers() public view returns (funding[] memory) {
  funding[] memory userArray = new funding[](funds.length);

  for (uint i = 0; i < funds.length; i++) {
    userArray[i] = funds[i];
  }

  return userArray;
}



}