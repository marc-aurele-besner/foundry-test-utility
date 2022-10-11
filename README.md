[![license](https://img.shields.io/github/license/jamesisaac/react-native-background-task.svg)](https://opensource.org/licenses/MIT)
[![npm version](https://badge.fury.io/js/foundry-test-utility.svg)](https://badge.fury.io/js/foundry-test-utility)

# Foundry-Test-Utility

This package aim to deliver a set of reusable contracts and helper function that can be reused and override in your own Foundry tests.

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
