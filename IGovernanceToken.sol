// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IGovernanceToken {
    function balanceOf(address account) external view returns (uint256);
    function totalSupply() external view returns (uint256);
}
