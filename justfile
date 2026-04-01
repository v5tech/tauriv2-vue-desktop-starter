# Tauri v2 Desktop Starter — task runner
# Usage: just <recipe>  |  just --list

set dotenv-load := false

# Rust project directory
rust_dir := "src-tauri"

# List available recipes
default:
    @just --list

# Start Tauri dev server with hot reload
dev:
    pnpm tauri dev

# Build the app for production
build:
    pnpm tauri build

# Build with debug profile
build-debug:
    pnpm tauri build --debug

# Remove node_modules, dist, and Rust target artifacts
clean:
    pnpm run clean


# Lint Vue (ESLint) and Rust (clippy)
lint: lint-vue lint-rust

# Lint Vue/TS source with ESLint
lint-vue:
    pnpm lint

# Lint Rust source with clippy
lint-rust:
    cd {{rust_dir}} && cargo clippy --all-targets --all-features


# Format Vue (ESLint fix) and Rust (fmt + clippy fix)
format: format-vue format-rust

# Format Vue/TS source via ESLint auto-fix
format-vue:
    pnpm lint:fix

# Format Rust source (rustfmt + clippy auto-fix)
format-rust:
    cd {{rust_dir}} && cargo fmt --all
    cd {{rust_dir}} && cargo clippy --all-targets --all-features --fix --allow-dirty --allow-staged


# Run Vue and Rust test suites
test: test-vue test-rust

# Run Vue/TS tests via vitest
test-vue:
    pnpm test

# Run Rust tests via cargo-nextest and doc tests
test-rust:
    cd {{rust_dir}} && cargo nextest run --all-targets --all-features
    cd {{rust_dir}} && cargo test --doc


# Run TypeScript type checking
typecheck:
    pnpm typecheck
