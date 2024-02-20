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

contract PermissionlessNodeRegistry is
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
    mapping(uint256 => address) public override nodeELRewardVaultByOperatorId;

    /* native mappings */
    mapping(uint256 => uint256) public socializingPoolStateChangeBlock;
    mapping(uint256 => address) public proposedRewardAddressByOperatorId;

    constructor() {
    }

    function initialize(address _admin, address _staderConfig) external initializer {
        UtilLib.checkNonZeroAddress(_admin);
        UtilLib.checkNonZeroAddress(_staderConfig);

        __AccessControl_init_unchained();
        __Pausable_init();
        __ReentrancyGuard_init();

        staderConfig = IStaderConfig(_staderConfig);
        nextOperatorId = 1;
        nextValidatorId = 1;
        inputKeyCountLimit = 30;
        maxNonTerminalKeyPerOperator = 50;
        verifiedKeyBatchSize = 100;
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
    }

    /* public functions */
    function onboardNodeOperator(
        bool _optInForSocializingPool,
        string calldata _operatorName,
        address payable _operatorRewardAddress
    ) external override whenNotPaused returns (address feeRecipientAddress) {
        //todo: add code
    }

    function addValidatorKeys(
        bytes[] calldata _pubkey,
        bytes[] calldata _preDepositSignature,
        bytes[] calldata _depositSignature
    ) external payable override nonReentrant whenNotPaused {
        //todo: add code
    }

    function markValidatorReadyToDeposit(
        bytes[] calldata _readyToDepositPubkey,
        bytes[] calldata _frontRunPubkey,
        bytes[] calldata _invalidSignaturePubkey
    ) external override nonReentrant whenNotPaused {
        //todo: add code
    }

    function withdrawnValidators(bytes[] calldata _pubkeys) external override {
        //todo: add code
    }

    /* settings */
    function updateNextQueuedValidatorIndex(uint256 _nextQueuedValidatorIndex) external {
        nextQueuedValidatorIndex = _nextQueuedValidatorIndex;
        emit UpdatedNextQueuedValidatorIndex(nextQueuedValidatorIndex);
    }

    function updateDepositStatusAndBlock(uint256 _validatorId) external override {
        //todo: add code
    }

    function changeSocializingPoolState(bool _optInForSocializingPool) external override returns (address feeRecipientAddress) {
        //todo: add code
    }

    /* settings */
    function updateInputKeyCountLimit(uint16 _inputKeyCountLimit) external override {
        UtilLib.onlyOperatorRole(msg.sender, staderConfig);
        inputKeyCountLimit = _inputKeyCountLimit;
        emit UpdatedInputKeyCountLimit(inputKeyCountLimit);
    }

    function updateMaxNonTerminalKeyPerOperator(uint64 _maxNonTerminalKeyPerOperator) external override {
        UtilLib.onlyManagerRole(msg.sender, staderConfig);
        maxNonTerminalKeyPerOperator = _maxNonTerminalKeyPerOperator;
        emit UpdatedMaxNonTerminalKeyPerOperator(maxNonTerminalKeyPerOperator);
    }

    function updateVerifiedKeysBatchSize(uint256 _verifiedKeysBatchSize) external {
        UtilLib.onlyOperatorRole(msg.sender, staderConfig);
        verifiedKeyBatchSize = _verifiedKeysBatchSize;
        emit UpdatedVerifiedKeyBatchSize(_verifiedKeysBatchSize);
    }

    function updateStaderConfig(address _staderConfig) external onlyRole(DEFAULT_ADMIN_ROLE) {
        UtilLib.checkNonZeroAddress(_staderConfig);
        staderConfig = IStaderConfig(_staderConfig);
        emit UpdatedStaderConfig(_staderConfig);
    }

    function updateOperatorName(string calldata _operatorName) external override {
        //todo: add code
    }

    function increaseTotalActiveValidatorCount(uint256 _count) external override {
        //todo: add code
    }

    // functions

    function proposeRewardAddress(address _operatorAddress, address _newRewardAddress) external override {
        //todo: add code
    }

    function confirmRewardAddressChange(address _operatorAddress) external override {
        //todo: add code
    }

    function transferCollateralToPool(uint256 _amount) external override nonReentrant {
        //todo: add code
    }

    /* views */
    function getOperatorTotalNonTerminalKeys(address _nodeOperator, uint256 _startIndex, uint256 _endIndex) public view override returns (uint64) {
        //todo: add code
    }

    function getOperatorTotalKeys(uint256 _operatorId) public view override returns (uint256 _totalKeys) {
        //todo: add code
    }

    function getTotalQueuedValidatorCount() external view override returns (uint256) {
//        return validatorQueueSize - nextQueuedValidatorIndex;
    }

    function getTotalActiveValidatorCount() external view override returns (uint256) {
        return totalActiveValidatorCount;
    }

    function getCollateralETH() external pure override returns (uint256) {
        return COLLATERAL_ETH;
    }

    function getOperatorRewardAddress(uint256 _operatorId) external view override returns (address payable) {
        // return operatorStructById[_operatorId].operatorRewardAddress;
    }

    function getAllActiveValidators(uint256 _pageNumber, uint256 _pageSize) external view override returns (Validator[] memory){
        //todo: add code
    }


    function getValidatorsByOperator(address _operator, uint256 _pageNumber, uint256 _pageSize) external view override returns (Validator[] memory) {
        //todo: add code
    }

    function isExistingPubkey(bytes calldata _pubkey) external view override returns (bool) {
        return validatorIdByPubkey[_pubkey] != 0;
    }

    function isExistingOperator(address _operAddr) external view override returns (bool) {
        return operatorIDByAddress[_operAddr] != 0;
    }

    function getAllNodeELVaultAddress(uint256 _pageNumber, uint256 _pageSize) external view override returns (address[] memory){
        //todo: add code
    }

    function getSocializingPoolStateChangeBlock(uint256 _operatorId) external view returns (uint256) {
        return socializingPoolStateChangeBlock[_operatorId];
    }




    /* functions */
    function pause() external override {
//        UtilLib.onlyManagerRole(msg.sender, staderConfig);
//        _pause();
    }

    function unpause() external override {
//        UtilLib.onlyManagerRole(msg.sender, staderConfig);
        _unpause();
    }
}
