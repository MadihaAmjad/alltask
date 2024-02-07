// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// import {Token} from "token.sol";
import "tokens_practice/token.sol";

contract Staking{
    //  struct stakers{
    //     address owner;
    //  }
    struct staking {
        bool staked;
        mapping(address => uint256) stake_amount; 
    }
    mapping(address => staking) public stakers;

   Token token;

    // function Minting(address user, uint256 no_token) public {
    //     staking storage stak = stakers[msg.sender];
    //     stak.mint_token[msg.sender] = no_token;
    //     _mint(user, no_token);
     
      
    // }
    constructor(address tk){
          token = Token(tk);
    }

    function stakes(uint256 value) public {
        require(value > 0);
        token.transferFrom(msg.sender,address(this), value);
        stakers[msg.sender].stake_amount[msg.sender] += value;
        stakers[msg.sender].staked = true;
    }

    function unstake() public {
        staking storage stak = stakers[msg.sender];
        require(
            stak.stake_amount[msg.sender] > 0,
            "contribute first"
        );
        uint amount = stak.stake_amount[msg.sender];
        token.transfer(msg.sender , amount);
        stak.stake_amount[msg.sender] - amount;
    }

    function check() public view  returns (uint amount){
      amount = stakers[msg.sender].stake_amount[msg.sender];
    }
}