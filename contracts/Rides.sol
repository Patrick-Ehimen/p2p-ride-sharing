// SPDX-License-Identifier: MIT

import "./P2PRide.sol";
import "./Drivers.sol";

pragma solidity ^0.8.0;

contract Rides is P2PRide {
    function acceptRide() public {
        require(msg.sender != owner, "Owner cannot accept a ride");
        require(rideCount > 0, "No rides to accept");

        // Iterate through the rides array to find the ride that matches the passenger
        for (uint256 i = 0; i < rides.length; i++) {
            // If the ride is booked and the passenger matches the sender, accept the ride
            if (rides[i].booked == true && rides[i].passenger == msg.sender) {
                rides[i].booked = false;
                break;
            }
        }
    }
}
