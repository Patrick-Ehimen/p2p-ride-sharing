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
    uint256 price; // rideId => Ride

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

        // Ride memory newRide = rides.push();
        // require(newRide.booked == false, "Ride already booked");
        // newRide.booked = true;
        // newRide.passenger = msg.sender;
        // newRide.desination = _destination;
        // newRide.pickupLocation = _pickupLocation;
        // newRide.isComplete = false;

        emit RideBooked(msg.sender, _destination, _pickupLocation);
    }

    function getRidePrice() public {}

    function cancelRide() public {}

    function getRide() public {}

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
