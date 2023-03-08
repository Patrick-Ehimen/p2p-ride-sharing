// SPDX-License-Identifier: MIT

import "./P2P_NFT.sol";

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

    mapping(address => bool) public listOfDrivers;

    event DriverAdded(address indexed driver);

    function addDriver() internal {
        require(!listOfDrivers[msg.sender], "Driver already exists");
        drivers.push(msg.sender);
        listOfDrivers[msg.sender] = true;
        numOfDrivers++;
        emit DriverAdded(msg.sender);
    }
}
