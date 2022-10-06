// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MockERC20Upgradeable - Test
 */

import { Helper } from './shared/helper.sol';
import { MockERC20Upgradeable } from './mock/MockERC20Upgradeable.sol';

contract MockERC20UpgradeableTest is Helper {
    uint8 LOG_LEVEL = 0;

    MockERC20Upgradeable private mockERC20Upgradeable;

    string constant _TEST_NAME = 'MockERC20Upgradeable';
    string constant _TEST_SYMBOL = 'MOCK';

    function setUp() public {
        initialize_helper(LOG_LEVEL);
        // Deploy contracts
        mockERC20Upgradeable = new MockERC20Upgradeable();
        mockERC20Upgradeable.initialize(_TEST_NAME, _TEST_SYMBOL);
    }

    function test_MockERC20Upgradeable_name() public {
        assertEq(mockERC20Upgradeable.name(), _TEST_NAME);
    }

    function test_MockERC20Upgradeable_symbol() public {
        assertEq(mockERC20Upgradeable.symbol(), _TEST_SYMBOL);
    }

    function test_MockERC20Upgradeable_mint(address to_, uint256 amount_) public {
        vm.assume(to_ != address(0));
        vm.assume(amount_ > 0);

        assertEq(mockERC20Upgradeable.balanceOf(to_), 0);
        assertEq(mockERC20Upgradeable.totalSupply(), 0);

        mockERC20Upgradeable.mint(to_, amount_);

        assertEq(mockERC20Upgradeable.balanceOf(to_), amount_);
        assertEq(mockERC20Upgradeable.totalSupply(), amount_);
    }

    function test_MockERC20Upgradeable_burn(address to_, uint256 amount_) public {
        vm.assume(to_ != address(0));
        vm.assume(amount_ > 0);

        assertEq(mockERC20Upgradeable.balanceOf(to_), 0);
        assertEq(mockERC20Upgradeable.totalSupply(), 0);

        mockERC20Upgradeable.mint(to_, amount_);

        assertEq(mockERC20Upgradeable.balanceOf(to_), amount_);

        vm.prank(to_);

        mockERC20Upgradeable.burn(amount_);

        assertEq(mockERC20Upgradeable.balanceOf(to_), 0);
        assertEq(mockERC20Upgradeable.totalSupply(), 0);
    }
}
