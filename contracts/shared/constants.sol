// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Constants {
    // Constants value specific to the contracts we are testing.

    uint256 DEFAULT_MINT_VALUE;
    uint256 DEFAULT_BLOCKS_COUNT;

    address ADMIN;

    constructor() {
        // Set the default values for the contracts we are testing.
        DEFAULT_MINT_VALUE = 1;
        DEFAULT_BLOCKS_COUNT = 25;
        ADMIN = address(42_000);
    }
}
