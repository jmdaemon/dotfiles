
# Note: Super user/Admin privileges are required

# Helper function to make tuples
function tuple([string] $item1, [string] $item2) {
    return [Tuple]::Create($item1, $item2)
}

#$links = New-Object 'Collections.Generic.List[Tuple[string,string]]'

#$links = @(
    # $src, $dest
#$links.Add([Tuple]::Create('I:\Program Files (x86)\Steam\userdata\287639416\ugc','C:\Program Files (x86)\Steam\userdata\287639416\ugc'))
#$links.Add((tuple('I:\Program Files (x86)\Steam\userdata\287639416\ugmsgcache',
#'C:\Program Files (x86)\Steam\userdata\287639416\ugmsgcache')))
#)

$links = @(
    @('I:\Program Files (x86)\Steam\userdata\287639416\ugc', 'C:\Program Files (x86)\Steam\userdata\287639416\ugc')
    , @('I:\Program Files (x86)\Steam\userdata\287639416\ugmsgcache', 'C:\Program Files (x86)\Steam\userdata\287639416\ugmsgcache')
)
#$links.Add((tuple('I:\Program Files (x86)\Steam\userdata\287639416\ugmsgcache',
#'C:\Program Files (x86)\Steam\userdata\287639416\ugmsgcache')))


# Create a symlink
function ln ([string]$src, [string]$dest) {
    New-Item -Path $dest -ItemType SymbolicLink -Value $src
}

# Check if a path exists
function exists([string]$path) {
    return Test-Path -Path $path
}

# Get parent directory of a path
function get_parent_dir([string]$path) {
    return (get-item $path).parent
}

# Create a directory with all its subdirectories
function mkdirs([string]$path) {
    mkdir -p $path
}

# Creates the symlink if $src exists and $dest does not
function create_symlink([string] $src, $dest) {
    if (exists($src) AND not exists($dest)) {
        # Create all parent directories if they don't exist
        $parent = get_parent_dir($dest)
        if (-not(exists($parent))) {
            mkdirs($parent)
        }
        # Create symlink
        echo "Symlinking $src -> $dest"
        ln($src, $dest)
    } elif (exists($desc)) {
        echo "$desc already exists"
    }
}

# Log Paths
function log_paths([string] $src, [string]$dest) {
    echo "Source: $src"
    echo "Dest: $dest"
    echo ""
}

# Symlink all our desired links
foreach ($link in $links) {
    
    #$src = $link.Item1
    #$dest = $link.Item2
    #($src, $dest) = ($link.Item1, $link.Item2)
    # ($src, $dest) = ($link[0], $link[1])
    $src = $link.Get(0)
    $dest = $link.Get(1)
    log_paths($src, $dest)
    create_symlink($src, $dest)
}