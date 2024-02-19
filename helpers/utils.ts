import {deployments, ethers, getChainId} from "hardhat";
import {Auction, ETHx} from "../typechain";
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
    };

    let users: any = {
        owner: await ethers.getNamedSigner("owner")
    }
    return {...contracts, ...users};
}



