#!/usr/bin/env bash

# Directory containing the files
directory="./"

# Get the list of .jpg files in the directory
files=($(ls ${directory}*.jpg 2>/dev/null))

# Check if there are any files
if [ ${#files[@]} -eq 0 ]; then
  echo "No .jpg files found"
  exit 1
fi

# Get the current time in seconds since epoch
current_time=$(date +%s)

# Normalize the time to the range of file indices
file_count=${#files[@]}
index=$((current_time % file_count))

# Select the file based on the index
selected_file="${files[$index]}"

# Output the path of the selected file
echo "Setting wallpaper to: ${selected_file}"

# Set the wallpaper using feh (change this command based on your environment)
feh --bg-scale "${selected_file}"

