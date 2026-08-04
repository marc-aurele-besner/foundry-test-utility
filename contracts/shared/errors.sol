// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import { Vm } from '../utils/vm.sol';
import { DSTest } from '../utils/test.sol';
import { stdJson } from '../utils/stdJson.sol';

contract Errors is DSTest {
    string internal constant ERRORS_FOLDER = './constants/';
    string internal constant ERRORS_FILE = 'errors.json';

    using stdJson for string;

    Vm public constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    string public constant REVERT_STATUS_SUCCESS = '[success]';
    string public constant REVERT_STATUS_SKI_VALIDATION = '[skip]';

    string[] internal _errors;

    // Associate your error with a mapping
    constructor() {
        _errors.push(REVERT_STATUS_SUCCESS);
        _errors.push(REVERT_STATUS_SKI_VALIDATION);

        // Load additional errors from ./constants/errors.json when the file is present.
        // `vm.readFile` can return an empty string for a missing file (rather than
        // reverting), so we first check `vm.fsMetadata` (which reverts on missing
        // paths) and only attempt to parse the JSON when the file actually exists.
        string memory errorsFilePath = string.concat(ERRORS_FOLDER, ERRORS_FILE);
        try vm.fsMetadata(errorsFilePath) returns (Vm.FsMetadata memory metadata) {
            if (!metadata.isDir && metadata.length > 0) {
                string memory json = vm.readFile(errorsFilePath);

                string[] memory extraErrors = json.readStringArray('.errors');
                for (uint256 i = 0; i < extraErrors.length; i++) {
                    _errors.push(extraErrors[i]);
                }
            }
        } catch {}
    }

    // Expect a revert error if the revert type is not success or skip.
    function verify_revertCall(string calldata revertType_) public virtual {
        for (uint256 i = 0; i < _errors.length; i++) {
            if (_validateString(revertType_, _errors[i])) {
                if (!_validateString(revertType_, REVERT_STATUS_SUCCESS) && !_validateString(revertType_, REVERT_STATUS_SKI_VALIDATION))
                    vm.expectRevert(bytes(revertType_));
            }
        }
    }

    /**
     * @dev Returns the number of registered error messages. Useful for
     *      tests and external inspection.
     */
    function getErrorCount() public view virtual returns (uint256) {
        return _errors.length;
    }

    /**
     * @dev Returns the error message at the given index. Useful for tests
     *      and external inspection.
     */
    function getError(uint256 index_) public view virtual returns (string memory) {
        return _errors[index_];
    }

    /**
     * @dev Validate string match a other string (A==B)
     * @param strA - String A
     * @param strB - String B
     */
    function _validateString(string calldata strA, string memory strB) internal pure virtual returns (bool) {
        return keccak256(abi.encodePacked(strA)) == keccak256(abi.encodePacked(strB));
    }
}
