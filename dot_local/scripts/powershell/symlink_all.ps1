
# Note: Super user/Admin privileges are required
$links = @{
    'I:\Program Files (x86)\Steam\userdata\287639416\ugc' = 'C:\Program Files (x86)\Steam\userdata\287639416\ugc'
    'I:\Program Files (x86)\Steam\userdata\287639416\ugcmsgcache' = 'C:\Program Files (x86)\Steam\userdata\287639416\ugcmsgcache'
}

# Create a symlink
function ln ([string] $src, [string] $dest) {
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
    if ((exists $src) -and (-not (exists $dest))) {
        # Create all parent directories if they don't exist
        $parent = get_parent_dir $dest
        if (-not(exists $parent)) {
            mkdirs $parent
        }
        # Create symlink
        echo "Symlinking $src -> $dest"
        ln $src $dest
    } elseif (exists $dest) {
        echo "$desc already exists"
    }
}

# Log Paths
function log_paths([string] $src, [string] $dest) {
    echo "Source: ${src}"
    echo "Dest: ${dest}"
    echo ""
}

# Symlink all our desired links
foreach ($link in $links.GetEnumerator()) {
    
    #$src = $link.Item1
    #$dest = $link.Item2
    #($src, $dest) = ($link.Item1, $link.Item2)
    # ($src, $dest) = ($link[0], $link[1])
    #$src = $link.Get(0)
    #$dest = $link.Get(1)

    #Write-Host "$($link.Name) : $($link.Value)"

    $src = $link.Name
    $dest = $link.Value
    #log_paths $link.Name $link.Value

    create_symlink $src $dest
}