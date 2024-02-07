// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Staking is ERC20("Staking", "MT") {
    //  struct stakers{
    //     address owner;
    //  }
    struct staking {
        uint256 token;
        address[] token_Sender;
        mapping(address => uint256) stake_amount;
        mapping(address => uint256) mint_token;
      // address token_Sender;
        
    }
    mapping(address => staking) public stakers;

    // mapping(address=>uint) public stake;

    // function creat(uint256 _token) public {
    //     staking storage stak = stakers[msg.sender];
    //     _token = 0;
    //     stak.token_Sender.push(msg.sender);
    // }

    function Minting(address user, uint256 no_token) public {
        staking storage stak = stakers[msg.sender];
        stak.mint_token[msg.sender] = no_token;
        // _token = 0;
        stak.token_Sender.push(msg.sender);
        require(
            stakers[user].stake_amount[msg.sender] == 0,
            "u cant mint at this time"
        );
       
        _mint(user, no_token);
     
      
    }

    function stakes(uint256 value) public {
        require(value > 0);

        stakers[msg.sender].stake_amount[msg.sender] += value;
        transfer(address(this), value);
    }

    function unstake() public {
        require(
            stakers[msg.sender].stake_amount[msg.sender] > 0,
            "contribute first"
        );

    //uint value = stakers[msg.sender].stake_amount[msg.sender];
  
        //    stakers[msg.sender].stake_amount[msg.sender] += value;
        // transferFrom(address(this), msg.sender, value);
        // stakers[user].stake_amount[user] += value;
        //  stakers[user].stake_amount[user] -= value;
        //  stakers[user].stake_amount[user]=0;

            transfer(msg.sender, stakers[msg.sender].stake_amount[msg.sender]);
            // stakers[msg.sender].stake_amount[msg.sender]-=value;

    }

    function check() public view  returns (uint){
      return  stakers[msg.sender].stake_amount[msg.sender];
    }
}
