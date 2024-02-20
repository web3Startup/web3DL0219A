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

}
