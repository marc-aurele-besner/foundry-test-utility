// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MockERC1155 - Test
 */

import { Helper } from './shared/helper.sol';
import { MockERC1155 } from './mock/MockERC1155.sol';

contract MockERC1155Test is Helper {
    uint8 LOG_LEVEL = 0;

    MockERC1155 private mockERC1155;

    string constant _TEST_NAME = 'MockERC1155';
    string constant _TEST_SYMBOL = 'MOCK';

    function setUp() public {
        _initialize_helper(LOG_LEVEL);
        // Deploy contracts
        mockERC1155 = new MockERC1155();
    }

    function test_MockERC1155_name() public {
        assertEq(mockERC1155.name(), _TEST_NAME);
    }

    function test_MockERC1155_symbol() public {
        assertEq(mockERC1155.symbol(), _TEST_SYMBOL);
    }

    function test_MockERC1155_mint(
        address to_,
        uint256 tokenId_,
        uint256 amount_
    ) public {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);
        vm.assume(amount_ > 0);

        assertEq(mockERC1155.balanceOf(to_, tokenId_), 0);

        mockERC1155.mint(to_, tokenId_, amount_);

        assertEq(mockERC1155.balanceOf(to_, tokenId_), amount_);
    }

    function test_MockERC1155_burn(
        address to_,
        uint256 tokenId_,
        uint256 amount_
    ) public {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);
        vm.assume(amount_ > 0);

        assertEq(mockERC1155.balanceOf(to_, tokenId_), 0);

        mockERC1155.mint(to_, tokenId_, amount_);

        assertEq(mockERC1155.balanceOf(to_, tokenId_), amount_);

        vm.prank(to_);

        mockERC1155.burn(tokenId_, amount_);

        assertEq(mockERC1155.balanceOf(to_, tokenId_), 0);
    }
}
