# foundry-test-utility / constants

The `Contracts/Errors` base contracts in [`../contracts/shared/`](../contracts/shared/) load
their values from JSON files in this folder when those files are present:

- [`constants.json`](./constants.json) (optional) — overrides the defaults of
  `Constants.DEFAULT_MINT_VALUE`, `Constants.DEFAULT_BLOCKS_COUNT`, and
  `Constants.ADMIN`.
- [`errors.json`](./errors.json) (optional) — appends extra entries to the
  `Errors._errors` array used by `Errors.verify_revertCall`.

## Format

The repository ships with `constants.example.json` and `errors.example.json` to
document the expected shape. Copy either example to the matching file name to
opt-in:

```bash
cp constants.example.json constants.json
cp errors.example.json   errors.json
```

The `Constants` and `Errors` constructors check for these files (using
`vm.fsMetadata` and the Foundry `fs_permissions` setting in `foundry.toml`); if
a file is missing, the hard-coded defaults are used and the test suite keeps
running. This makes the feature opt-in without breaking projects that have not
created the folder.
