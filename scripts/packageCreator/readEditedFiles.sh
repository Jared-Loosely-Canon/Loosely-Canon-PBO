#!/bin/bash

# Read the contents of the file into a variable
newFiles=$(git ls-files -o | grep "^force-app/.*")

# Run the second command and capture its output
modifiedFiles=$(git ls-files -m)

# Get the Git Branch Name
branch=$(git symbolic-ref --short HEAD)

# Pass the two outputs as arguments to the Python script
python3 scripts/packageCreator/createPackage.py "$newFiles" "$modifiedFiles" "$branch"