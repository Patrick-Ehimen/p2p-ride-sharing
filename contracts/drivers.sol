// SPDX-License-Identifier: MIT

import "./P2P_NFT.sol";

pragma solidity ^0.8.0;

contract Driver {
    uint public numOfDrivers;
    address[] public drivers;
    uint public immutable registrationFee;
    address public owner;

    struct DriverDetails {
        string name;
        string carModel;
        string carNumber;
        uint256 rating;
        uint256 totalRides;
        uint256 totalEarnings;
    }

    mapping(address => bool) public listOfDrivers;
    mapping(address => DriverDetails) public driversDetails;

    event DriverSignup(
        address indexed driver,
        string name,
        string carModel,
        string carNumber
    );
    event DriverAdded(address indexed driver);

    constructor() {
        registrationFee = 0.1 ether;
        owner = msg.sender;
    }

    function driverSignup(
        string memory _name,
        string memory _carModel,
        string memory _carNumber
    ) public payable {
        require(msg.value == registrationFee, "Registration fee not paid");
        require(msg.sender != owner, "Owner cannot be a driver");
        require(!listOfDrivers[msg.sender], "Driver already exists");
        addDriver();
        DriverDetails memory newDriver = DriverDetails({
            name: _name,
            carModel: _carModel,
            carNumber: _carNumber,
            rating: 0,
            totalRides: 0,
            totalEarnings: 0
        });

        driversDetails[msg.sender] = newDriver;
        emit DriverSignup(msg.sender, _name, _carModel, _carNumber);
    }

    function addDriver() public {
        require(!listOfDrivers[msg.sender], "Driver already exists");
        drivers.push(msg.sender);
        listOfDrivers[msg.sender] = true;
        numOfDrivers++;

        emit DriverAdded(msg.sender);
    }
}
