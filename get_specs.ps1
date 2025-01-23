#!/usr/bin/env pwsh

# Retrieve and extract XML files for use in code generation error reproduction

# Create directories for each standard
@('EUROMAP\\EUROMAP_77', 'EUROMAP\\EUROMAP_79', 'EUROMAP\\EUROMAP_82_2', 'EUROMAP\\EUROMAP_83') |
    ForEach-Object { New-Item -ItemType Directory -Force -Path $_ | Out-Null }

# Create directory for zip files
New-Item -ItemType Directory -Force -Path "zips" | Out-Null

# Define URLs
$urls = @(
    "https://www.euromap.org/media/recommendations/77/2020/EUROMAP77_Release_1.01.zip",
    "https://www.euromap.org/media/recommendations/79/Opc.Ua.PlasticsRubber.ImmToRobot v1.00.06.zip",
    "https://www.euromap.org/media/recommendations/83/2021/EUROMAP83_Release_1.03.zip",
    "https://www.euromap.org/media/recommendations/82_2/Release1_00/EUROMAP82.2_Release_1.00.zip"
)

foreach ($url in $urls) {
    $fileName = Split-Path $url -Leaf
    # Write-Host "Filename: $fileName"
    
    $prefixedFileName = "zips\$fileName"
    # Write-Host "Prefixed file name: $prefixedFileName"

    # Find the number of the specification in the url path
    $url -match 'recommendations/([\d_]+?)/' | Out-Null

    # retrieve the first match
    $euroNum = $Matches[1]

    # get the name of the specification
    $specificationName = "EUROMAP_$euroNum"

    # construct the directory name using the number of the specification
    $dirName = "EUROMAP\$specificationName"

    # Write-Host "Checking if directory exists: $prefixedFileName"
    if (-Not (Test-Path $prefixedFileName)) {
        # Write-Host "Downloading $fileName to $prefixedFileName ..."
        Invoke-WebRequest -Uri $url -OutFile $prefixedFileName -UseBasicParsing
        Write-Host "Downloaded $fileName"
    } else {
        # Write-Host "$fileName already exists"

    }

    # Write-Host "Extracting files for $dirName ..."
    
    # Extract files into the target directory, skipping existing files
    Expand-Archive -Path $prefixedFileName -DestinationPath $dirName -ErrorAction SilentlyContinue
    Write-Host "Finished processing $specificationName"
}
