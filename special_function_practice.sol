// 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract D {

    //.call()-> recive() or fallback() ka sth work karta hai or operation b perform hta hai e.g. 
    //e.g// totalAmountReceived += msg.value;
    //send() or transfer() recevie ka sth work karty hai but koi operation perform ni hta is ka sth cuz of extra gass consumption 
    //.call(),send(),transfer() fallback() ka sth work kar skhty hai
    //receive or fallback agr contract ma hai tou receive hi call ho ga
    //agr receive function ni hai the fallback() ho ga ya fallback tb call ho 
    //ga jb  specific function signature match na ho ksii sa
   
    uint256 public totalAmountReceived;
     event call(string a);
   
    receive() external payable {
     
        // totalAmountReceived += msg.value;
        emit call("received call");
    // }
    }

    // fallback() external payable { 
    //     emit call("fallback call");

    // }

    
    function getTotalAmount() external view returns (uint256) {
        return totalAmountReceived;
    }
}

contract B{

    D a;

    constructor(address payable con){
        a = D(con);
    }

    function callwithTransfer() public payable{
        payable(address(a)).transfer(msg.value);
    }

    function callwithSend() public payable{
        (bool success) =  payable(address(a)).send(msg.value);
        require(success);
    }
    function callwithLowLevel() public payable{
        (bool success,) =  payable(address(a)).call{value:msg.value}("");

           //didn't match any function signature if i remove comment from it then 
           //fallback function will be called 
        //  (bool success,) =  payable(address(a)).call{value:msg.value}("callanydummy");
        require(success);
    }
}

