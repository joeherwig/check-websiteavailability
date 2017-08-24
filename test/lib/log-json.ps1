Function log-json
    {
        param
        (
            [string]$Group,
            [string]$Message,
            [string]$MessageType,
			[string]$LogPath
        )
    $Time_Stamp = ($Time_Stamp = Get-Date).Datetime
  
	$NewLogData  = @{"Group" = $Group; "Message" = $Message; "MessageType" = $MessageType}
    
	#Open Existing Log File to Get current data
	$CurrentLog = Get-Content -Path $LogPath -Raw | ConvertFrom-Json
 
	#If the log file is empty, CurrentLog cannot have a method called as it's 'Null Valued'.
	#Test for Null Value, if true, create CurrentLog as an Object 
    If($CurrentLog -eq $Null)
    {
        $CurrentLog = New-Object -TypeName PSObject
    }	
	
	#Group is used as the top level key value. Should be a unique identifier
	#The value for this key is the data provided into the function when called
    $CurrentLog | Add-Member -Type NoteProperty -Name $Time_stamp -Value $NewLogData
 
    $CurrentLog | ConvertTo-Json | Out-File $LogPath
}
