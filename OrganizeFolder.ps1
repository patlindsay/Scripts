#Folder Variable input from user
param(
    [Parameter(Mandatory=$true)][string]$messyFolder,
    [string]$destinationFilepath
)


##Test filepath
Write-Host "Testing File Path: $messyFolder"

if(!(Test-Path $messyFolder))
{
    Write-Host "Filepath invalid. Make sure it is in a `" `" format."
    exit
}

Write-Host "Filepath is valid."



#Check if optional destinationFilepath was provided, if not, generate a new folder
#in the same directory as the source folder
if($PSBoundParameters.ContainsKey('destinationFilepath'))
{
    $organizedFolder = $destinationFilepath
}
else
{
    $filepathArray = $messyFolder -split "\"
    $organizedFolder = ""

    for($i=0; $i -lt ($filepathArray.Length - 1); $i++)
    {
        $organizedFolder = $organizedFolder + $filepathArray[$i]
    }
    #Create new folder
}


#Count total number of items to be organized
$totalFileCount = Write-Host (Get-ChildItem $messyFolder -Recurse | Measure-Object).Count
Write-Host "$totalFileCount Files to be organized into $organizedFolder"

#Initialize Progress Bar
Write-Progress -Activity "Starting to organize folder" -Status "0% Complete:" -PercentComplete 0


##Start moving files
## Move Pictures
Get-ChildItem -Path ".\*.jpeg" -Recurse | Move-Item -Destination $organizedFolder + "\Pictures"
Get-ChildItem -Path ".\*.png" -Recurse | Move-Item -Destination $organizedFolder + "\Pictures"
Get-ChildItem -Path ".\*.jpg" -Recurse | Move-Item -Destination $organizedFolder + "\Pictures"

$currentFileCount = Write-Host (Get-ChildItem $messyFolder -Recurse | Measure-Object).Count
Write-Progress -Activity "Organizing Folder" -Status "$($currentFileCount/$totalFileCount) Complete:" -PercentComplete $currentFileCount/$totalFileCount

## Move Videos
Get-ChildItem -Path ".\*.mp4" -Recurse | Move-Item -Destination $organizedFolder + "\Videos"
Get-ChildItem -Path ".\*.avi" -Recurse | Move-Item -Destination $organizedFolder + "\Videos"
Get-ChildItem -Path ".\*.wmv" -Recurse | Move-Item -Destination $organizedFolder + "\Videos"

$currentFileCount = Write-Host (Get-ChildItem $messyFolder -Recurse | Measure-Object).Count
Write-Progress -Activity "Organizing Folder" -Status "$($currentFileCount/$totalFileCount) Complete:" -PercentComplete $currentFileCount/$totalFileCount

# Move Music
Get-ChildItem -Path ".\*.mp3" -Recurse | Move-Item -Destination $organizedFolder + "\Music"\

$currentFileCount = Write-Host (Get-ChildItem $messyFolder -Recurse | Measure-Object).Count
Write-Progress -Activity "Organizing Folder" -Status "$($currentFileCount/$totalFileCount) Complete:" -PercentComplete $currentFileCount/$totalFileCount


#foreach item in $folderVariable
    #get metadata
    #if