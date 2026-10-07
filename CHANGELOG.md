# Changelog

## 1.5.2

- Upgrade the bundled DuckDB to 1.5.5 everywhere. Android and iOS shipped 1.4.4
  while the package named itself `1.5.x`; macOS was further back still, at 1.4.2.
- The DuckDB version now lives in one place, the root `DUCKDB_VERSION` file, and
  is what every Makefile, the macOS podspec and the release workflow build. The
  workflow's `duckdb_version` input previously only keyed the ccache and selected
  nothing.
- Build the iOS framework without patching DuckDB. `ios/changes.patch` modified
  upstream's `src/CMakeLists.txt` to add the `duckdb_framework` target and broke
  on any upstream restructuring; that target now lives in `ios/CMakeLists.txt`,
  which builds the pinned upstream checkout unmodified. Byte-comparable output:
  identical exported-symbol sets to the patched build.
- Build and publish `libduckdb.so` for the `x86_64` Android ABI. Apps that
  packaged an x86_64 variant previously installed with no DuckDB to load and
  failed at open with `dlopen failed: library "libduckdb.so" not found`.

## 1.4.4

- upgrade duckdb binaries to 1.4.2
- introduce the JsonValue for Json columns

## 1.4.3

- Add web folders

## 1.4.1

- Upgrade to DuckDB 1.4.1
- Add JSON column support
- Add web/WASM support for DuckDB
- Update platform-specific build configurations
- Update test suite with new type tests
- Bump Flutter and dependency versions

## 1.3.2

- bump duckdb version

## 1.2.0
- ✨ Added Web support via DuckDB WASM

## 1.1.3
- ✨ Added support for all DuckDB datatypes
- ✨ Added streaming query results
- ⚡️ Improved query performance with faster datachunk indexing
- 🔧 Full Value support for PreparedStatements
- 💡 Enhanced vector and value classes with Dart generics
- 📦 Reduced Android binary size by removing unused symbols

## 1.1.0
- ✨ Added support for cancellable queries via DuckDB's pending results

## 1.0.3
- 📝 Minor documentation updates

## 1.0.2
- 🔧 Auto-download DuckDB builds during build process for Android/Windows/Linux/macOS

## 1.0.1
- 🐛 Fixed pub.dev publishing issues

## 1.0.0
- 🎉 Initial release
