Secret Scanner

Searches for common keys and secrets in a stupidly simple way.

Notes:
 - This can take time on large structures.
 - Yes, it's slow.
 - Yes, it produces false positives.
 - Make absolutely sure your console scrollback is
   sufficiently large OR redirect to a text document.
 - Take your time and read the hits carefully.
 - The secrets in fixtures are not real. Just for testing.

Setup:
 - Git clone repo
 - Cd into directory
 - chmod a+x searchTexts.sh and testMe.sh

Usage:
./searchTexts.sh /your/path/

Example Output:

############################## NOTE ##############################
###     This tool will produce false positives.                ###
###     False positives are preferable to false negatives.     ###
###     Take your time and read the hits carefully.            ###
###     Make absolutely sure your console scrollback is        ###
###     sufficiently large OR redirect to a text document.     ###
############################## NOTE ##############################

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
