#!/bin/bash/

#Develop a script to find and list duplicate files in a directory based on file size or checksum.



if [[ -z "$1" ]]; then
echo "Usage: $0 <directory_path>"
exit 1
fi

directory="$1"

if [[ ! -d "$directory" ]]; then
echo "Directory $directory not found"
exit 1
fi

declare -A sizes
while IFS=' ' read -r size name; do
sizes["$size"]+="$name "
done < <(find "$directory" -type f -exec stat --format='%s %n' {} + | sort -n)

for size in "${!sizes[@]}"; do
files=(${sizes["$size"]})
if [[ ${#files[@]} -gt 1 ]]; then
echo -e "\nDuplicate files (Size: $size bytes):"
for name in "${files[@]}"; do
echo "${name##*/}"
done
echo "_____________________________________________________"
fi
done
