// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
enum check_state{transfer,pending,completed}

contract supplychain{

// enum check_state{transfer,pending,completed}

//events file scope hta hai agr isy hum contract ka bahir likhy gy phr b contract ma access kar skhty hai

event trans(address to,address from, uint time, string prd_name);
event received(address to,address from, uint time, string prd_name);
event completed(address to,address from, uint time, string prd_name);

    struct products{
        string name;
        string PDiscrip;
        uint Pprice;
        string date;
        address id; 
        string seller;
        check_state state;
        uint qty;
    }
    products[] public Productrecord; 

    mapping (address=> products[]) private sp;

function additems( address item_id, string memory _name,
        string memory _PDiscrip,
        uint  _Pprice,
        string memory _date, address _id,string memory _seller,check_state state,uint _qty)public{


     sp[item_id].push( 
        // Productrecord.push( 
      products(
    
       _name,
         _PDiscrip,
       _Pprice,
       _date,
       _id,
       _seller,
       state,
       _qty
      )
        
);

}

function getproductsrecords(uint pid) public view returns(products memory){

    return  Productrecord[pid];
}
function PRODUCTSCount() public view returns(uint)
    {
        return Productrecord.length;
    }

function customer(uint amount,address payable  seller ) public payable {

seller.transfer(amount);

}

function confirmation(address payable abc)public payable {
uint ab = address(this).balance;
abc.transfer(ab);

        
}
function transitprod(address item_id,string memory _name,
        string memory _PDiscrip,
        uint  _Pprice,
        string memory _date,address _id,string memory _seller,uint _qty) external {
  
additems(item_id, _name, _PDiscrip, _Pprice, _date, _id, _seller, check_state.transfer,_qty);
_qty--;
// emit trans(item_id,_PDiscrip,_Pprice,_date,_id,_seller);

}
function receivedprod(address item_id,string memory _name,
        string memory _PDiscrip,
        uint  _Pprice,
        string memory _date,address _id,string memory _seller,uint _qty) external{
additems(item_id, _name, _PDiscrip, _Pprice, _date, _id, _seller, check_state.pending,_qty);


}
function completedsuplly(address item_id,string memory _name,
        string memory _PDiscrip,
        uint  _Pprice,
        string memory _date,address _id,string memory _seller,uint _qty) external{

additems(item_id, _name, _PDiscrip, _Pprice, _date, _id, _seller, check_state.completed,_qty);
}
}