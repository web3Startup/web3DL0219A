import {deployments, ethers, getChainId} from "hardhat";
import {Vault} from "../typechain";
export const {AddressZero, MaxInt256: ApproveAmount} = ethers.constants
export const setupFixture = deployments.createFixture(async () => {
    await deployments.fixture();
    return getContracts();
});
export async function getContracts() {
    const chainId = await getChainId();
    const contracts: any = {
        vault: await ethers.getContract<Vault>("Vault"),
    };

    let users: any = {
        owner: await ethers.getNamedSigner("owner")
    }
    return {...contracts, ...users};
}



