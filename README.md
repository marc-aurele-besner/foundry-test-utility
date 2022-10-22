[![license](https://img.shields.io/github/license/jamesisaac/react-native-background-task.svg)](https://opensource.org/licenses/MIT)
[![npm version](https://badge.fury.io/js/foundry-test-utility.svg)](https://badge.fury.io/js/foundry-test-utility)

# foundry-test-utility

```

______                    _                _______        _          _    _ _   _ _ _ _
|  ____|                  | |              |__   __|      | |        | |  | | | (_) (_) |
| |__ ___  _   _ _ __   __| |_ __ _   _ ______| | ___  ___| |_ ______| |  | | |_ _| |_| |_ _   _
|  __/ _ \| | | | '_ \ / _` | '__| | | |______| |/ _ \/ __| __|______| |  | | __| | | | __| | | |
| | | (_) | |_| | | | | (_| | |  | |_| |      | |  __/\__ \ |_       | |__| | |_| | | | |_| |_| |
|_|  \___/ \__,_|_| |_|\__,_|_|   \__, |      |_|\___||___/\__|       \____/ \__|_|_|_|\__|\__, |
                                    __/ |                                                    __/ |
                                    |___/                                                    |___/
```

This package aim to deliver a set of reusable contracts and helper function that can be reused and override in your own [Foundry](https://github.com/foundry-rs) tests.

## To add yo your project

First install the package using NPM, Yarn or Forge Install.

```
npm i foundry-test-utility
```

or

```
yarn add foundry-test-utility
```

or

```
foundry install marc-aurele-besner/foundry-test-utility
```

Then add this package path in remapping.text

For NPM/Yarn

```
foundry-test-utility/contracts/=node_modules/foundry-test-utility/contracts
```

For Forge Install

```
foundry-test-utility/contracts/=libs/foundry-test-utility/contracts

```

## Directories

-   [contracts/](./contracts/)

-   [.npmignore](./.npmignore)
-   [.prettierignore](./.prettierignore)
-   [.prettierrc](./.prettierrc)
-   [awesome-readme.config.js](./awesome-readme.config.js)
-   [CONTRIBUTING.md](./CONTRIBUTING.md)
-   [foundry.toml](./foundry.toml)
-   [LICENSE](./LICENSE)
-   [package-lock.json](./package-lock.json)
-   [package.json](./package.json)
-   [README.md](./README.md)
-   [remappings.txt](./remappings.txt)

## Reference

This repository include helper contracts from:

-   [Forge-std](https://github.com/foundry-rs/forge-std)
-   [DS-Test](https://github.com/dapphub/ds-test)

## Directory Tree

```
foundry-test-utility/
│   .npmignore
│   .prettierignore
│   .prettierrc
│   awesome-readme.config.js
│   CONTRIBUTING.md
│   foundry.toml
│   LICENSE
│   package-lock.json
│   package.json
│   README.md
│   remappings.txt
└─── contracts/
   │   MockERC1155.t.sol
   │   MockERC1155Upgradeable.t.sol
   │   MockERC20.t.sol
   │   MockERC20Upgradeable.t.sol
   │   MockERC721.t.sol
   │   MockERC721Upgradeable.t.sol
   │   README.md
   └─── mock/
   └─── shared/
   └─── utils/
```

## Don't hesitate to contribute to this project.
