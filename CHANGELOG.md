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
