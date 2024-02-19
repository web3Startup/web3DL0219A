import {DeployFunction} from "hardhat-deploy/types";

const func: DeployFunction = async function ({deployments, getNamedAccounts, network, getChainId, getUnnamedAccounts}) {
    const {deploy} = deployments;
    const {owner,deployer} = await getNamedAccounts();
    const chainId = await getChainId();
    console.log(">> starting deploying on chainId:", chainId);
    console.log(">> deploying vault...");

    const Vault = await deploy("Vault", {
        from: owner,
        args: [],
        log: true,
    });
    console.log(`deployer: ${deployer}`);
};
export default func;
func.tags = ["vault"];
