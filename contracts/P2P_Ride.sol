// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract P2PRide {
    address public owner;
    struct Ride {
        address passenger;
        string desination;
        string pickupLocation;
        bool isComplete;
    }
    uint256 price;

    mapping(address => uint) public ridePrice;

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
        rides.push(Ride(msg.sender, _destination, _pickupLocation, false));
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
