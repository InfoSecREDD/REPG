# REPG (REDD's Encrypted Payload Generator)
This is a simple project aimed at making other people's PowerShell script be easily converted
for everyone to use. - While throwing a bit of Base64 and certutil commands in there to give 
others more ideas on what can and could be possible.

## Instructions
- Download the [latest release](https://github.com/InfoSecREDD/REPG/releases) of this Repo.
- Unzip the file into the folder of choice.
- Place desired Powershell file(s) in the same folder. 
- Use the syntax for the device and PowerShell script you want.
- Transfer "payload.txt" to BadUSB/DuckyScript Device of your choice.
- Run the payload.txt.
- Enjoy!

# Syntax
## For OMG/Hak5/Other OFFICIAL DuckyScript devices*:

```PS> .\encode.ps1 helloworld.ps1```

  OR

Drag and Drop ``helloworld.ps1`` onto ``DragNDropHERE-Hak5.cmd``.

## For Flipper Zero/BadUSB devices*:

```PS> .\encode.ps1 helloworld.ps1 -flipper```

  OR

Drag and Drop ``helloworld.ps1`` onto ``DragNDropHERE-Flipper.cmd``.


Notice:  * = This is just a example syntax using the provided "helloworld.ps1" in this repo.


## Possible Errors
- Common Error 1

You may run into Windows 11 Machines and rare cases Windows 10 Machines that give "File cannot
be loaded because running scripts is disabled on this system.".
- Solution

You can run the "[allowps.txt](https://raw.githubusercontent.com/InfoSecREDD/REPG/main/allowps.txt)" BadUSB/Duckyscript provided in the repo to automatically do it for
you, or you can run the command ``Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser``
in a PowerShell Terminal. 
