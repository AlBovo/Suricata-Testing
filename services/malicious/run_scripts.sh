#!/bin/sh
for file in `ls scripts`; do
    echo "Running script: $file"
    chmod +x /scripts/$file
    /scripts/$file
done
