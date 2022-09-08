# Changelog

This library follows semantic versioning 2.0.0:

```
Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when you make incompatible API changes,
2. MINOR version when you add functionality in a backwards compatible manner, and
3. PATCH version when you make backwards compatible bug fixes.
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.
```

See https://semver.org/ for more information

## 0.9.0 (09/07/2022)

### Features
- `Contract#teal_source` method for generating TEAL source code that uses whitespace for increased readability
- Refactor of `Txna` and app arrays (ie. `Assets[0].creator?`)
- Removed dot key notation support for `Scratch`
- Inline `if` support

## 0.8.0 (07/30/2022)

### Features
- Adding automatic ABI method routing

## 0.7.0 (07/26/2022)

### Features
- Added `_exists?` and `_value` methods for dealing with opcodes that return two values
- Support dot notation for named `@scratch` slots

### Bugfixes
- Improved rewriter code to improve transpilation detection and reduce transpiling errors

### Other
- Removed multi-threaded support to simplify codebase


## 0.6.0 (05/26/2022)

### Features
- removed parameters from Txna method calls
- `rb` method for skipping literal transpilation
- while loop support

## 0.5.0 (05/22/2022)

### Features
- Named scratch slots

### Bugfixes
- Fixed Txna.application_args call in AppArgs.[]

## 0.4.0 (05/16/2022)

### Features
- Proper Txna functionality

## 0.3.1 (05/10/2022)

### Bugfixes
- Fix improper if id counting

## 0.3.0 (05/10/2022)

### Features
- Txna[] functionality

### Bugfixes 
- Made if block id/count thread-safe

## 0.2.0 (05/10/2022)

### Features
- support for automatic comment rewriting

### Bugfixes
- remove quotes from enums (ie. `int 'pay'`)
- ensure all subroutine methods are defined prior to generating the TEAL

## 0.1.0 (05/09/2022)
- 100% opcode coverage
- subroutine definition
- conditional support (if/elsif/else)
- ABI JSON generation
