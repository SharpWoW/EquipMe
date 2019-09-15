if ((Test-Path out)) {
  Remove-Item -Recurse -Force out
}

Copy-Item -Path src -Destination out -Filter *.lua -Recurse -Container -Force

if (!(Test-Path out)) {
  New-Item -ItemType Directory -Path out -Force
}

Push-Location src

(Get-ChildItem -Filter *.moon -Recurse | Resolve-Path -Relative) -replace "^\.\\", "" | ForEach-Object {
  & moonc -t ..\out "$_"
}

Pop-Location
