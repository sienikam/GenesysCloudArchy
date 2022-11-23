export PATH="/cygdrive/c/Tools/cygwin64/bin/:$PATH"

# EXPORT
# Prepare flow list for Archy export
"$WORKSPACE"/gc flows list -a --transform archy_export_all.tmpl --clientid $export_oauthclient_id --clientsecret $export_oauthclient_secret --environment $export_environment > export_architect_flows.bat

# Create options file for export
echo "clientId: $export_oauthclient_id" > myOptions.yaml
echo "clientSecret: $export_oauthclient_secret" >> myOptions.yaml
echo "location: $export_environment" >> myOptions.yaml

# Archy Export
cmd /c call "$WORKSPACE"/export_architect_flows.bat

# Create options file for import
echo "clientId: $import_oauthclient_id" > myOptions.yaml
echo "clientSecret: $import_oauthclient_secret" >> myOptions.yaml
echo "location: $import_environment" >> myOptions.yaml

# Archy Import
set +e
for f in ./output/*.yaml; do "$WORKSPACE"/archy publish --optionsFile myOptions.yaml --file "$f"; done
