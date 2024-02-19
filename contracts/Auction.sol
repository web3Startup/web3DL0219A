// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import './interfaces/IStaderConfig.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';

contract Auction is AccessControlUpgradeable, ReentrancyGuardUpgradeable{
    struct LotItem {
        uint256 startBlock;
        uint256 endBlock;
        uint256 sdAmount;
        mapping(address => uint256) bids;
        address highestBidder;
        uint256 highestBidAmount;
        bool sdClaimed;
        bool ethExtracted;
    }

    IStaderConfig public staderConfig;
    uint256 public nextLot;
    uint256 public bidIncrement;
    uint256 public duration;
    mapping(uint256 => LotItem) public lots;
    uint256 public constant MIN_AUCTION_DURATION = 7200;


}
