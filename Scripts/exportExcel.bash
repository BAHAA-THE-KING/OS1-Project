#!/bin/bash


# Your text file (assumed to be in CSV format)
input_file="/opt/logs/logs.txt"
tmp_file="/opt/logs/t.txt"

# # Output Excel file
output_file="/OS1-Project/log.xlsx"

# # Convert text file to Excel using ssconvert

sed 's/: /,/g' $input_file > $tmp_file
# ssconvert "$input_file" "$output_file"
ssconvert "$tmp_file" "$output_file"
cat $tmp_file
rm $tmp_file
echo "Conversion complete. Excel file: $output_file"
