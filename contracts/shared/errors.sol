// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Vm } from '../utils/vm.sol';
import { DSTest } from '../utils/test.sol';

contract Errors is DSTest {
    Vm public constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    mapping(uint16 => string) internal _errors;

    // Add a revert error to the enum of errors.
    enum BasicRevertStatus {
        Success,
        SkipValidation
    }

    // Associate your error with a revert message and add it to the mapping.
    constructor() {
        // _errors[RevertStatus.ErrorExample] = 'Error: Error Message';
    }

    // Return the error message associated with the error.
    function _verify_revertCall(uint16 revertType_) internal view virtual returns (string storage) {
        return _errors[revertType_];
    }

    // Expect a revert error if the revert type is not success.
    function verify_revertCall(uint16 revertType_) public virtual {
        if (revertType_ > 1) vm.expectRevert(bytes(_verify_revertCall(revertType_)));
    }
}
