// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Animal {
    string internal sound;

    constructor(string memory _sound) {
        sound = _sound;
    }

    function makeSound() public view virtual returns (string memory) {
        return sound;
    }
}

// Derived contract
contract Dog is Animal {
   // string internal sounds;
    constructor() Animal("Woof") {}

    function interact() public view returns (string memory) {
        // Internal call using super
      //   return super.makeSound();
        //internal call without using super
        // return makeSound();
          //internal call using contract name
       return Animal.makeSound();
    }

    function makeSound() public virtual override   view returns(string memory){
      
     

    }
}
