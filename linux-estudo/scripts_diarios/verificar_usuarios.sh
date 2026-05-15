#!/usr/bin/env bash


USER_TO_FIND="helio"
FOUND=0

while IFS=: read -r user _; do
    echo "$user"

    if [ "$user" = "$USER_TO_FIND" ]; then
        echo "usuario encontrado"
        FOUND=1
        break
    fi

done < /etc/passwd

if [ "$FOUND" -eq 0 ]; then
    echo "usuario nao encontrado"
fi
