// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


contract final_task{
enum check_state{creation,contributions,completion,refund_claims}
event creation(address user,string user_name, string user_discription);
    event contributions(address user,uint amount);
//     event completion();
    event refund_claims(address user, uint amount);

    event ab(string);
event st(string);
bytes private i;
 
uint public goal ;
uint public starttime = block.timestamp ;
uint public endtime = starttime + 5 minutes ;
// uint time = 1 minutes;
//bool public active = true;

    address public  owner;
    uint public counter;
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
    
    struct funding{ 
     string name;
     string  discription;
     address user;
    //   uint256 goal;
      check_state state;
    bool active;

    }
    mapping(address=>funding[]) private data;

    function adduser(  string memory _name,
     string memory  _discription,
     address _user, check_state _state,bool _active) private {
      
      data[_user].push(
       funding(
           
                 _name,
                 _discription,
                 _user,
                 _state,
                   _active
       )


      );


     } 

  function creations(string memory _name,
     string memory _discription, address _user) public {
 
adduser(_name, _discription,_user, check_state.creation,true);
emit creation(msg.sender,_name,_discription);


}

function contribute(address payable  sender,string memory _discription,string memory _name,  uint amount,address _newowner) public payable onlyowner  returns(address,uint) {
    // creations(_name, _discription, _goal);
    adduser(_name, _discription, _newowner, check_state.contributions, true);
 
    transferOwnership(_newowner);
    sender.transfer(amount);
    emit contributions(msg.sender,amount);
    return(msg.sender,amount);
    
}

function claim() public  payable onlyowner  returns(address,uint) {
     if(address(this).balance >= goal ){
        // require(address(this).balance== goal);
        payable(owner).transfer(address(this).balance);
    }
     else {
       
    revert("funds are not sufficient for claiming");
     }
     return(msg.sender,msg.value);
  
     
}

function refund()public payable returns(address,uint) {
    if(address(this).balance < goal){
       
        payable (msg.sender).transfer(address(this).balance);

    }
    emit refund_claims(msg.sender, msg.value);
    return(msg.sender,msg.value);
}



   








}