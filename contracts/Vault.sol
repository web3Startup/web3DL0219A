// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Vault {
    uint256 public constant _amount = 1 ether;
    uint256 public constant _unlockTime = 1 days;
    address public feeAddress = 0x0acFFB1b8ebDDdeEffbBBbBBbbbbbbBbbbbBbBBb;
    constructor () {
    }

    function getAmount() public pure returns (uint256) {
        return _amount;
    }

    function getUnlockTime() public pure returns (uint256) {
        return _unlockTime;
    }

    function setFeeAddress(address _feeAddress) public {
        feeAddress = _feeAddress;
    }
}
