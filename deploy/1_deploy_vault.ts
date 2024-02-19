import {DeployFunction} from "hardhat-deploy/types";

const func: DeployFunction = async function ({deployments, getNamedAccounts, network, getChainId, getUnnamedAccounts}) {
    const {deploy} = deployments;
    const {owner,deployer} = await getNamedAccounts();
    const chainId = await getChainId();
    console.log(`deployer: ${deployer}`);
    console.log(">> starting deploying on chainId:", chainId);
    console.log(">> deploying vault...");

    // const Vault = await deploy("Vault", {
    //     from: owner,
    //     args: [],
    //     log: true,
    // });

    const ethx = await deploy("ETHx", {
        from: owner,
        args: [],
        log: true,
    });
    console.log(`ethx: ${ethx.address}`);

};
export default func;
func.tags = ["vault"];
