# cert-utils
SSL cert utilities

- Copy [secret.example.sh](secret.example.sh) to secret.sh in root directory
- Change PASS variable to some secret string
- Commands
  - generateRootKey.sh
  - generateRootCACert.sh
  - renewRootCACert.sh
  - generateDomainKey.sh
  - generateDomainCert.sh
  - renewDomainCert.sh
  - getbase64.sh -- get base64 encoded strings to be used in kubernetes secrets
