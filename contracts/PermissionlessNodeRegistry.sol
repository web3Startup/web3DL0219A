// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './library/UtilLib.sol';
import './library/ValidatorStatus.sol';
import './interfaces/IStaderConfig.sol';
import './interfaces/IVaultFactory.sol';
import './interfaces/IPoolUtils.sol';
import './interfaces/INodeRegistry.sol';
import './interfaces/IPermissionlessPool.sol';
import './interfaces/INodeELRewardVault.sol';
import './interfaces/IStaderInsuranceFund.sol';
import './interfaces/IValidatorWithdrawalVault.sol';
import './interfaces/SDCollateral/ISDCollateral.sol';
import './interfaces/IPermissionlessNodeRegistry.sol';
import './interfaces/IOperatorRewardsCollector.sol';

import '@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';

abstract contract PermissionlessNodeRegistry is
    INodeRegistry,
    IPermissionlessNodeRegistry,
    AccessControlUpgradeable,
    PausableUpgradeable,
    ReentrancyGuardUpgradeable
{
    uint8 public constant override POOL_ID = 1;
    uint16 public override inputKeyCountLimit;
    uint64 public override maxNonTerminalKeyPerOperator;

    IStaderConfig public staderConfig;

    // @custom:oz-upgrades-unsafe-allow constructor
    /* inherit from INodeRegistry.sol */
    uint256 public override verifiedKeyBatchSize;
    uint256 public override nextOperatorId;
    uint256 public override nextValidatorId;
    uint256 public override totalActiveValidatorCount;

    /* inherit from IPermissionlessNodeRegistry.sol */
    uint256 public override validatorQueueSize;
    uint256 public override nextQueuedValidatorIndex;
    uint256 public constant override FRONT_RUN_PENALTY = 3 ether;

    /* not override */
    uint256 public constant COLLATERAL_ETH = 4 ether;

    /* @inheritdoc INodeRegistry.sol */
    mapping(uint256 => Validator) public override validatorRegistry;
    mapping(bytes => uint256) public override validatorIdByPubkey;
    mapping(uint256 => Operator) public override operatorStructById;
    mapping(address => uint256) public override operatorIDByAddress;
    mapping(uint256 => uint256[]) public override validatorIdsByOperatorId;

    /* @inheritdoc IPermissionlessNodeRegistry */
    mapping(uint256 => uint256) public override queuedValidators;
}
