#!/bin/bash

if [ "$#" -lt 1 ] || [ "$#" -gt 1 ]
then
    echo  "Usage: ./searchTexts.sh /my/path/"
    echo -e "\e[33mUsage: ./searchTexts.sh /my/path/\e[0m"
    exit 1
else
    echo -e "\c"
fi

if [ ! -d "$1" ]; then
    echo -e "\e[31mGet real. $1 doesn't exist.\e[0m"
    exit 1
fi

searchTermsCase=(
    'AKIA'
    'ASIA'
    'MII'
    'eyJ'
    'SHA\/1'
    'SHA\/256'
    'sq0csp-'
    'Authorization'
    'BEGIN RSA'
    'BEGIN DSA'
    'BEGIN EC'
    'BEGIN PRIVATE'
    'BEGIN OPENSSH'
    'BEGIN SSH'
    'BEGIN PGP'
    'PuTTY-User-Key'
)

searchTermsAnyCase=(
    'AccessKey'
    'AccessSecret'
    'Secret'
    'Token'
    'Decrypted'
    'Encrypted'
    'Pass'
    'Pwd'
    'Username'
    'SecretKey'
    'Key'
    '\.decode'
    '\.encode'
    'Bearer'
    'X-API'
    'https:'
    'http:'
    'webhooks'
    'AccountKey'
    'SubscriptionId'
    'RegionId'
    'contrase'
    'Realm'
    'Domain'
    'SAML'
)

searchTermsRegEx=(
    'api_?.*key'
    'auth_?.*key'
    'service_?.*key'
    'account_?.*key'
    'db_?.*key'
    'database_?.*key'
    'priv_?.*key'
    'private_?.*key'
    'client_?.*key'
    'db_?.*pass'
    'database_?.*pass'
    'key_?.*pass'
    'AC[a-z0-9]{32}'
    'SK[a-z0-9]{32}'
)


for term in ${searchTermsRegEx[@]}
    do
        echo ""
        echo "Searching (regex term) ${term}..."
        grep -E ${term} $1* -R
    done

for term in ${searchTermsCase[@]}
    do
        echo ""
        echo "Searching (cased) ${term}..."
        grep -e ${term} $1* -R
    done


for term in ${searchTermsAnyCase[@]}
    do
        echo ""
        echo "Searching (case insensitive) ${term}..."
        grep -e ${term} $1* -Ri
    done
