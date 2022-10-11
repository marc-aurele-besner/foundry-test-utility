// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import '../utils/console.sol';
import { stdCheats as Cheats } from '../utils/stdlib.sol';

import { Functions } from './functions.sol';

contract Helper is Functions, Cheats {
    function _initialize_helper(uint8 LOG_LEVEL_, TestType testType_) internal virtual {
        // Deploy contracts
        Functions._initialize_tests(
            // Test Settings
            LOG_LEVEL_,
            testType_
        );
    }

    function _initialize_helper(uint8 LOG_LEVEL_) internal virtual {
        _initialize_helper(LOG_LEVEL_, TestType.Standard);
    }

    function help_changeLogLevel(uint8 newLogLevel_) internal virtual {
        _LOG_LEVEL = newLogLevel_;
    }

    function help_changeDefaultMintValue(uint256 newDefaultMintValue_) internal virtual {
        DEFAULT_MINT_VALUE = newDefaultMintValue_;
    }

    function help_changeDefaultBlocksCount(uint256 newDefaultBlocksCount_) internal virtual {
        DEFAULT_BLOCKS_COUNT = newDefaultBlocksCount_;
    }

    function help_moveBlockFoward(uint256 blockToRoll_) internal virtual {
        vm.roll(block.number + blockToRoll_);
    }

    function help_moveTimeFoward(uint256 secondToWarp_) internal virtual {
        Cheats.skip(secondToWarp_);
    }

    function help_moveBlockAndTimeFoward(uint256 blockToRoll_, uint256 secondToWarp_) internal virtual {
        help_moveBlockFoward(blockToRoll_);
        help_moveTimeFoward(secondToWarp_);
    }
}
