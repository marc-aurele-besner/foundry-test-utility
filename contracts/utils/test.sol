// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

pragma experimental ABIEncoderV2;

// 💬 ABOUT
// Standard Library's default Test

// 🧩 MODULES
import { console } from './console.sol';
import { console2 } from './console2.sol';
import { StdAssertions } from './stdAssertions.sol';
import { StdChains } from './stdChains.sol';
import { StdCheats } from './stdCheats.sol';
import { stdError } from './stdError.sol';
import { StdInvariant } from './stdInvariant.sol';
import { stdJson } from './stdJson.sol';
import { stdMath } from './stdMath.sol';
import { StdStorage, stdStorage } from './stdStorage.sol';
import { StdUtils } from './stdUtils.sol';
import { Vm } from './vm.sol';
import { StdStyle } from './stdStyle.sol';

// 📦 BOILERPLATE
import { TestBase } from './base.sol';
import { DSTest } from './ds-test.sol';

// ⭐️ TEST
abstract contract Test is DSTest, StdAssertions, StdChains, StdCheats, StdInvariant, StdUtils, TestBase {
    // Note: IS_TEST() must return true.
    // Note: Must have failure system, https://github.com/dapphub/ds-test/blob/cd98eff28324bfac652e63a239a60632a761790b/src/test.sol#L39-L76.
}
