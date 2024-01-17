// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


contract final_task{
enum check_state{creation,contributions,completion,refund_claims}
check_state state;
event creation(address user,string user_name, string user_discription);
    event contributions(address user,uint amount);
    event completion(address user,uint amount);
    event refund_claims(address user, uint amount);

    event ab(string);
event st(string);
bytes private i;
 
uint public goal=20 ether ;
// uint public starttime = block.timestamp ;
uint public endtime = block.timestamp + 5 minutes ;
// uint time = 1 minutes;
//bool public active = true;
bool public active;

    address public  owner;
    uint public counter;
    constructor(){
        

        owner = msg.sender;
        active=true;
    }
modifier isactive(){
require(active,"state is not active");
_;

}
modifier allowedtime(){
  require(block.timestamp<= endtime,"time end not contribution are allowed");
  _;

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
    //   check_state state;
    // bool active;

    }
    mapping(address=>funding[]) private data;
mapping(address=>uint) public  datas;
    function adduser(  string memory _name,
     string memory  _discription,
     address _user) private {
      
      data[_user].push(
       funding(
           
                 _name,
                 _discription,
                 _user
                  
       )


      );


     } 

  function creations(string memory _name,
     string memory _discription, address _user) public isactive  {
 
adduser(_name, _discription,_user);
state = check_state.creation;
emit creation(msg.sender,_name,_discription);


}

function contribute(address payable id,address payable  sender,  uint amount) public payable onlyowner isactive allowedtime returns(funding[] memory) {
    // userExists(msg.sender);
    // transferOwnership(_newowner);
    sender.transfer(amount);
    //   state.contributions;
    state= check_state.contributions;
    //   datas[msg.sender] -= amount;
    //     datas[id] += amount;
    emit contributions(msg.sender,amount);
    return   getUserDetails(sender);
   
    
}

function claim() public  payable onlyowner  returns(funding[] memory) {

   

     if(address(this).balance >= goal  ){
      
        payable(owner).transfer(address(this).balance);
        deactivate();
          state= check_state.completion;
        emit completion(msg.sender, address(this).balance);
      return  getUserDetails(msg.sender);
        
    }
   
     else {
       
    revert("funds are not sufficient for claiming");
     }
  
  
     
}
function deactivate() public{
    active = false;
}

function refund()public payable  {
    //  require(userExists(msg.sender));
    //  userExists(user);
    //  revert("user not found");
    //  require(userExists(user),"usere");
    if(address(this).balance < goal || block.timestamp >= endtime){
    // //     // getUserDetails(msg.sender);
    // //     // userExists(msg.sender);
    // //     // userExists(msg.sender);
    // //  userExists(user);
       
       payable (msg.sender).transfer(address(this).balance);
    //     //  userExists(msg.sender);
    //     // return "user not found"
    }
    // userExists(user);
    //  return "user not found";
    //  revert("user not found");
    state = check_state.refund_claims;
    emit refund_claims(msg.sender, msg.value);
    // return(msg.sender,msg.value);



    
}


 function getUserDetails(address _userAddress) public view returns (funding[] memory) {
        return data[_userAddress];
       
   

}

 function userExists(address _userAddress) public  view returns (string memory) {
        uint256 userCount = data[_userAddress].length;
        for (uint256 j = 0; j < userCount; j++) {
            if (data[_userAddress][j].user == _userAddress) {

// string memory abc = "user are registered";
// return abc;
            return  "user are registered";

                //return true; // User with the given address exists
                // revert("user are registered");
            }
        }
        // return false; // User with the given address does not exist
        // revert("User with the given address does not exist");
        return "user are not registered";
    }
}