// SPDX-License-Identifier: MIT

import "./P2PRide.sol";
import "./Drivers.sol";

pragma solidity ^0.8.0;

contract Rides is P2PRide {
    event RideAccepted(address indexed driver, uint indexed rideId, uint time);
    event RideStarted(address indexed passenger, address indexed driver);

    function acceptRide(uint _rideId) public onlyDriver {
        require(_rideId < rides.length, "Invalid ride id");
        require(driversExist[msg.sender], "Not a whitelisted driver");
        require(!rides[_rideId].isComplete, "Ride is already completed");
        require(!rides[_rideId].booked, "Ride is already booked");
        require(
            rideAvailable > 0,
            "No rides currently available to be accepted."
        );

        Ride storage ride = rides[_rideId];
        ride.booked = true;
        ride.rideStatus = RideStatus.Accepted;
        rideAvailable--;

        emit RideAccepted(msg.sender, _rideId, block.timestamp);
    }
}
