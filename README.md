# 2FA

This project helps to run a keycloak instance with proper SSL support. It also helps to place a nginx proxy in front
of it which is also able to host .well-known or anything else you want to.

All SSL support is based on let's encrypt certificates which are not included in this repository.

## Getting Started

- Download your SSL keys+certificates in keycloak and nginx/certs folder.
- Run keycloak/genkeystore.sh from within the keycloak folder.
- Adapt server_name in nginx/conf.d/keycloak.conf
- Adapt services.smtp.environment.maildomain in docker-compose.yml
- Adapt services.keycloak.environment.KC_HOSTNAME and services.keycloak.environment.KEYCLOAK_FRONTEND_URL in
  docker-compose.yml
- Start compose: `docker compose up -d`

## keycloak

Built based on latest keycloak from docker hub.

### genkeystore.sh

This script helps to create the java keystore (keystore.jks) for keycloak. You need to place 3 files in the keycloak
folder (soft links work as well):

- cert.pem
- chain.pem
- privkey.pem

OpenSSL is used to create a .p12 formatted key from these let's encrypt certificates. This is then picked up from java
keytool to create the keystore.jks. All password handling is hardcoded in the script and the default password used
in keycloak is used.

## nginx

Here a default nginx image is used and some folders are mounted for configuration:

- **certs**: Certificate data for nginx (fullchain.pem + privkey.pem). This requires no extra transformation. Soft links
  should work as well.
- **conf.d**: Place for nginx configuration files. Two files are included in the project. One for the default host and
  one for the keycloak instance. Make sure to change the server_name in the keycloak.conf to your dns.
- **html**: Here html content can be placed that should be hostet by the proxy. A default error for backend not found
  plus a simple index page for the keycloak .well-known folder are included.
- **includes**: This folder is for some reusable nginx configurations that can be added with the included directive in
  configurations.