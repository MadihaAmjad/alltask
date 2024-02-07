// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract TokPractice is ERC20{
address owner;
      constructor() ERC20("Mynewtoken","MN"){
       owner = msg.sender;

      }

    function mintfifty() public{

        _mint(msg.sender, 90 *10**18);
    }


} 



