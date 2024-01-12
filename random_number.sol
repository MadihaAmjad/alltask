
// SPDX-License-Identifier: MIT

// pragma solidity ^0.8.0;

// contract badRandomContract  {

//      function badRandom() internal view returns (uint) {
//         uint random_number = uint(blockhash(block.number-1)) % 10 + 1;
//         return random_number;
//     }
// }


 pragma solidity ^0.8.0;

// contract RandomNumberGenerator {
//     uint256 private seed;

//     function generateRandomNumber() external returns (uint256) {
//         seed = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp, seed)));
//         return seed % (10**16); // Return a 16-digit random number
//     }
// }
contract GuessingGame  {

    constructor() payable {}

    // function for generating random number
    function badRandom() internal view returns (uint) {
        uint random_number = uint(blockhash(block.number-1)) % 10 + 1;
        
        return random_number;
        
    }

    // take in user input and return true or false depening on if the guess is right
    function guess(uint _guess) external{
        bool success = _guess ==  badRandom() ? true : false;

        if (success) {
            (bool transaction, ) = msg.sender.call{value: 1 ether}("");
            require(transaction, "Transaction Failed");
        }
    }
}
