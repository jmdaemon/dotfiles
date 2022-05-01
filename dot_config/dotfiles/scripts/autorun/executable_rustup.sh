#!/bin/bash

# Update rust
rustup update
notify-send "Rust Update" "All rust toolchains have been updated."

# Update cargo packages
cargo install-update -a
notify-send "Cargo Update" "All cargo packages have been updated."
