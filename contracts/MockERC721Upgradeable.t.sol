// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title MockERC721Upgradeable - Test
 */

import { Helper } from './shared/helper.sol';
import { MockERC721Upgradeable } from './mock/MockERC721Upgradeable.sol';

contract MockERC721UpgradeableTest is Helper {
    uint8 LOG_LEVEL = 0;

    MockERC721Upgradeable private mockERC721Upgradeable;

    string constant _TEST_NAME = 'MockERC721Upgradeable';
    string constant _TEST_SYMBOL = 'MOCK';

    function setUp() public virtual {
        _initialize_helper(LOG_LEVEL);
        // Deploy contracts
        mockERC721Upgradeable = new MockERC721Upgradeable();
        mockERC721Upgradeable.initialize(_TEST_NAME, _TEST_SYMBOL);
    }

    function test_MockERC721Upgradeable_name() public virtual {
        assertEq(mockERC721Upgradeable.name(), _TEST_NAME);
    }

    function test_MockERC721Upgradeable_symbol() public virtual {
        assertEq(mockERC721Upgradeable.symbol(), _TEST_SYMBOL);
    }

    function test_MockERC721Upgradeable_mint(address to_, uint256 tokenId_) public virtual {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);

        assertEq(mockERC721Upgradeable.balanceOf(to_), 0);

        mockERC721Upgradeable.mint(to_, tokenId_);

        assertEq(mockERC721Upgradeable.balanceOf(to_), 1);
        assertEq(mockERC721Upgradeable.ownerOf(tokenId_), to_);
    }

    function test_MockERC721Upgradeable_burn(address to_, uint256 tokenId_) public virtual {
        vm.assume(to_ != address(0));
        vm.assume(tokenId_ > 0);

        assertEq(mockERC721Upgradeable.balanceOf(to_), 0);

        mockERC721Upgradeable.mint(to_, tokenId_);

        assertEq(mockERC721Upgradeable.balanceOf(to_), 1);
        assertEq(mockERC721Upgradeable.ownerOf(tokenId_), to_);

        vm.prank(to_);

        mockERC721Upgradeable.burn(tokenId_);

        assertEq(mockERC721Upgradeable.balanceOf(to_), 0);
    }
}
