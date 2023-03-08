// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Driver {
    uint public numOfDrivers;
    address[] public drivers;

    struct DriverDetails {
        string name;
        string carModel;
        string carNumber;
        uint256 rating;
        uint256 totalRides;
        uint256 totalEarnings;
    }

    mapping(address => bool) public driversAddress;

    event DriverAdded(address indexed driver);
}
