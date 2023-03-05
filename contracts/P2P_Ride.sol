// SPDX-License-Identifier: MIT
import "./drivers.sol";

pragma solidity ^0.8.0;

contract P2PRide is Driver {
    address public owner;
    struct Ride {
        address passenger;
        string destination;
        string pickupLocation;
        bool isComplete;
        bool booked;
    }
    uint256 public price;
    uint public rideCount;

    mapping(address => Ride) myRide;

    Ride[] public rides;

    event RideBooked(
        address indexed passenger,
        string destination,
        string pickupLocation
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can call this function");
        _;
    }

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

        emit RideBooked(msg.sender, _destination, _pickupLocation);
    }

    function getRidePrice() public {}

    function cancelRide() public {
        require(msg.sender != owner, "Owner cannot cancel a ride");
        require(rideCount > 0, "No rides to cancel");
        require(
            msg.sender == rides[rideCount - 1].passenger,
            "You cannot cancel this ride"
        );

        for (uint256 i = 0; i < rides.length; i++) {
            if (rides[i].booked == true && rides[i].passenger == msg.sender) {
                rides[i].booked = false;
                break;
            }
        }
        rideCount--;
    }

    function updateRide() public {}

    function getRides() public {}

    function acceptRide() public {}

    function startRide() public {}

    function endRide() public {}

    function rateRide() public {}

    function getDriverRides() public onlyOwner {}

    function getUserRides() public onlyOwner {}

    function getCompletedRides() public {}

    function getDriverStats() public {}

    function getUserStats() public {}
}
