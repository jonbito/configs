# Update Changelog

Add entry to CHANGELOG.md: $ARGUMENTS

## Process

1. Parse arguments: `version`
2. Check if CHANGELOG.md exists, create if needed
3. Read all git commits since the last release tag for determining change types
4. Format according to Keep a Changelog conventions

## Change Types

- **Added**: for new features
- **Changed**: for changes in existing functionality
- Deprecated: for soon-to-be removed features
- **Fixed**: for bug fixes
- **Removed**: for removed features
- **Security**: for security improvements

## Format Example

```
## [1.1.0] - 2024-01-15

### Added

- New authentication system

### Fixed

- Login button styling issue
```

## Usage

```bash
# Example: /github:do:changelog "1.2.0"
# Will add "## [1.2.0] - {current_date}" and all changes scanned from git
```
