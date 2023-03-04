// SPDX-License-Identifier: MIT
import "./drivers.sol";

pragma solidity ^0.8.0;

contract P2PRide is Driver {
    address public owner;
    struct Ride {
        address passenger;
        string desination;
        string pickupLocation;
        bool isComplete;
        bool booked;
    }
    uint256 price;

    mapping(address => uint) public ridePrice;
    mapping(address => Ride) public ride;
    mapping(uint => Ride) public ridesId; // rideId => Ride

    Ride[] public rides;

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
    ) public {
        rides.push(
            Ride(msg.sender, _destination, _pickupLocation, false, false)
        );
        Ride memory newRide = rides.push();
        require(newRide.booked == false, "Ride already booked");
        newRide.booked = true;
        newRide.passenger = msg.sender;
        newRide.desination = _destination;
        newRide.pickupLocation = _pickupLocation;
        newRide.isComplete = false;
        ridesId[rides.length] = newRide;
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
