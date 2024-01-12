// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.4 <0.9.0;



contract practicecode{


function transferEther(address payable recipient) public payable {
        
            recipient.transfer(msg.value);
        }

}