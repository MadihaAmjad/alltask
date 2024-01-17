
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract SupplyChain {
//     // Define a struct to represent a product
//     struct Product {
//         uint256 productId;
//         string productName;
//         address manufacturer;
//         uint256 manufacturingDate;
//         // Add other relevant properties
//     }

//     // Mapping to associate product IDs with Product structs
//     mapping(uint256 => Product) public products;

//     // Function to add a new product to the mapping
//     function addProduct(
//         uint256 _productId,
//         string memory _productName,
//         uint256 _manufacturingDate
//     ) external {
//         // Create a new Product struct
//         Product memory newProduct = Product({
//             productId: _productId,
//             productName: _productName,
//             manufacturer: msg.sender, // The address of the caller is set as the manufacturer
//             manufacturingDate: _manufacturingDate
//             // Initialize other properties as needed
//         });

//         // Add the product to the mapping
//         products[_productId] = newProduct;
//     }

//     // Function to retrieve product details
//     function getProductDetails(uint256 _productId)
//         external
//         view
//         returns (
//             uint256,
//             string memory,
//             address,
//             uint256
//         )
//     {
//         // Retrieve product details from the mapping
//         Product memory retrievedProduct = products[_productId];

//         // Return the product details
//         return (
//             retrievedProduct.productId,
//             retrievedProduct.productName,
//             retrievedProduct.manufacturer,
//             retrievedProduct.manufacturingDate
//         );
//     }
// }

contract Storage {

    uint256 favoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;

    }
    // uint256[] public anArray;

    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {

        favoriteNumber = _favoriteNumber;

    }
    function retrieve() public view returns (uint256) {
        return favoriteNumber;

    }
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}