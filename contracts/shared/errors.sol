// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import { Vm } from '../utils/vm.sol';
import { DSTest } from '../utils/test.sol';

contract Errors is DSTest {
    Vm public constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    string constant public REVERT_STATUS_SUCCESS = '[success]';
    string constant public REVERT_STATUS_SKI_VALIDATION = '[skip]';

    string[] internal _errors;

    // Associate your error with a mapping
    constructor() {
        _errors.push(REVERT_STATUS_SUCCESS);
        _errors.push(REVERT_STATUS_SKI_VALIDATION);
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
    * @dev Validate string match a other string (A==B)
    * @param strA - String A
    * @param strB - String B
    */
    function _validateString(string calldata strA, string memory strB) internal pure virtual returns (bool) {
        return keccak256(abi.encodePacked(strA)) == keccak256(abi.encodePacked(strB));
    }
}
