# GParted

## How to enable Networking

### Eth0

1. Double click on Network Config
2. Wait for it to finish.

## How to enable more repositories

1. sudo vi /etc/apt/sources.list
2. Add repository line:

```txt
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free
```

### Useful Packages

- `ddrutility`: Utilities for working with `ddrescue`
    - Provides `ddru_ntfs_findbad` and `ddru_findbad` which allows you to find affected files from the bad sectors/blocks.
