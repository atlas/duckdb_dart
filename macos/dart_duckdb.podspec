#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint duckdb.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dart_duckdb'
  s.version          = File.read(File.join('..', 'pubspec.yaml')).match(/version:\s+(\d+\.\d+\.\d+)/)[1]
  duckdb_version     = File.read(File.join('..', 'DUCKDB_VERSION')).strip
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
    A new flutter plugin project.
  DESC
  s.homepage         = 'https://github.com/TheAtlasRepository/duckdb_dart'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'TheAtlasRepository' => 'atlas@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.13'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'

  s.vendored_libraries = 'Libraries/release/libduckdb.dylib'

  # Use a pre-install hook to check if the library exists
  s.prepare_command = <<-CMD
    mkdir -p Libraries/release  # Ensure the directory exists
    if [ ! -f "Libraries/release/libduckdb.dylib" ]; then
      echo "Downloading DuckDB library..."
      curl -L -o libduckdb-osx-universal.zip "https://github.com/duckdb/duckdb/releases/download/#{duckdb_version}/libduckdb-osx-universal.zip"
      unzip -o libduckdb-osx-universal.zip -d Libraries/release/
      rm libduckdb-osx-universal.zip
    else
      echo "DuckDB library already exists."
    fi
  CMD
end
