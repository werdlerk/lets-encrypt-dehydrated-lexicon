# Docker image for SSL Certificates using Dehydrated and Lexicon
Docker image to register SSL Certificates from Let's Encrypt using Dehydrated(.io) and Lexicon (for DNS changes)

This Docker image makes it possible to request SSL certificates from Let's Encrypt using dehydrated. The dehydrated hook.sh is run and uses Lexicon to make the required DNS changes to complete the required DNS challenge(s).   
For optimal modification possibilities, the hook.sh script is put in the /data directory. You're able to change the deploy_cert() function to perform custom actions when the certificate is saved and ready to be deployed. Please make use of the STAGE environment variable during testing of certificate deployment.

# Example Usage - dns
```
docker run -it --rm \
  --name lets-encrypt-dehydrated-lexicon \
  -e 'STAGE=true' \
  -e 'CHALLENGE_TYPE=dns-01',
  -e 'CONTACT_EMAIL=email@example.com',
  -e 'PROVIDER=cloudflare',
  -e 'LEXICON_CLOUDFLARE_USERNAME=myemail@gmail.com',
  -e 'LEXICON_CLOUDFLARE_TOKEN=XXXXXXXXX',
  -v '</path/to/data>:/data' \
  werdlerk/lets-encrypt-dehydrated-lexicon
```

# Volume : /data
The in the example usage above will be mapped to the /data directory. This directory contains the certificates (/data/certs/[domains]), the dehydrated accounts (/data/accounts) and the domains.txt (/data/domains.txt).  
The domains.txt file needs to be configured with the domains you want the certificate registered for.
