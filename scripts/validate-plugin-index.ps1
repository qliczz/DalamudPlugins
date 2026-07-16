param(
    [string]$IndexPath = (Join-Path $PSScriptRoot '..\pluginmaster.json')
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$plugins = @(Get-Content -Raw -Encoding utf8 $IndexPath | ConvertFrom-Json)
# Windows PowerShell 5.1 may wrap a top-level JSON array in one additional Object[].
if ($plugins.Count -eq 1 -and $plugins[0] -is [Array]) {
    $plugins = $plugins[0]
}
if ($plugins.Count -eq 0) {
    throw 'pluginmaster.json contains no plugins.'
}

$duplicates = $plugins | Group-Object InternalName | Where-Object Count -gt 1
if ($duplicates) {
    throw "Duplicate InternalName values: $($duplicates.Name -join ', ')"
}

$tempRoot = Join-Path ([IO.Path]::GetTempPath()) "dalamud-index-$([Guid]::NewGuid().ToString('N'))"
New-Item -ItemType Directory -Path $tempRoot | Out-Null

try {
    foreach ($plugin in $plugins) {
        foreach ($field in 'InternalName', 'AssemblyVersion', 'DownloadLinkInstall', 'DownloadLinkUpdate') {
            if ([string]::IsNullOrWhiteSpace([string]$plugin.$field)) {
                throw "$($plugin.InternalName): missing $field"
            }
        }

        $zipPath = Join-Path $tempRoot "$($plugin.InternalName).zip"
        Invoke-WebRequest -Uri $plugin.DownloadLinkInstall -OutFile $zipPath

        $zip = [IO.Compression.ZipFile]::OpenRead($zipPath)
        try {
            $nested = @($zip.Entries | Where-Object FullName -Match '[/\\]')
            if ($nested.Count -gt 0) {
                throw "$($plugin.InternalName): release ZIP contains nested paths."
            }

            $manifestName = "$($plugin.InternalName).json"
            $manifest = $zip.Entries | Where-Object FullName -EQ $manifestName | Select-Object -First 1
            if (-not $manifest) {
                throw "$($plugin.InternalName): $manifestName is missing from the release ZIP."
            }

            $reader = [IO.StreamReader]::new($manifest.Open())
            try {
                $manifestJson = $reader.ReadToEnd() | ConvertFrom-Json
            }
            finally {
                $reader.Dispose()
            }

            if ($manifestJson.AssemblyVersion -ne $plugin.AssemblyVersion) {
                throw "$($plugin.InternalName): index version $($plugin.AssemblyVersion) does not match ZIP version $($manifestJson.AssemblyVersion)."
            }
        }
        finally {
            $zip.Dispose()
        }

        Write-Host "Validated $($plugin.InternalName) $($plugin.AssemblyVersion)"
    }
}
finally {
    Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
}
