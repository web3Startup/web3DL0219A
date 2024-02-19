import {DeployFunction} from "hardhat-deploy/types";

const func: DeployFunction = async function ({deployments, getNamedAccounts, network, getChainId, getUnnamedAccounts}) {
    const {deploy} = deployments;
    const {owner,deployer} = await getNamedAccounts();
    const chainId = await getChainId();
    console.log(`deployer: ${deployer}`);
    console.log(">> starting deploying on chainId:", chainId);
    console.log(">> deploying vault...");

    const ethx = await deploy("ETHx", {
        from: owner,
        args: [],
        log: true,
    });
    console.log(`ethx: ${ethx.address}`);

    const auction = await deploy("Auction", {
        from : owner,
        args: [],
        log: true,
    });
    console.log(`auction: ${auction.address}`);

    const orc = await deploy("OperatorRewardsCollector", {
        from : owner,
        args: [],
        log: true,
    });
    console.log(`orc: ${orc.address}`);
};
export default func;
func.tags = ["vault"];
