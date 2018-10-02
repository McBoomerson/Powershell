$Users = Get-LocalUser |  Where {($_.Enabled -eq $true) -and ($_.PasswordExpires -ne $null)}  | select Name, PasswordExpires
$Today = Get-Date
 
foreach ($user in $users) {
    $date = [datetime]$user.PasswordExpires
    $Name = $User.Name
    $Expires = New-TimeSpan -Start $today -End $date
    write-host `n "$Name expires in $Expires days" `n
}