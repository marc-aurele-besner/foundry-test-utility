// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MockERC721 - Test
 */

import { Helper } from './shared/helper.sol';
import { MockERC721 } from './mock/MockERC721.sol';

contract MockERC721Test is Helper {
    uint8 LOG_LEVEL = 0;

    MockERC721 private mockERC721;

    string constant _TEST_NAME = 'MockERC721';
    string constant _TEST_SYMBOL = 'MOCK';

    function setUp() public virtual {
        _initialize_helper(LOG_LEVEL);
        // Deploy contracts
        mockERC721 = new MockERC721();
    }

    function test_MockERC721_name() public virtual {
        assertEq(mockERC721.name(), _TEST_NAME);
    }

    function test_MockERC721_symbol() public virtual {
        assertEq(mockERC721.symbol(), _TEST_SYMBOL);
    }

    function test_MockERC721_mint(address to_, uint256 tokenId_) public virtual {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);

        assertEq(mockERC721.balanceOf(to_), 0);

        mockERC721.mint(to_, tokenId_);

        assertEq(mockERC721.balanceOf(to_), 1);
        assertEq(mockERC721.ownerOf(tokenId_), to_);
    }

    function test_MockERC721_burn(address to_, uint256 tokenId_) public virtual {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);

        assertEq(mockERC721.balanceOf(to_), 0);

        mockERC721.mint(to_, tokenId_);

        assertEq(mockERC721.balanceOf(to_), 1);
        assertEq(mockERC721.ownerOf(tokenId_), to_);

        vm.prank(to_);

        mockERC721.burn(tokenId_);

        assertEq(mockERC721.balanceOf(to_), 0);
    }
}
