// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

// 💬 ABOUT
// Standard Library's default Script.

// 🧩 MODULES
import { ScriptBase } from './base.sol';
import { console } from './console.sol';
import { console2 } from './console2.sol';
import { StdChains } from './stdChains.sol';
import { StdCheatsSafe } from './stdCheats.sol';
import { stdJson } from './stdJson.sol';
import { stdMath } from './stdMath.sol';
import { StdStorage, stdStorageSafe } from './stdStorage.sol';
import { StdUtils } from './stdUtils.sol';
import { VmSafe } from './vm.sol';

// 📦 BOILERPLATE
import { ScriptBase } from './base.sol';

// ⭐️ SCRIPT
abstract contract Script is StdChains, StdCheatsSafe, StdUtils, ScriptBase {
    // Note: IS_SCRIPT() must return true.
    bool public IS_SCRIPT = true;
}
