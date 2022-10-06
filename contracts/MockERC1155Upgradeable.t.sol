// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MockERC1155Upgradeable - Test
 */

import { Helper } from './shared/helper.sol';
import { MockERC1155Upgradeable } from './mock/MockERC1155Upgradeable.sol';

contract MockERC1155UpgradeableTest is Helper {
    uint8 LOG_LEVEL = 0;

    MockERC1155Upgradeable private mockERC1155Upgradeable;

    string constant _TEST_NAME = 'MockERC1155Upgradeable';
    string constant _TEST_SYMBOL = 'MOCK';
    string constant _TEST_URI = 'https://google.com';

    function setUp() public {
        initialize_helper(LOG_LEVEL);
        // Deploy contracts
        mockERC1155Upgradeable = new MockERC1155Upgradeable();
        mockERC1155Upgradeable.initialize(_TEST_NAME, _TEST_SYMBOL, _TEST_URI);
    }

    function test_MockERC1155Upgradeable_name() public {
        assertEq(mockERC1155Upgradeable.name(), _TEST_NAME);
    }

    function test_MockERC1155Upgradeable_symbol() public {
        assertEq(mockERC1155Upgradeable.symbol(), _TEST_SYMBOL);
    }

    function test_MockERC1155Upgradeable_mint(
        address to_,
        uint256 tokenId_,
        uint256 amount_
    ) public {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);
        vm.assume(amount_ > 0);

        assertEq(mockERC1155Upgradeable.balanceOf(to_, tokenId_), 0);

        mockERC1155Upgradeable.mint(to_, tokenId_, amount_);

        assertEq(mockERC1155Upgradeable.balanceOf(to_, tokenId_), amount_);
    }

    function test_MockERC1155Upgradeable_burn(
        address to_,
        uint256 tokenId_,
        uint256 amount_
    ) public {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);
        vm.assume(amount_ > 0);

        assertEq(mockERC1155Upgradeable.balanceOf(to_, tokenId_), 0);

        mockERC1155Upgradeable.mint(to_, tokenId_, amount_);

        assertEq(mockERC1155Upgradeable.balanceOf(to_, tokenId_), amount_);

        vm.prank(to_);

        mockERC1155Upgradeable.burn(tokenId_, amount_);

        assertEq(mockERC1155Upgradeable.balanceOf(to_, tokenId_), 0);
    }
}
