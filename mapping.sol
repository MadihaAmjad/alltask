// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;

contract map{

    mapping(uint=>address) public ad;

    function add(address balance,uint value) public{
       
      ad[value]= balance;

    }


}

