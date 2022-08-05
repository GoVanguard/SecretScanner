Secret Scanner

Searches for common keys and secrets in a stupidly simple way.

Notes:
 - This can take time on large structures.
 - Yes, it's slow. I don't care if you have a better way.
 - This tool will find all references of a value.
 - Yes, it produces false positives as a result of the above.
 - Make absolutely sure your console scrollback is
   sufficiently large OR redirect to a text document.
 - Take your time and read the hits carefully.
 - The secrets in fixtures are not real. Just for testing.

Setup:
 - Git clone repo
 - Cd into directory
 - chmod a+x searchTexts.sh, testMe.sh, testMeNoisy.sh
 - apt-get install parallel -y
 - parallel --citation
 - type 'will cite'

Outputs:
 - All results will be placed into a file named 'results' under the
   path scanned.
 - Use 'cat' to display the results of a test. The files are full of
   tagging for coloring of text.

Usage:
./searchTexts.sh /your/path/ [noisy]

Supply the optional noisy parameter last to include the noisy,
high false postive tests. This can be useful for javascript and,
other similar cases where term ambiguity can produce a lot of 
results to look at.

Example Runtime Output:
############################## NOTE ########## ###################
###     This tool will find all references of a value.         ###
###     Consequently it will produce false positives.          ###
###     False positives are preferable to false negatives.     ###
###     Take your time and read the hits carefully.            ###
###     Make absolutely sure your console scrollback is        ###
###     sufficiently large OR redirect to a text document.     ###
############################## NOTE ##############################


 Results in ./fixtures/results


############################## NOTE ########## ###################
###     This tool will find all references of a value.         ###
###     Consequently it will produce false positives.          ###
###     False positives are preferable to false negatives.     ###
###     Take your time and read the hits carefully.            ###
###     Make absolutely sure your console scrollback is        ###
###     sufficiently large OR redirect to a text document.     ###
############################## NOTE ##############################

Example results from ./searchTexts.sh ./fixtures

cat ./fixtures/results

Searching (cased) AKIA...
./fixtures/.aws/credentials:7:aws_access_key_id = AKIAHARDCODEDACCKEY7
./fixtures/aws.json:9:    "aws_id": "AKIAHI38FAKE1IWUQEEN",
./fixtures/aws.xml:10:    <aws_id>AKIAHI38FAKE1IWUQEEN</aws_id>
./fixtures/aws.yml:8:aws_id: AKIAHI38FAKE1IWUQEEN
./fixtures/severity.yml:2:  aws_id: AKIAHI38FAKE1IWUQEEN


Example results from ./searchTexts.sh ./fixtures noisy

cat ./fixtures/results

Searching (regex term) api_?.*key...
./fixtures/apikeys.xml:5:    <api_endpoint>/apikey/</api_endpoint>
./fixtures/apikeys.xml:8:    <apikey>YXNkZmZmZmZm_HARDcoded</apikey>
./fixtures/apikeys.yml:3:  api_endpoint: /apikey/
./fixtures/apikeys.yml:11:  apikey: YXNkZmZmZmZm_HARDcoded
./fixtures/excluded.xml:5:      <api_key>API_KEY</api_key>
./fixtures/excluded.yml:3:  api_key: API_KEY
./fixtures/java.properties:6:api.key=
./fixtures/java.properties:11:api.key=dGhpc2lzYWhhcmRjb2RlZHN0cmluZzpECghardcoded03
./fixtures/ruleslist.yml:5:  apikey: YXNkZmZmZmZm_HARDcoded
./fixtures/severity.yml:8:  apikey: YXNkZmZmZmZm_HARDcoded

Searching (regex term) auth_?.*key...

Searching (regex term) service_?.*key...
