Set objDomain = GetObject("LDAP://DC=cifsqa3,DC=lab,DC=eng,DC=btc,DC=netapp,DC=in")
Set objOU = objDomain.Create("organizationalUnit", "ou=HR")
objOU.SetInfo