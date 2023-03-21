const { ethers, run, network } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const RideBooking = await ethers.getContractFactory("Rides");
  console.log("Deploying contracts, please wait...");
  const rides = await RideBooking.deploy();
  //the above lines of code deploys the contract
  await rides.deployed();
  console.log("Deployed contract to:", rides.address); // shows the address to which the contract is depoyed to
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
