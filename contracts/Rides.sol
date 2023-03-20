// SPDX-License-Identifier: MIT

import "./P2PRide.sol";
import "./Drivers.sol";

pragma solidity ^0.8.0;

contract Rides is P2PRide {
    event RideAccepted(address indexed driver, uint indexed rideId, uint time);
    event RideStarted(address indexed passenger, address indexed driver);
    event RideCompleted(address indexed passenger, address indexed driver);

    function acceptRide(uint _rideId) public onlyDriver {
        require(_rideId < rides.length, "Invalid ride id");
        require(driversExist[msg.sender], "Not a whitelisted driver");
        require(!rides[_rideId].isComplete, "Ride is already completed");
        //require(!rides[_rideId].booked, "Ride is already booked");
        require(
            rideAvailable > 0,
            "No rides currently available to be accepted."
        );
        //things to work on
        //1.  update the userRides mapping
        //2.allow the drive to accept ride just 1s until ride is either canceled  or ended

        Ride storage ride = rides[_rideId];
        ride.booked = true;
        ride.rideStatus = RideStatus.Accepted;
        userRides[msg.sender].rideStatus = RideStatus.Accepted;

        rideAvailable--;
        ridesAccepted++;

        emit RideAccepted(msg.sender, _rideId, block.timestamp);
    }

    function startRide(uint _rideId) public onlyDriver {
        require(driversExist[msg.sender], "Not a whitelisted driver");
        require(ridesAccepted > 0, "You must start ride first.");
        require(_rideId < rides.length, "Invalid ride id");

        Ride storage ride = rides[_rideId];
        require(ride.rideStatus == RideStatus.Accepted, "Ride is not accepted");
        if (rides[_rideId].rideStatus == RideStatus.Accepted) {
            rides[_rideId].rideStatus = RideStatus.Started;
            userRides[msg.sender].rideStatus = RideStatus.Started;
            //ridesStarted++;
            emit RideStarted(ride.passenger, msg.sender);
        }
        // if(ride.rideStatus == RideStatus.Accepted){
        //     ride.rideStatus = RideStatus.Started;
        //     userRides[msg.sender].rideStatus = RideStatus.Started;
        //     //ridesStarted++;
        //     emit RideStarted(ride.passenger, msg.sender);
        // }
    }

    function endRide(uint _rideId) public onlyDriver {
        require(driversExist[msg.sender], "Not a whitelisted driver");
        // require(ride.rideStatus == RideStatus.Started, "Ride is not started");
        require(
            rides[_rideId].rideStatus == RideStatus.Started,
            "Ride is not started"
        );
        if (rides[_rideId].rideStatus == RideStatus.Started) {
            rides[_rideId].rideStatus = RideStatus.Completed;
            userRides[msg.sender].rideStatus = RideStatus.Completed;
            rides[_rideId].isComplete = true;
            //ridesCompleted++;
            emit RideCompleted(rides[_rideId].passenger, msg.sender);
        }
    }
}
