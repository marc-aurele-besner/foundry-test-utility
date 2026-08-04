// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import { Vm } from '../utils/vm.sol';
import { stdJson } from '../utils/stdJson.sol';

contract Constants {
    // Constants value specific to the contracts we are testing.

    string internal constant CONSTANTS_FOLDER = './constants/';
    string internal constant CONSTANTS_FILE = 'constants.json';

    using stdJson for string;

    Vm private constant vm = Vm(address(uint160(uint256(keccak256('hevm cheat code')))));

    uint256 public DEFAULT_MINT_VALUE;
    uint256 public DEFAULT_BLOCKS_COUNT;

    address public ADMIN;

    constructor() {
        // Set the default values for the contracts we are testing.
        DEFAULT_MINT_VALUE = 1;
        DEFAULT_BLOCKS_COUNT = 25;
        ADMIN = address(42_000);

        // Override defaults from ./constants/constants.json when the file is present.
        // `vm.readFile` can return an empty string for a missing file (rather than
        // reverting), so we first check `vm.fsMetadata` (which reverts on missing
        // paths) and only attempt to parse the JSON when the file actually exists.
        string memory constantsFilePath = string.concat(CONSTANTS_FOLDER, CONSTANTS_FILE);
        try vm.fsMetadata(constantsFilePath) returns (Vm.FsMetadata memory metadata) {
            if (!metadata.isDir && metadata.length > 0) {
                string memory json = vm.readFile(constantsFilePath);

                DEFAULT_MINT_VALUE = json.readUint('.DEFAULT_MINT_VALUE');
                DEFAULT_BLOCKS_COUNT = json.readUint('.DEFAULT_BLOCKS_COUNT');
                ADMIN = json.readAddress('.ADMIN');
            }
        } catch {}
    }
}
