// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract tracking  {

//   struct  data  {
//     uint   ownernumber;
//     uint   id;
//   }

//   uint value;
//   mapping (uint256 => data) public  datamatching;

//   function storedata (uint _ownernumber, uint _id) public {
//     var  persondata  = datamatching[value];
//     persondata .ownernumber = _ownernumber;
//     persondata. id  =  _id;
//   }

//   function getData(uint256 userId) returns (uint, uint){
//     return (datamatching[userId].ownernumber, datamatching[userId].id);
//   }
// }

contract StructArrayInitWrong {

  struct Room {
    address[] players;       
  }  
  Room[] rooms;
  address[] adr; // <=== if we're going to store this, then let's store this.

  function createRoom() public {   
                                    // <=== note gaping hole
    adr.push(msg.sender);
    Room memory room = Room(adr);   
    rooms.push(room);
  }

  function getRoomsLength() public view returns (uint) {
    return rooms.length;
  }
}