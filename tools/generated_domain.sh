#!/bin/bash

echo "Define domain base LDAP: " ; \
read domainbase
echo "Define Organization: " ; \
read organization
openldap_base=$(echo $domainbase | tr -s '.' ' ' | sed  's/ /,dc=/g' | sed 's/^/dc=/g')
echo "domainbase=\"$domainbase\" openldap_base=\"$openldap_base\" organization=\"$organization\"" > ./tools/build_variable_domain