# Universal Domain Controller
**BLKS (Bind9/LDAP/Kerberos/SSSD)**

## Usage

### Test with Vagrant

Install all:
```
make deploy
```

Destroy all:
```
make destroy
```

## Manage users

### Script

**Add User:**

```
./blksmanager -m add -a admin -w 4dm1n -u user3 -p user3 -g 5000 -d example.com
```

**Delete User:**

```
./blksmanager -m add -a admin -w 4dm1n -u user3 -p user3 -g 5000 -d example.com
```

### Manual

**Add User:**

```
ldapadd -D "cn=admin, dc=example,dc=com" -w 4dm1n << EOF
dn: uid=user,ou=People,dc=example,dc=com
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
objectClass: person
uid: user
sn: user
givenName: user
cn: user
displayName: user
uidNumber: 1005
gidNumber: 5000
gecos: user
loginShell: /bin/bash
homeDirectory: /home/user
EOF
```
```
kadmin.local -q "add_principal user@EXAMPLE.COM"
kinit user@EXAMPLE.COM
```

Option 1:
```
kadmin.local -q "ktadd -norandkey user@EXAMPLE.COM"
```

Option 2:
```
kadmin.local -q "xst -norandkey user@EXAMPLE.COM"
```

**Delete User:**

```
ldapdelete -x -D "cn=admin,dc=example,dc=com" 'uid=user,ou=People,dc=example,dc=com' -w 4dm1n
kadmin.local -q "delete_principal user@EXAMPLE.COM"
kdestroy
rm -f /etc/krb5.keytab 
```

**Test User:**

```
kinit -kt /etc/krb5.keytab user
getent passwd user
id user
login user
```

## ERRORS

### Links of interest

- https://docs.oracle.com/cd/E19253-01/816-4557/index.html
- https://docs.oracle.com/cd/E19253-01/816-4557/trouble-6/index.html


##### ERROR: Decrypt integrity check failed

**Option 1:** Possible incorrect password.
Did you export the principal with norandkey? By default ktadd exports changes the key to a random one.
Can you loging with kinit user@EXAMPLE.COM?

Example:
```
kadmin.local -q "ktadd -norandkey username@EXAMPLE.COM"
kinit username@EXAMPLE.COM
```

## BONUS

Guides:

- https://aws.nz/best-practice/sssd-ldap/
- https://calnus.com/2016/12/12/uniendo-gnu-linux-a-nuestro-active-directory-mediante-samba-y-sssd/
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system-level_authentication_guide/

Debug:

- https://docs.pagure.org/SSSD.sssd/users/troubleshooting.html
- https://jfearn.fedorapeople.org/fdocs/en-US/Fedora_Draft_Documentation/0.1/html/System_Administrators_Guide/SSSD-Troubleshooting.html

Retry ansible:

```
ansible-playbook -i inventory/local/hosts.ini --become --become-user=root ansible.yml -vvv --limit @$HOME/git/universal-domain-controller-git/ansible.retry
```