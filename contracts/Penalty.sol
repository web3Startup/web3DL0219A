// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './library/UtilLib.sol';
import './interfaces/IStaderConfig.sol';
import '@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';

contract Penalty is AccessControlUpgradeable, ReentrancyGuardUpgradeable {
    bytes32 public constant MANAGER_ROLE = keccak256('MANAGER');
    IStaderConfig public staderConfig;
    address public ratedOracleAddress;
    uint256 public mevTheftPenaltyPerStrike;
    uint256 public missedAttestationPenaltyPerStrike;
    uint256 public validatorExitPenaltyThreshold;

    mapping(bytes32 => uint256) public additionalPenaltyAmount;
    mapping(bytes => uint256) public totalPenaltyAmount;

    constructor() {
    }

    function initialize(
        address _admin,
        address _staderConfig,
        address _ratedOracleAddress
    ) initializer external {

        __AccessControl_init_unchained();
        __ReentrancyGuard_init();

        staderConfig = IStaderConfig(_staderConfig);
        ratedOracleAddress = _ratedOracleAddress;
        mevTheftPenaltyPerStrike = 1 ether;
        missedAttestationPenaltyPerStrike = 0.2 ether;
        validatorExitPenaltyThreshold = 2 ether;
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
    }

    /* GOVERNANCE */
    function updateMEVTheftPenaltyPerStrike(uint256 _mevTheftPenaltyPerStrike) external onlyRole(MANAGER_ROLE) {
        mevTheftPenaltyPerStrike = _mevTheftPenaltyPerStrike;
    }

    function updateMissedAttestationPenaltyPerStrike(uint256 _missedAttestationPenaltyPerStrike) external onlyRole(MANAGER_ROLE) {
        missedAttestationPenaltyPerStrike = _missedAttestationPenaltyPerStrike;
    }

    function updateValidatorExitPenaltyThreshold(uint256 _validatorExitPenaltyThreshold) external onlyRole(MANAGER_ROLE) {
        validatorExitPenaltyThreshold = _validatorExitPenaltyThreshold;
    }

    function updateRatedOracleAddress(address _ratedOracleAddress) external onlyRole(MANAGER_ROLE) {
        UtilLib.checkNonZeroAddress(_ratedOracleAddress);
        ratedOracleAddress = _ratedOracleAddress;
    }

    function updateStaderConfig(address _staderConfig) external onlyRole(MANAGER_ROLE) {
        UtilLib.checkNonZeroAddress(_staderConfig);
        staderConfig = IStaderConfig(_staderConfig);
    }
}
