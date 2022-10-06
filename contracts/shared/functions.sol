// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../utils/console.sol';
import { CheatCodes } from '../utils/cheatcodes.sol';

import { Constants } from './constants.sol';
import { Errors } from './errors.sol';
import { TestStorage } from './testStorage.sol';

contract Functions is Constants, Errors, TestStorage {
    enum TestType {
        Standard
    }
    event InitializingTests(uint8 LOG_LEVEL, TestType testType);

    function initialize_tests(uint8 LOG_LEVEL_, TestType testType_) public virtual {
        // Set general test settings
        _LOG_LEVEL = LOG_LEVEL_;
        vm.roll(1);
        vm.warp(100);
        emit InitializingTests(LOG_LEVEL_, testType_);
    }
}
