const { ethers } = require("hardhat");

async function main() {
    const tokenCap = 100000000;
    const tokenBlockReward = 50;
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", await deployer.getAddress());
    const OceanToken = await ethers.getContractFactory("OceanToken");
    console.log("Deploying OceanToken...");
    const oceanToken = await OceanToken.deploy(tokenCap, tokenBlockReward);
    await oceanToken.waitForDeployment();
    const oceanTokenAddress = await oceanToken.getAddress();
    console.log("OceanToken deployed to:", oceanTokenAddress);
    const totalSupply = await oceanToken.totalSupply();
    console.log("Total supply:", ethers.formatUnits(totalSupply, 18));
    const deployerBalance = await oceanToken.balanceOf(await deployer.getAddress());
    console.log("Deployer balance:", ethers.formatUnits(deployerBalance, 18));
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});