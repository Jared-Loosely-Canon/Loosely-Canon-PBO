# Read the contents of the file into a variable
$newFiles = git ls-files -o | Where-Object { $_ -match "^force-app/.*" }

# Run the second command and capture its output
$modifiedFiles = git ls-files -m

# Get the Git Branch Name
$branch = git rev-parse --abbrev-ref HEAD

# Pass the two outputs as arguments to the Python script
python scripts/packageCreator/createPackage.py "$newFiles" "$modifiedFiles" "$branch"
