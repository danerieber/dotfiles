#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
	echo "Usage: $0 <FILE_PATH>"
	exit 1
fi

FILE_PATH="$1"

# Get the full file path for the input file
FILE_PATH=$(realpath "$FILE_PATH")

# Get the current directory path
CURRENT_DIR=$(pwd)

# Get the relative path to the current directory
RELATIVE_PATH="${FILE_PATH#$CURRENT_DIR/}"

# Expand wildcard characters to get target location
eval TARGET_LOCATION="$RELATIVE_PATH"

# Check if the file exists at the specified path
if [ ! -f "$FILE_PATH" ]; then
	echo "Error: File not found at '$FILE_PATH'."
	exit 1
fi

# Check if the target location exists and create it if it doesn't
TARGET_DIRECTORY=$(dirname "$TARGET_LOCATION")
if [ ! -d "$TARGET_DIRECTORY" ]; then
	mkdir -p "$TARGET_DIRECTORY"
fi

# Create a backup if the target file already exists
if [ -e "$TARGET_LOCATION" ]; then
	echo -e " BACKUP   \033[37m$TARGET_LOCATION\033[0m \033[37m->\033[0m \033[33m$TARGET_LOCATION.bak\033[0m"
	cp "$TARGET_LOCATION" "$TARGET_LOCATION.bak"
fi

# Copy the FILE_PATH to the target location
echo -e " COPY   \033[37m$FILE_PATH\033[0m \033[37m->\033[0m \033[1;32m$TARGET_LOCATION\033[0m"
cp "$FILE_PATH" "$TARGET_LOCATION"

exit 0
