import {task} from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import '@nomiclabs/hardhat-ethers';
import 'hardhat-deploy';
import '@typechain/hardhat';
import {HardhatUserConfig} from 'hardhat/types';
import "solidity-coverage";
import "@nomiclabs/hardhat-etherscan";
import "@matterlabs/hardhat-zksync-solc";
import "@matterlabs/hardhat-zksync-verify";
const secret = require("./secret.json");

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
    const accounts = await hre.ethers.getSigners();

    for (const account of accounts) {
        console.log(account.address);
    }
});

const config: HardhatUserConfig = {
    solidity: {
        compilers: [
            {
                version: "0.6.12",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 100
                    }
                }
            },
            {
                version: "0.8.17",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 100
                    }
                }
            }
        ]

    },
    zksolc: {
        version: "1.3.5",
        compilerSource: "binary",
        settings: {},
    },
    namedAccounts: {
        owner: 0,
        user0: 1,
        user1: 2,
        user2: 3,
        user3: 4,
        user4: 5,
        positionKeeper: 6,
        tokenManager: 7,
        mintReceiver: 8,
        miner: 9,
        feeTo: 10,
        receiver: 11,

        deployer: {
            default: 0
        },
        feeCollector:{
            default: 1
        }
    },
    networks: {
        zksync_testnet: {
            zksync: true,
            url: secret.url_zksync_testnet,
            accounts: [
                secret.key_prd
            ],
            timeout: 30000,
            verifyURL: "https://zksync2-testnet-explorer.zksync.dev/contract_verification",
        },
        hardhat: {
        },
    },
    mocha: {
        timeout: 60000,
    },
}
export default config;

