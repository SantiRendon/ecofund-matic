// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Import statement to use console.log for debugging (can be commented out in production)
import "hardhat/console.sol";

contract Lock {
    // Public state variable to store the unlock time
    uint public unlockTime;
    
    // Public state variable to store the owner's address
    address payable public owner;

    // Event that is emitted when a withdrawal is made
    event Withdrawal(uint amount, uint when);

    // Constructor to initialize the contract with an unlock time
    // The constructor is payable, meaning it can receive Ether upon deployment
    constructor(uint _unlockTime) payable {
        // Ensure that the unlock time is in the future
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        // Set the unlock time and the contract's owner
        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    // Function to withdraw Ether from the contract
    function withdraw() public {
        // Uncomment the line below to log unlockTime and block.timestamp (useful for debugging)
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        // Ensure the current time is past the unlock time
        require(block.timestamp >= unlockTime, "You can't withdraw yet");

        // Ensure the caller is the owner of the contract
        require(msg.sender == owner, "You aren't the owner");

        // Emit the withdrawal event with the amount and timestamp
        emit Withdrawal(address(this).balance, block.timestamp);

        // Transfer the contract balance to the owner
        owner.transfer(address(this).balance);
    }
}
