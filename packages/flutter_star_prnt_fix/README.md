# Flutter Star Prnt Fix

This package is a local copy of `flutter_star_prnt` version 2.4.1.

## Reason for Fork
The official package (and forks) contain a compilation error with newer Flutter SDKs (3.10+ / 3.27+):
`Error: No named parameter with the name 'size'.` in `ViewConfiguration`.

## Changes Applied
- Modified `lib/src/print_commands.dart`: Removed `size` parameter from `ViewConfiguration` constructor.

## Usage
This package is used via `dependency_overrides` in `apps/pos/pubspec.yaml`.
