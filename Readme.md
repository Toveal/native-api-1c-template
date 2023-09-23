<div align="center">

  <h1><code>native-api-1c-template</code></h1>

  <strong>A template for kick starting a Rust project using <a href="https://github.com/tuplecats/rust-native-1c">rust-native-1c (complex)</a> or <a href="https://github.com/Sebekerga/native_api_1c">native_api_1c (simple)</a>.</strong>
</div>

## 📦 Dependencies
### 🐧 Linux
- **Zip**
- <pre><code>rustup target add i686-pc-windows-gnu x86_64-pc-windows-gnu x86_64-unknown-linux-gnu i686-unknown-linux-gnu</code></pre>

### 🖥️ Windows
- <pre><code>rustup target add i686-pc-windows-msvc x86_64-pc-windows-msvc x86_64-unknown-linux-gnu i686-unknown-linux-gnu</code></pre>

### 🌐 Common
- **<a href="https://github.com/sagiegurari/cargo-make">cargo-make</a>**
- **<a href="https://github.com/mitsuhiko/insta">cargo-insta</a>**
- **<a href="https://github.com/cross-rs/cross">cross</a>**
- **<a href="https://www.docker.com/">Docker</a> or <a href="https://podman.io/">Podman</a>**

## 🚴 Usage
### 🐑 Use `cargo generate` to Clone this Template
```
cargo generate --git https://github.com/Toveal/native_api_1c_template
cd my-project
```
###  🧙‍♂️ build
#### For debug builds
```
cargo make pack-debug
```
#### For release builds
```
cargo make pack-release
```

### 🧪 Test
```
cargo make test
```

## 📊 Result
```text
out/
├── {{addin_name}}_x32.dll
├── {{addin_name}}_x64.dll
├── {{addin_name}}_x32.so
├── {{addin_name}}_x64.so
├── Manifest.xml
├── {{addin_name}}.zip
```