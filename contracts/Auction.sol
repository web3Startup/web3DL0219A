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

    function initialize(address _admin, address _staderConfig) external initializer{
        __AccessControl_init();
        __ReentrancyGuard_init();
        staderConfig = IStaderConfig(_staderConfig);
        duration = 2 * MIN_AUCTION_DURATION;
        bidIncrement = 5e15;
        nextLot = 1;
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
    }

    function createLot(uint256 _sdAmount) external {
        lots[nextLot].startBlock = block.number;
        lots[nextLot].endBlock = block.number + duration;
        lots[nextLot].sdAmount = _sdAmount;

        // todo: add code to transfer token from msg.sender to this contract
        nextLot++;
    }

    function updateStaderConfig(address _staderConfig) external onlyRole(DEFAULT_ADMIN_ROLE){
        staderConfig = IStaderConfig(_staderConfig);
    }

    function updateDuration(uint256 _duration) external onlyRole(DEFAULT_ADMIN_ROLE){
        duration = _duration;
    }

    function updateBidIncrement(uint256 _bidIncrement) external onlyRole(DEFAULT_ADMIN_ROLE){
        bidIncrement = _bidIncrement;
    }
}
