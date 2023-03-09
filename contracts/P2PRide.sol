// SPDX-License-Identifier: MIT
import "./Drivers.sol";

pragma solidity ^0.8.0;

contract P2PRide is Driver {
    struct Ride {
        address passenger;
        string destination;
        string pickupLocation;
        bool isComplete;
        bool booked;
    }
    uint256 public price;
    uint public rideCount;

    mapping(address => uint256) public currentRides;
    mapping(address => Ride) public userRides;

    Ride[] public rides;

    event RideBooked(
        address indexed passenger,
        string destination,
        string pickupLocation
    );

    // constructor() {
    //     owner = msg.sender;
    // }

    function bookRide(
        string memory _destination,
        string memory _pickupLocation
    ) public payable {
        require(msg.sender != owner, "Owner cannot book a ride");
        require(msg.value == price, "Insufficient funds");

        bool alreadyBooked = false;

        for (uint256 i = 0; i < rides.length; i++) {
            if (rides[i].booked == true && rides[i].passenger == msg.sender) {
                alreadyBooked = true;
                break;
            }
        }

        require(!alreadyBooked, "Ride already booked.");

        Ride memory newRide = Ride({
            passenger: msg.sender,
            destination: _destination,
            pickupLocation: _pickupLocation,
            isComplete: false,
            booked: true
        });

        rides.push(newRide);
        rideCount++;
        userRides[msg.sender] = newRide;

        emit RideBooked(msg.sender, _destination, _pickupLocation);
    }

    function getRidePrice() public {}

    function cancelRide() public {
        require(msg.sender != owner, "Owner cannot cancel a ride");
        require(userRides[msg.sender].booked == true, "No ride booked");
        require(
            userRides[msg.sender].passenger == msg.sender,
            "You cannot cancel this ride"
        );

        userRides[msg.sender].booked = false;

        userRides[msg.sender].passenger = address(0);
        userRides[msg.sender].destination = "";
        userRides[msg.sender].pickupLocation = "";
        userRides[msg.sender].isComplete = false;

        for (uint i = 0; i < rides.length; i++) {
            if (rides[i].passenger == msg.sender) {
                rides[i] = rides[rides.length - 1];
                rides.pop();
            }
        }

        rideCount--;

        //rides = removeRide(rides, userRides[msg.sender]);
    }

    function updateRide() public {}

    function endRide() public {}

    function rateRide() public {}

    function getDriverRides() public {}

    function getUserRides() public onlyOwner {}

    function getCompletedRides() public {}

    function getDriverStats() public {}

    function getUserStats() public {}
}
