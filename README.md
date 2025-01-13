### How Jenkins uses SSL cert and key to connect with internet over HTTPS:
```
openssl genpkey -algorithm RSA -out jenkins.key
openssl req -new -key jenkins.key -out jenkins.csr
openssl x509 -req -in jenkins.csr -signkey jenkins.key -out jenkins.crt
```
### Put all jenkins.key, jenkins.csr, and jenkins.crt into one directory.
### Go to Jenkins GUI > Dashboard > Manage Jenkins > System > Global Properties > Environment Variables and the below environment variables with values:
```
httpPort = -1
httpsCertificate = C:\path\to\jenkins.crt (example:: C:\ProgramData\Jenkins\keys\jenkins.crt)
httpsPort = 8443
httpsPrivateKey = C:\path\to\jenkins.key (example:: C:\ProgramData\Jenkins\keys\jenkins.key)
```
