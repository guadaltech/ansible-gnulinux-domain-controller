# BLK Apple client Role

#### Kerberos
- https://www.apple.com/business/docs/site/Kerberos_Single_Sign_on_Extension_User_Guide.pdf

#### LDAP
- https://sites.google.com/site/mynotepad2/system-administration/mac-os-admin/ldap/setup-up-ldap-client-on-mac-os-x

#### Online
- https://punctuatednoise.wordpress.com/2015/09/14/network-authentication-os-x-kerberos-authentication-and-ldap-authorization/
- https://support.apple.com/en-us/HT202545

#### Offline
- https://kifarunix.com/configure-offline-authentication-via-openldap-on-macos-x/

#### SASL
- http://labs.opinsys.com/blog/2010/03/16/openldap-authentication-with-kerberos-backend-using-sasl/
- http://www.chschneider.org/linux/server/openldap.shtml
- https://www.cyrusimap.org/sasl/sasl/faqs/openldap-sasl-gssapi.html
- https://www.openldap.org/doc/admin24/sasl.html
- https://serverfault.com/questions/834523/add-gssapi-to-openldap-in-supportedsaslmechanisms
- https://georchestra-user-guide.readthedocs.io/en/latest/tutorials/sasl/
- https://help.ubuntu.com/community/SingleSignOn
- https://serverfault.com/questions/834523/add-gssapi-to-openldap-in-supportedsaslmechanisms

#### Schema LDAP MAC:
- https://opensource.apple.com/source/OpenLDAP/OpenLDAP-208.5/OpenLDAP/servers/slapd/schema/
- https://opensource.apple.com/source/OpenLDAP/OpenLDAP-208.5/OpenLDAP/servers/slapd/schema/apple.schema.auto.html

#### BONUS
- https://stackoverflow.com/questions/23936099/kerberos-sassl-openldap-gssapi-error-unspecified-gss-failure-minor-code-may
- http://research.imb.uq.edu.au/~l.rathbone/ldap/gssapi.shtml
- https://web.mit.edu/kerberos/krb5-1.13/doc/admin/princ_dns.html

```
curl -SL https://opensource.apple.com/source/OpenLDAP/OpenLDAP-208.5/OpenLDAP/servers/slapd/schema/apple.schema -o /etc/ldap/schema/apple.schema
```