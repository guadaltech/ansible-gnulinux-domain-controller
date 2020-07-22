#!/bin/bash

cache="n"
domainbase="example.com"
organization="example"
if [ -f ".custom_cache" ]; then
    source .custom_cache
    echo "Domainbase: $domainbase, Organization: $organization"
    echo -n "Use cache? (y/n): " ; read cache
fi

if [ "$cache" == "n" ]; then
    echo -n "Define domain base LDAP: " ; read domainbase
    echo -n "Define organization: " ; read organization
fi

openldap_base=$(echo $domainbase | tr -s '.' ' ' | sed  's/ /,dc=/g' | sed 's/^/dc=/g')
echo "domainbase=\"$domainbase\" openldap_base=\"$openldap_base\" organization=\"$organization\"" > ./tools/build_variable_domain

echo -n "export domainbase=$domainbase
export organization=$organization" > .custom_cache
