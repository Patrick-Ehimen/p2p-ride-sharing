// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract P2PRide {
    struct Ride {
        address passenger;
        string desination;
        string pickupLocation;
        bool isComplete;
    }
    uint256 price;

    Ride[] public rides;

    function bookRide(
        string memory _destination,
        string memory _pickupLocation
    ) public {
        rides.push(Ride(msg.sender, _destination, _pickupLocation, false));
    }
}
