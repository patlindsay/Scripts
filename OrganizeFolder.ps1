#Folder Variable input from user
param(
    [Parameter(Mandatory=$true)][string]$messyFolder,
    [string]$destinationFilepath
)


##Test filepath
Write-Host "Testing File Path: $messyFolder"

if(!(Test-Path $messyFolder))
{
    Write-Host "Source Filepath invalid. Make sure it is in a `" `" format."
    exit
}

Write-Host "Source Filepath is valid."



#Check if optional destinationFilepath was provided, if not, generate a new folder
#in the same directory as the source folder
if($PSBoundParameters.ContainsKey('destinationFilepath'))
{
    Write-Host "Checking Destination Filepath"
    $organizedFolder = $destinationFilepath
}
else
{
    $filepathArray = $messyFolder -split "\"
    $organizedFolder = ""

    Write-Host "Creating Destination Filepath"

    for($i=0; $i -lt ($filepathArray.Length - 1); $i++)
    {
        $organizedFolder = $organizedFolder + $filepathArray[$i]
    }
    New-Item -Path $organizedFolder Directory
}


#Count total number of items to be organized
$totalFileCount = Write-Host (Get-ChildItem $messyFolder -Recurse | Measure-Object).Count
Write-Host "$totalFileCount Files to be organized into $organizedFolder"

#Initialize Progress Bar
Write-Progress -Activity "Starting to organize folder" -Status "0% Complete:" -PercentComplete 0



#Write Progress
$currentFileCount = Write-Host (Get-ChildItem $messyFolder -Recurse | Measure-Object).Count
Write-Progress -Activity "Organizing Folder" -Status "$(100 - ($currentFileCount/$totalFileCount)*100)) Complete:" -PercentComplete 100 - ($currentFileCount/$totalFileCount)*100)


#foreach item in $folderVariable
    #get metadata
    #if metadata.year folder doesn't exist, then create it
        #if metadata.month doesn't exist, then create it
    # move to metadata.year/metadata.month folder


#After sort, check for remaining files, if any are remaining, create new Unidentified Files
#directory in top of $organizedFolder, then move any files into a newly created folders
#that are named after their file extensions (i.e. ".txt Files", ".bmp files")



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
Write-Progress -Activity "Organizing Folder" -Status "$($currentFileCount/$totalFileCount) Complete:" -PercentComplete $currentFileCount/$totalFileCount #this calculation isn't going to work

# Move Music
Get-ChildItem -Path ".\*.mp3" -Recurse | Move-Item -Destination $organizedFolder + "\Music"\