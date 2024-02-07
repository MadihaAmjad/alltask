// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20("MyToken", "MTK") {

	constructor(){
		_mint(msg.sender, 10000000000000 * 1e18);
	}

}