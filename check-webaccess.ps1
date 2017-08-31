cd $PSScriptRoot
$rootpath = $PSScriptRoot
$env:logFile = join-path $PSScriptRoot "\log\website-check-results.json"

$initscript= [scriptblock]::create(@"
import-module -name "$rootpath\websites\lib\log-json.ps1"
"@)

get-job | remove-job -force

clear

$scripts = Get-ChildItem "websites\*.ps1"

foreach ($script in $scripts) {
    Start-Job  -InitializationScript $initscript -FilePath $script
}
#Wait for all jobs
Get-Job | Wait-Job -timeout 120

#Get all job results
Get-Job | Receive-Job
