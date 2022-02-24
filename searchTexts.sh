#!/bin/bash

searchTermsCase=("AKIA", "ASIA", "MII", "eyJ",)
searchTermsAnyCase=("AccessKey", "AccessSecret", "Secret", "Token", "Decrypted", "Encrypted", "Password", "Username", "SecretKey", "Key" "\.decode", "Bearer", "X-API", "https:\/\/", "http:\/\/",)

for term in ${searchTermsCase[@]}
    do
        echo "Searching (cased) ${term}..."
        grep -e "${term}" $1/* -R
    done


for term in ${searchTermsAnyCase[@]}
    do
        echo "Searching (case insensitive) ${term}..."
        grep -e "${term}" $1/* -Ri
    done
