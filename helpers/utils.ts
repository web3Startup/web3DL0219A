import {deployments, ethers, getChainId} from "hardhat";
import {Auction, ETHx, OperatorRewardsCollector, Penalty, PermissionlessNodeRegistry} from "../typechain";
export const {AddressZero, MaxInt256: ApproveAmount} = ethers.constants
export const setupFixture = deployments.createFixture(async () => {
    await deployments.fixture();
    return getContracts();
});
export async function getContracts() {
    const chainId = await getChainId();
    const contracts: any = {
        ethx: await ethers.getContract<ETHx>("ETHx"),
        auction: await ethers.getContract<Auction>("Auction"),
        orc : await ethers.getContract<OperatorRewardsCollector>("OperatorRewardsCollector"),
        penalty: await ethers.getContract<Penalty>("Penalty"),
        plnr : await ethers.getContract<PermissionlessNodeRegistry>("PermissionlessNodeRegistry")
    };

    let users: any = {
        owner: await ethers.getNamedSigner("owner"),
        user0: await ethers.getNamedSigner("user0"),
        user1: await ethers.getNamedSigner("user1"),
        user2: await ethers.getNamedSigner("user2"),
    }
    return {...contracts, ...users};
}



