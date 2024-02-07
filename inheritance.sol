// Base contract
contract Animal {
    string internal sound;

    constructor(string memory _sound) {
        sound = _sound;
    }

    // Virtual function
    function makeSound() public view virtual returns (string memory) {
        return sound;
    }
}

// Derived contract
contract Dog is Animal {
    constructor() Animal("Woof") {}

    // Override function in the derived contract
    function makeSound() public view virtual override returns (string memory) {
        return   super.makeSound(); // Calling the base contract's function
    }
}

// Example usage
contract AnimalFarm {
    Dog public myDog;

    constructor() {
        myDog = new Dog();
    }

    function interactWithDog() public view returns (string memory) {
        // Polymorphic call to makeSound
        return myDog.makeSound();
    }
}
