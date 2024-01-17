// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
enum check_state{transfer,received,completed}

contract supplychain{

// enum check_state{transfer,pending,completed}

//enum file scope hta hai agr isy hum contract ka bahir likhyb gy phr b contract ma access kar skhty hai

event trans(address to,address from, uint time, string prd_name);
event received(address to,address from, uint time, string prd_name);
event completed(address to,address from, uint time, string prd_name);

    struct products{
        string name;
        uint Pprice;
         address id; 
        check_state state;
        uint qty;
    }
    // products[] public Productrecord; 

    mapping (address=> products[]) private sp;

function additems( address item_id, string memory _name,
        uint  _Pprice,
         address _id,check_state state,uint _qty)public{


     sp[item_id].push( 
    //    Productrecord.push( 
      products(
    
       _name,
       _Pprice,
       _id,
       state,
       _qty
      )
        
);

}

// function getproductsrecords(address pid) public view returns(products memory){

//     return  Productrecord[pid];
// }
// function PRODUCTSCount() public view returns(uint)
//     {
//         return Productrecord.length;
//     }

// function customer(uint amount,address payable  seller ) public payable {


// seller.transfer(amount);

// }

// function confirmation(address payable abc)public payable {
// uint ab = address(this).balance;
// abc.transfer(ab);

        
// }
function transitprod(address item_id,string memory _name,
        uint  _Pprice,
        address _id,uint _qty) external {
          
  
additems(item_id, _name, _Pprice, _id, check_state.transfer,_qty);

_qty--;
// emit trans(item_id,_PDiscrip,_Pprice,_date,_id,_seller);

}
function receivedprod(address item_id,string memory _name,
        uint  _Pprice,address _id,uint _qty,address payable seller,uint amount) external payable {
additems(item_id, _name, _Pprice, _id, check_state.received,_qty);
seller.transfer(amount);


}
function completedsuplly(address item_id,string memory _name,
        uint  _Pprice,
        address _id,uint _qty,address payable abc) external payable {

additems(item_id, _name, _Pprice, _id, check_state.completed,_qty);
uint ab = address(this).balance;
abc.transfer(ab);

}
} 

