# Creates all symlinks defined in $links

# Note: Super user/Admin privileges are required

# You can define symlinks two ways:
# 1. Directly with
#$links = @{
#    '[src]' = '[dest]'
#}
# 2. Adding an entry to the `symlinks.csv` file in $SYMLINKS_APTH
# Note: The csv delimeter is '|'
# Src|Dest
# [src]|[dest]

$SYMLINKS_PATH = "symlinks.csv"

# Parse the symlinks csv file into a powershell hashtable
function create_links_hashtable([string] $path) {
    $symlinks_csv = Import-Csv -Path $SYMLINKS_PATH -Delimiter "|"
    $links = @{}
    foreach($record in $symlinks_csv) {
        $links[$record.Src] = $record.Dest
    }
    return $links
}

# Create a symlink
function ln([string] $src, [string] $dest) {
    New-Item -Path $dest -ItemType SymbolicLink -Value $src
}

# Check if a path exists
function exists([string] $path) {
    return Test-Path -Path $path
}

# Get parent directory of a path
function get_parent_dir([string] $path) {
    return (get-item $path).parent
}

# Create a directory with all its subdirectories
function mkdirs([string] $path) {
    mkdir -p $path
}

# Creates the symlink if $src exists and $dest does not
function create_symlink([string] $src, $dest) {
    # Makes $src directory if it does not already exist
    if (-not(exists $src)) {
        mkdirs $src
    }

    if (-not (exists $dest)) {
        # Create all parent directories if they don't exist
        $parent = get_parent_dir $dest
        if (-not(exists $parent)) {
            mkdirs $parent
        }
        # Symlink directories
        echo "Symlinking $src -> $dest"
        ln $src $dest
    } elseif (exists $dest) {
        echo "$dest already exists"
    }
}

# Main

# Import our symlinks data
$links = create_links_hashtable $SYMLINKS_PATH

# Symlink all our desired links
foreach ($link in $links.GetEnumerator()) {
    $src = $link.Name
    $dest = $link.Value
    create_symlink $src $dest
}