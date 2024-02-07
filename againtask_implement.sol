// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract dapp {
    enum checkstate {
        active,
        complete
    }

    address public contract_owner;
    constructor(){
        contract_owner = msg.sender;
    }
     

     modifier contractowner(){
    require(msg.sender ==  contract_owner, "call by only contract owner");
    _;
     }



    struct campagin {
        uint256 id;
        string name;
        string discription;
        address campowner;
        uint256 goal;
        uint256 raisedamount;
        uint256 starttime;
        uint256 endtime;
        checkstate state;
    }
    mapping(uint256 => campagin) private camp;

    function creation(
        uint256 _id,
        string memory _name,
        string memory _discription,
        uint256 _goal,
        uint256 _endtime
    ) public {
        camp[_id] = campagin({
            id: _id,
            name : _name,
            discription : _discription,
            campowner : msg.sender,
            goal : _goal,
            raisedamount : 0,
            starttime : block.timestamp,
            endtime  : _endtime,
          state : checkstate.active


        });

        _id++;
    }

    function contribution(uint camp_id) public  payable {
          camp[camp_id].raisedamount += msg.value;

        camp[camp_id].state = checkstate.active;

    }

    function refund(uint camp_id) public{ 
        if(camp[camp_id].raisedamount < camp[camp_id].goal){

            payable(msg.sender).transfer(camp[camp_id].raisedamount);
           
        }
        else{

            emit show("can't refund");
        }                
    }
    event show(string);

    function completebycowner(uint camp_id) public contractowner  {

        if(camp[camp_id].raisedamount>= camp[camp_id].goal ){
            uint amount = camp[camp_id].raisedamount;
              payable(camp[camp_id].campowner).transfer(amount);
            camp[camp_id].state = checkstate.complete;

   
        }
        // revert("amount not equal to goal");
    

              revert ("amount is nit equal to goal");
     
    }


    function getdetail(uint camp_id) public view  returns (campagin memory){
            return camp[camp_id];
               
    }
}
