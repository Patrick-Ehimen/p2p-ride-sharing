// SPDX-License-Identifier: MIT

import "./P2PRide.sol";
import "./Drivers.sol";

pragma solidity ^0.8.0;

contract Rides is P2PRide {
    event RideAccepted(address indexed passenger, address indexed driver);
    event RideStarted(address indexed passenger, address indexed driver);

    function acceptRide() public {
        require(userRides[msg.sender].booked == true, "No ride booked");
        //require(driversExist(msg.sender), "No drivers");
        require(
            msg.sender == drivers[msg.sender].address,
            "Driver is not the driver"
        );
        require(msg.sender == drivers[0].address, "Driver is not the driver");
        require(driversDetails[msg.sender].passengerCount > 0, "No passengers");
        require(driversDetails[]);
        require(
            userRides[msg.sender].passenger == msg.sender,
            "You cannot accept this ride"
        );

        userRides[msg.sender].booked = false;

        for (uint i = 0; i < rides.length; i++) {
            if (rides[i].passenger == msg.sender) {
                rides[i].booked = false;
            }
        }

        emit RideAccepted(msg.sender, owner);
    }

    // function acceptRide() public returns(Ride memory) {
    //     require(msg.sender != owner, "Owner cannot accept a ride");
    //     require(rideCount > 0, "No rides to accept");

    //     // Iterate through the rides array to find the ride that matches the passenger
    //     for (uint256 i = 0; i < rides.length; i++) {
    //         // If the ride is booked and the passenger matches the sender, accept the ride
    //         if (rides[i].booked == true && rides[i].passenger == msg.sender) {
    //             rides[i].booked = false;
    //             break;
    //         }
    //     }
    //     return userRides[msg.sender];
    // }
}
