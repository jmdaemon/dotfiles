# Storage

## Table of Contents
1. [Hibernation](#hibernation)
2. [Data Sharing](#sharing-data-between-windows-and-linux)
3. [Backups](#backups)
<!--1. [Example](#example)-->
<!--2. [Example2](#example2)-->
<!--3. [Third Example](#third-example)-->
<!--4. [Fourth Example](#fourth-examplehttpwwwfourthexamplecom)-->

## Migrating Data

### Migrating Folders & Files

If migrating using a Linux distribution, you can move your files around using

```bash
rsync -v -a -X -U -N -H 
# -v: Enable verbose information
# -a: Preserve mostly everything (see manpage for unpreserved attributes)
# -X: Preserve Extended Attributes
# -U: Preserve Atimes
# -N: Preserve Crtimes
# -H: Preserve hardlinks
```

If migrating on Windows between drives, you can:
1. Make a zip of the directories, copy and extract onto the new drive.
    This preserves the metadata of the files.

```ps1
# Create a zip file with the contents of C:\Stuff\
Compress-Archive -Path C:\Stuff -DestinationPath archive.zip

# Add more files to the zip file
# (Existing files in the zip file with the same name are replaced)
Compress-Archive -Path C:\OtherStuff\*.txt -Update -DestinationPath archive.zip

# Extract the zip file to C:\Destination\
Expand-Archive -Path archive.zip -DestinationPath C:\Destination
```

See [here](https://stackoverflow.com/questions/1153126/how-to-create-a-zip-archive-with-powershell) for more information.

## Migrating Partitions

If the partitions are still intact and not damaged, then you can just use GParted's
equivalent disk cloning facilities.

These include:
- ntfsclone
- dd

To migrate/recover partitions (that are partially damaged) you can use `ddrescue`:

```bash
sudo ddrescue -f -d /dev/src1 /dev/dest1 "$(date --iso-8601)-rescue.log"
# -f: Force
# -d: Use direct disk access
```

If you specify the log file then you can resume the `ddrescue` (after you Ctrl-C).

## Hibernation

### Windows Hibernation

Windows has a hibernation mode that allows users to resume their sessions without rebooting.

This is equivalent to the `swap` feature of Linux distributions.

Like `swap` Windows hibernation has the potential to wear down the disk faster
as a result of writing the RAM state onto the disk.

Hibernation also imposes a write lock onto the NTFS partition(s), and
hinders drive cloning.

### Linux Swap

Linux has a swap feature to write RAM state onto the disk (this is known as swap space)
available to restore from later on reboot.

This feature wears down the drive used as swap space more often (due to the increased writes).

## Sharing Data Between Windows and Linux

Sharing data between Windows and Linux is tricky. There are a few solutions,
each with their own trade offs.

### Using File Synchronization Software

File synchronization software can be used to clone and synchronize data between devices, or partitions.
This is good for sharing certain files that aren't as costly to clone, but sharing big directories,
or entire disk partitions is extremely costly and not a viable alternative for backups, or sharing
partitions.

File Sync Software:
- Syncthing: P2P, encrypted, secure file synchronization software.

### Using NAS Storage

Pros:
- Single segregated, synchronized storage for your needs.
- Internal implementation details are abstracted away (Can use a variety of different file system solutions).
- Potentially less likely to corrupt than sharing a partition between Windows and Linux

Cons:
- Insecurity: Samba has had various vulnerabilities over the years, making it another potential
    attack vector for malicious users.
- Reliability: Samba isn't perfect, and you may potentially run into data corruption issues.
- Expensive: Requires an external server to host the Samba share and communicate
    with Samba clients. An additional computer and external chassis for storage is also required.

#### Samba

Samba is a protocol to mount network attached drives. These drives are then available seamlessly
like any other partition on your system.

##### Setup Server

TODO

##### Setup Client

TODO

### Using a Single Partition

There is no file system that can easily share data easily between a Windows/Linux dual boot, apart
for FAT32. However FAT16/32 is missing key quality of life features native to modern file systems and also limited to 4GiB of storage.

Using modern file systems is also tricky.
Using either `ext4` from Windows is unreliable and prone to data corruption on writes.
Using `ntfs` from Linux is prone to potential corruptions as well.

If data reliability is important, and you still want to share data using a single partition,
then the shared file system should be read only.

#### NTFS

`NTFS` support is generally good on Linux, and you may be able to
get away with using `ntfs-3g`. However keep in mind that
`NTFS` is a closed source, proprietary file system developed by Microsoft. Issues may occur
and your mileage may vary.

#### Ext4

There are next to no available solutions for both reading from/writing to an `EXT4` partition from
Windows.

#### ZFS

ZFS support is currently experimental. ZFS is tricky to set up properly, and may make
it potentially difficult to remove or migrate to other file systems in case your requirements change.

## Backups

### Borg Backup

### Rsync and Rclone

### Windows Backup

