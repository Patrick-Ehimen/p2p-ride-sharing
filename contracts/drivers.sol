// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Driver {
    uint public numOfDrivers;
    address[] public drivers;
    uint public immutable registrationFee;
    address public owner;
    uint public balance;

    struct DriverDetails {
        string name;
        string carModel;
        string carNumber;
        uint256 rating;
        uint256 totalRides;
        uint256 totalEarnings;
    }

    mapping(address => bool) public driversExist;
    mapping(address => DriverDetails) public driversDetails;

    event DriverSignup(
        address indexed driver,
        string name,
        string carModel,
        string carNumber
    );
    event DriverAdded(address indexed driver);
    event Withdrawal(address indexed owner, uint amount);

    constructor() {
        registrationFee = 0.1 ether;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can call this function");
        _;
    }

    modifier onlyDriver() {
        require(
            driversExist[msg.sender],
            "You are not authorized to accept rides."
        );
        _;
    }

    function driverSignup(
        string memory _name,
        string memory _carModel,
        string memory _carNumber
    ) public payable {
        require(msg.value == registrationFee, "Registration fee not paid");
        require(msg.sender != owner, "Owner cannot be a driver");
        require(!driversExist[msg.sender], "Driver already exists");
        addDriver();
        DriverDetails memory newDriver = DriverDetails({
            name: _name,
            carModel: _carModel,
            carNumber: _carNumber,
            rating: 0,
            totalRides: 0,
            totalEarnings: 0
        });
        balance += msg.value;

        driversDetails[msg.sender] = newDriver;
        emit DriverSignup(msg.sender, _name, _carModel, _carNumber);
    }

    function addDriver() internal {
        require(msg.sender != owner, "Owner cannot be a driver");
        require(!driversExist[msg.sender], "Driver already exists");
        drivers.push(msg.sender);
        driversExist[msg.sender] = true;
        numOfDrivers++;

        emit DriverAdded(msg.sender);
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(balance);
        balance = 0;

        emit Withdrawal(msg.sender, balance);
    }
}
