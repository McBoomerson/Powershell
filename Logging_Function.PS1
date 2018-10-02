#Logging function Script Variables
$Logfile = "D:\AuthReplay\Logs\CopyAuthFile.log"
$LogRolldays = 30
$FileDate = (Get-ChildItem $Logfile).Creationtime
$Path = Split-Path -Path $Logfile

#Logging function
Function LogWrite
{
   Param([string]$logstring)

   $Date = Get-date -UFormat %m/%d/%y
   $Time = Get-date -UFormat %T
   Write-host $logstring
   Add-content $Logfile -value "[$Date $Time] $logstring"
}

#Log file rollover
$timespan = new-timespan -days $LogRolldays
if (((get-date) - $FileDate) -gt $timespan) {
    $Date = Get-Date $FileDate -Format 'yyyy-MM-dd'
	$OldLog = "$Path\"+$Date+"_"+"CopyAuthFile.log"
	Rename-Item -Path "$Logfile" -NewName $OldLog
    LogWrite "Log file was greater than $LogRolldays days old, renaming and writing new log."
} else {
    LogWrite "Log file is less than $LogRolldays days old, appending to it."
	LogWrite "Begin auth file splitting:"
}