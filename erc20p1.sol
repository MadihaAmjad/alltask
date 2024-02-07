// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract ERC20P1  is ERC20("Mytoken","MT") {

uint amount_of_token;
// address other_contract;
address owner;
constructor(){
    // uint  _amount;
    owner = msg.sender;
    _mint(owner, 50*10**18);

}

// function stakeamounttrans(address other_contract) public {
//     transfer(other_contract,amount_of_token);
// }

mapping(address=>uint)Stakes;

function checkstakers(address staker) public returns(uint){
    
}


}