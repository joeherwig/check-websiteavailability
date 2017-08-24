cd $PSScriptRoot
$rootpath = $PSScriptRoot
$initscript= [scriptblock]::create(@"
import-module -name "$rootpath\test\lib\log-json.ps1"
"@)

get-job | remove-job -force

clear

$scripts = Get-ChildItem "test\*.ps1" -Exclude "get-IEInstance.ps1"

foreach ($script in $scripts) {
    Start-Job  -InitializationScript $initscript -FilePath $script
}
#Wait for all jobs
Get-Job | Wait-Job -timeout 120
 
#Get all job results
Get-Job | Receive-Job