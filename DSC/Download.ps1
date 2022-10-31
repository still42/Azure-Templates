param (
    [Parameter(Mandatory)]
    [string]$isouri,
	[Parameter(Mandatory)]
    [string]$isopath,

    [Parameter(Mandatory)]
    [string]$installeruri,
	[Parameter(Mandatory)]
    [string]$installerpath
)

function Download-File
{
    Param
    (
        [string]
        $uri,
        [string]
        $path
    )
    Begin
    {
        Import-Module BitsTransfer
        $logfilePath = "C:\Download.log"

        $filename = [System.IO.Path]::GetFileName($uri)

        if(Test-Path $path) {
            (Get-Date -Format "HH:mm:ss ") + "Destination path exists. Skipping File download" | Tee-Object -FilePath $logFilePath -Append
            return
        }
        else {
            (Get-Date -Format "HH:mm:ss ") + "Created new directory: $path" | Tee-Object $logfilePath -Append
            New-Item -Path $path -ItemType Directory
        }

    }
    Process
    {
        try {
            Start-BitsTransfer -Source $uri -Destination $path
        } catch [Exception] {
            "Failed to download file: $uri Exception: $_" | Tee-Object -FilePath $logFilePath -Append
        }
    }
    End
    {
    }
}

Download-File -uri $isouri -path $isopath
Download-File -uri $installeruri -path $installerpath
