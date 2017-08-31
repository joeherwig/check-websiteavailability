Function log-json
    {
        param
        (
            [string]$MessageType,
            [string]$Message,
			[string]$LogPath
        )
    $Time_Stamp = ($Time_Stamp = Get-Date).Datetime

	$NewLogData  = [pscustomobject]@{"DateTime" = $Time_Stamp; "Message" = $Message; "MessageType" = $MessageType}

  if (-Not (Test-Path $LogPath)) {new-item $LogPath}
	$CurrentLog = Get-Content -Path $LogPath -Raw | ConvertFrom-Json

	#If the log file is empty, CurrentLog cannot have a method called as it's 'Null Valued'.
	#Test for Null Value, if true, create CurrentLog as an Object
    If($CurrentLog -eq $Null)
    {
      write-host "CurrentLog equals NULL"
        # $CurrentLog = New-Object -TypeName PSObject
        $CurrentLog = @()
        $CurrentLog += [pscustomobject]@{"DateTime" = $Time_Stamp; "Message" = "Logfile created"; "MessageType" = ""}

    }
  $CurrentLog += [pscustomobject]@{"DateTime" = $Time_Stamp; "Message" = $Message; "MessageType" = $MessageType}
  $CurrentLog | ConvertTo-Json | Out-File $LogPath
}
