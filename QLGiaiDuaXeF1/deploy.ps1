param(
    [Parameter(Mandatory = $true)]
    [string]$TomcatHome
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$source = Join-Path $root "webapp"
$target = Join-Path $TomcatHome "webapps\QLGiaiDuaXeF1"

if (-not (Test-Path -LiteralPath $source)) {
    throw "webapp folder not found."
}

& (Join-Path $root "build.ps1")

if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
}

Copy-Item -LiteralPath $source -Destination $target -Recurse
Write-Host "Deployed to $target"
