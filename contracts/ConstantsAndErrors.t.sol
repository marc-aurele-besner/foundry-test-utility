// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import { Vm } from './utils/vm.sol';
import { DSTest } from './utils/test.sol';
import { Constants } from './shared/constants.sol';
import { Errors } from './shared/errors.sol';

/**
 * @title ConstantsAndErrors - Test
 * @dev Verifies the JSON-loading behavior of the `Constants` and `Errors` base
 *      contracts introduced for #19.
 */
contract ConstantsAndErrorsTest is DSTest {
    Vm private constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    string private constant CONSTANTS_PATH = './constants/constants.json';
    string private constant ERRORS_PATH = './constants/errors.json';

    function setUp() public virtual {
        // Ensure the target files do not exist before each test so the
        // "no JSON file present" case is deterministic.
        _removeIfExists(CONSTANTS_PATH);
        _removeIfExists(ERRORS_PATH);
    }

    // -------------------------------------------------------------------
    // Constants contract
    // -------------------------------------------------------------------

    function test_Constants_defaultsAreUsedWhenNoJsonFile() public virtual {
        Constants constantsContract = new Constants();

        assertEq(constantsContract.DEFAULT_MINT_VALUE(), 1);
        assertEq(constantsContract.DEFAULT_BLOCKS_COUNT(), 25);
        assertEq(constantsContract.ADMIN(), address(42_000));
    }

    function test_Constants_loadsFromJsonFile() public virtual {
        // Make sure the constants folder exists by writing the JSON inside it.
        vm.writeFile(
            CONSTANTS_PATH,
            string.concat(
                '{',
                '"DEFAULT_MINT_VALUE": 7,',
                '"DEFAULT_BLOCKS_COUNT": 100,',
                '"ADMIN": "0x0000000000000000000000000000000000000aBc"',
                '}'
            )
        );

        Constants constantsContract = new Constants();

        assertEq(constantsContract.DEFAULT_MINT_VALUE(), 7);
        assertEq(constantsContract.DEFAULT_BLOCKS_COUNT(), 100);
        assertEq(constantsContract.ADMIN(), address(0x0000000000000000000000000000000000000aBc));
    }

    // -------------------------------------------------------------------
    // Errors contract
    // -------------------------------------------------------------------

    function test_Errors_defaultsAreUsedWhenNoJsonFile() public virtual {
        Errors errorsContract = new Errors();

        // Two defaults are always present: REVERT_STATUS_SUCCESS and REVERT_STATUS_SKI_VALIDATION.
        assertEq(errorsContract.getError(0), '[success]');
        assertEq(errorsContract.getError(1), '[skip]');
        assertEq(errorsContract.getErrorCount(), 2);
    }

    function test_Errors_loadsAdditionalFromJsonFile() public virtual {
        vm.writeFile(
            ERRORS_PATH,
            string.concat(
                '{',
                '"errors": [',
                '"ERC20InsufficientBalance",',
                '"OwnableUnauthorizedAccount"',
                ']',
                '}'
            )
        );

        Errors errorsContract = new Errors();

        // Defaults are still present.
        assertEq(errorsContract.getError(0), '[success]');
        assertEq(errorsContract.getError(1), '[skip]');
        // Errors from the JSON file are appended.
        assertEq(errorsContract.getError(2), 'ERC20InsufficientBalance');
        assertEq(errorsContract.getError(3), 'OwnableUnauthorizedAccount');
        assertEq(errorsContract.getErrorCount(), 4);
    }

    // -------------------------------------------------------------------
    // Internal helpers
    // -------------------------------------------------------------------

    function _removeIfExists(string memory path) private {
        // `vm.removeFile` reverts if the file is missing, so guard it with try/catch.
        try vm.fsMetadata(path) returns (Vm.FsMetadata memory metadata) {
            if (!metadata.isDir) {
                vm.removeFile(path);
            }
        } catch {}
    }
}
