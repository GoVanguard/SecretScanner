#!/bin/bash

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]
then
    echo -e "\e[33mUsage: ./searchTexts.sh /my/path/ [noisy]\e[0m"
    echo -e "\e[33mnoisy will run the noisy (high false positive) checks.\e[0m"
    exit 1
else
    echo -e "\c"
fi

if [ ! -d "$1" ]; then
    if [ -f "$1" ]; then
        echo -e "\e[31m$1 is a file or expression.\e[0m"
        echo -e "\e[31mPlease point to the parent directory to recursively search.\e[0m"
        exit 1
    fi
    echo -e "\e[31mGet real. $1 doesn't exist.\e[0m"
    exit 1
fi

if [ "$2" == "noisy" ]
then
    noisy=true
else
    noisy=false
fi

O_IFS=$IFS
IFS=""

echo -e "\e[31m############################## NOTE ########## ###################\e[0m"
echo -e "\e[31m###     This tool will find all references of a value.         ###\e[0m"
echo -e "\e[31m###     Consequently it will produce false positives.          ###\e[0m"
echo -e "\e[31m###     False positives are preferable to false negatives.     ###\e[0m"
echo -e "\e[31m###     Take your time and read the hits carefully.            ###\e[0m"
echo -e "\e[31m###     Make absolutely sure your console scrollback is        ###\e[0m"
echo -e "\e[31m###     sufficiently large OR redirect to a text document.     ###\e[0m"
echo -e "\e[31m############################## NOTE ##############################\e[0m"

searchTermsCase=(
    'AKIA'
    'ASIA'
    'CLIENT_SECRET'
    'MII'
    'eyJ'
    'SHA 1'
    'SHA 256'
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
    'X-XSRF-TOKEN'
    'X-Amzn-Authorization'

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
    '.decode'
    '.encode'
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

## Want to add something? Refer to https://linuxize.com/post/regular-expressions-in-grep/ for deets ##
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

grepOpts="-n -I -H --color=always"

echo "" > $1/results

if [ $noisy == true ]
then
    IFS=""
    for term in ${searchTermsRegEx[@]}
        do
            echo -e "\e[32mSearching (regex term) ${term}...\e[0m" 2>&1>> $1/results-${term} && \
            find $1 -type f -not -regex '.*\.(jpg|jpeg|png|gif|css|scss|dex|svg|zip|7z|rar|apk|ipa)$' | parallel -k -j12 -n 1000 -m LC_ALL=C egrep ${grepOpts} -E "\"${term}\"" --exclude-dir="node_modules" -H 2>&1>> $1/results-${term} &
        done
    for term in ${searchTermsAnyCase[@]}
        do
            echo -e "\e[32mSearching (case insensitive) ${term}...\e[0m" 2>&1>> $1/results-${term} && \
	    find $1 -type f -not -regex '.*\.(jpg|jpeg|png|gif|css|scss|dex|svg|zip|7z|rar|apk|ipa)$' | parallel -k -j12 -n 1000 -m LC_ALL=C egrep ${grepOpts} -i -e "\"${term}\"" --exclude-dir="node_modules" -H 2>&1>> $1/results-${term} &
        done
    IFS=${O_IFS}
    wait
    IFS=""
    for term in ${searchTermsRegEx[@]}
        do
            cat $1/results-${term} >> $1/results
            rm $1/results-${term}
        done
    for term in ${searchTermsAnyCase[@]}
        do
            cat $1/results-${term} >> $1/results
            rm $1/results-${term}
        done
    IFS=${O_IFS}
fi

results=""
if [ $noisy == false ]
    then
    IFS=""
    for term in ${searchTermsCase[@]}
        do
            echo -e "\e[32mSearching (cased) ${term}...\e[0m" 2>&1>> $1/results-${term} && \
            find $1 -type f -not -regex '.*\.(jpg|jpeg|png|gif|css|scss|dex|svg|zip|7z|rar|apk|ipa)$' | parallel -k -j12 -n 1000 -m LC_ALL=C egrep ${grepOpts} -E "\"${term}\"" --exclude-dir="node_modules" -H  2>&1>> $1/results-${term} &
        done
    IFS=${O_IFS}
    wait
    IFS=""
    for term in ${searchTermsCase[@]}
        do
            cat $1/results-${term} >> $1/results
            rm $1/results-${term}
        done
    IFS=${O_IFS}
fi

echo
echo

echo -e "\e[32m Results in $1/results\e[0m"

echo
echo

echo -e "\e[31m############################## NOTE ########## ###################\e[0m"
echo -e "\e[31m###     This tool will find all references of a value.         ###\e[0m"
echo -e "\e[31m###     Consequently it will produce false positives.          ###\e[0m"
echo -e "\e[31m###     False positives are preferable to false negatives.     ###\e[0m"
echo -e "\e[31m###     Take your time and read the hits carefully.            ###\e[0m"
echo -e "\e[31m###     Make absolutely sure your console scrollback is        ###\e[0m"
echo -e "\e[31m###     sufficiently large OR redirect to a text document.     ###\e[0m"
echo -e "\e[31m############################## NOTE ##############################\e[0m"

IFS=${O_IFS}
