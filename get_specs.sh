#!/usr/bin/env sh

# Retrieve and extract XML files for use in code generation error reproduction

# Make directories for each standard
mkdir -p EUROMAP/EUROMAP_{77,79,82_2,83}

# create directory for zip files
mkdir -p zips

declare -a urls

urls=(
	"https://www.euromap.org/media/recommendations/77/2020/EUROMAP77_Release_1.01.zip"
	"https://www.euromap.org/media/recommendations/79/Opc.Ua.PlasticsRubber.ImmToRobot v1.00.06.zip"
	"https://www.euromap.org/media/recommendations/83/2021/EUROMAP83_Release_1.03.zip"
	"https://www.euromap.org/media/recommendations/82_2/Release1_00/EUROMAP82.2_Release_1.00.zip"
)

for url in "${urls[@]}"; do
    file_name=$(basename "$url")
    prefixed_file_name="zips/$file_name"
    # echo "File name: $file_name"

    euro_num=$(echo $url | rg -oP 'recommendations/\K([\d_]+?)(?=/)')
    dir_name="EUROMAP/EUROMAP_$euro_num"

    # echo "Directory name: $dir_name"

    if [[ ! -f "$prefixed_file_name" ]]; then
        echo "Downloading $file_name ..."
	# download file into "zips" directory
        wget -P zips --content-disposition "$url"
        echo "Downloaded $file_name"
    else
	echo "$file_name already exists"
    fi


    # echo "Extracting files for $dir_name ..."
    # use `-n` to ensure we don't overwrite existing files
    # just continue if the files already exist
    unzip -n "$prefixed_file_name" -d "$dir_name"
    echo "Extracted files for $dir_name"
done
