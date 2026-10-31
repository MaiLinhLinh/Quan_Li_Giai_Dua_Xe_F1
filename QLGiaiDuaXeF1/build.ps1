$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$src = Join-Path $root "src"
$webapp = Join-Path $root "webapp"
$classes = Join-Path $webapp "WEB-INF\classes"
$lib = Join-Path $webapp "WEB-INF\lib"

if (-not (Get-Command javac -ErrorAction SilentlyContinue)) {
    throw "javac not found. Install JDK 17 and add its bin folder to PATH."
}

New-Item -ItemType Directory -Force -Path $classes | Out-Null

$jars = @(Get-ChildItem -Path $lib -Filter *.jar -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName })
$classpath = $jars -join ";"

$javaFiles = @(Get-ChildItem -Path $src -Recurse -Filter *.java | ForEach-Object { $_.FullName })
if ($javaFiles.Count -eq 0) {
    throw "No .java files found in src."
}

& javac -encoding UTF-8 -cp $classpath -d $classes $javaFiles
if ($LASTEXITCODE -ne 0) {
    throw "Java compilation failed."
}

Copy-Item -Path (Join-Path $src "db.properties") -Destination (Join-Path $classes "db.properties") -Force

Write-Host "Build OK."
Write-Host "Classes: $classes"
Write-Host "Next: copy the webapp folder into Tomcat/webapps as QLGiaiDuaXeF1 and start Tomcat."
