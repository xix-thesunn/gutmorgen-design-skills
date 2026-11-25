$ErrorActionPreference = 'Stop'

$version = 'v0.0.27'
$sha256 = '3c79eace45ed9934a0a9ac5e607968200541b90536bcdaaa4aae0210a494c789'
$documents = [Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments)
if ([string]::IsNullOrWhiteSpace($documents)) {
    throw 'Windows could not resolve the Documents folder.'
}

$bridgeRoot = Join-Path $documents 'Figma MCP Bridge'
$destination = Join-Path $bridgeRoot $version
$manifest = Join-Path $destination 'manifest.json'

if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
    if (Test-Path -LiteralPath $destination) {
        throw "The destination exists without a manifest: $destination"
    }

    New-Item -ItemType Directory -Path $bridgeRoot -Force | Out-Null
    $staging = Join-Path $bridgeRoot ('.staging-' + [Guid]::NewGuid())
    New-Item -ItemType Directory -Path $staging | Out-Null
    try {
        $archive = Join-Path $staging 'bridge.zip'
        $url = "https://github.com/gethopp/figma-mcp-bridge/releases/download/$version/figma-mcp-bridge-$version.zip"
        Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $archive
        if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ne $sha256) {
            throw "Checksum mismatch for Figma MCP Bridge $version."
        }

        $extracted = Join-Path $staging 'extracted'
        Expand-Archive -LiteralPath $archive -DestinationPath $extracted
        $manifests = @(Get-ChildItem -LiteralPath $extracted -Recurse -File -Filter 'manifest.json')
        if ($manifests.Count -ne 1) {
            throw 'Expected exactly one Figma plugin manifest in the release archive.'
        }

        [IO.Directory]::Move($manifests[0].Directory.FullName, $destination)
    } finally {
        Remove-Item -LiteralPath $staging -Recurse -Force
    }
}

Write-Output $manifest
