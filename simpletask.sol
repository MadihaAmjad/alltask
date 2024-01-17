// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// contract ItemCounter {
//     // Mapping to store the count of occurrences for each item
//     mapping(string => uint256) public itemCount;

//     // Function to add a new item to the list and update its count
//     function addItem(string memory item) public {
//         // Increment the count of the item by 1
//         itemCount[item]++;
//     }

//     // Function to retrieve the count of a specific item
//     function getItemCount(string memory item) public view returns (uint256) {
//         // Return the count of the specified item
//         return itemCount[item];
//     }
// }


// contract AccessControl {
//     // Enum to define different access levels
//     enum AccessLevel { None, Low, Medium, High }

//     // Mapping to store addresses with their corresponding access levels
//     mapping(address => AccessLevel) public accessLevels;

//     // Function to set the access level for a specific address
//     function setAccessLevel(address user, AccessLevel level) public {
//         // Only the contract owner or a designated authority can set access levels
//         // You can customize the access control logic based on your requirements
//         // In this example, anyone can set access levels for simplicity
//         accessLevels[user] = level;
//     }

//     // Function to check if a given address has a specific access level
//     function hasAccessLevel(address user, AccessLevel requiredLevel) public view returns (bool) {
//         // Retrieve the access level of the specified address
//         AccessLevel userLevel = accessLevels[user];

//         // Check if the user's access level is equal to or higher than the required level
//         return uint256(userLevel) >= uint256(requiredLevel);
//     }
// }

// contract AccessTracker {
//     // Mapping to store addresses and their last access time
//     mapping(address => uint256) public lastAccessTime;

//     // Function to record the access time for the calling address
//     function recordAccess() public {
//         // Record the current block timestamp as the last access time
//         lastAccessTime[msg.sender] = block.timestamp;
//     }

//     // Function to check if a specific address has accessed within the last 24 hours
//     function hasAccessWithinLast24Hours(address user) public view returns (bool) {
//         // Retrieve the last access time of the specified address
//         uint256 userLastAccessTime = lastAccessTime[user];

//         // Check if the last access time is within the last 24 hours
//         return (block.timestamp - userLastAccessTime) <= 24 hours;
//     }
// }





// contract ItemManager {
//     // Mapping to store items with their active status
//     mapping(string => bool) public itemStatus;

//     // Event to log when an item is added or deactivated
//     event ItemStatusChanged(string indexed item, bool isActive);

//     // Function to add a new item with the active status
//     function addItem(string memory newItem) public {
//         // Ensure the item does not already exist (optional, depending on your use case)
//         require(!itemStatus[newItem], "Item already exists");

//         // Set the active status of the new item to true
//         itemStatus[newItem] = true;

//         // Emit an event to log the item addition
//         // emit ItemStatusChanged(newItem, true);
//     }

//     // Function to deactivate a specific item
//     function deactivateItem(string memory existingItem) public {
//         // Ensure the item exists before deactivating
//         require(itemStatus[existingItem], "Item does not exist");

//         // Set the active status of the item to false
//         itemStatus[existingItem] = false;

//         // Emit an event to log the item deactivation
//         // emit ItemStatusChanged(existingItem, false);
//     }
// }




// contract MT {



//     mapping(string => bool) public items;


//     function addItem(string memory _message) public {
//         items[_message] = true;
//     }

//     function deleteItem(string memory _message) public {
//         delete items[_message];
//     }
// }


contract KeyValueIterator {
    // Mapping to store key-value pairs
    mapping(uint256 => string) public keyValueMap;

    // Array to store keys
    uint256[] public keys;

    // Function to add a new key-value pair
    function addKeyValuePair(uint256 key, string memory value) public {
        // Add the key-value pair to the mapping
        keyValueMap[key] = value;

        // Add the key to the array of keys
        keys.push(key);
    }

    // Function to iterate through all key-value pairs and perform a specific operation
    function iterateAndPerformOperation() public view returns (string[] memory) {
        uint256 length = keys.length;
        string[] memory results = new string[](length);

        // Iterate through all keys
        for (uint256 i = 0; i < length; i++) {
            uint256 key = keys[i];
            string memory value = keyValueMap[key];

            // Perform a specific operation (in this case, just return the value)
            results[i] = value;
        }

        return results;
    }
}