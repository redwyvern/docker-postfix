![](https://img.shields.io/docker/stars/redwyvern/postfix.svg)
![](https://img.shields.io/docker/pulls/redwyvern/postfix.svg)
![](https://img.shields.io/docker/automated/redwyvern/postfix.svg)
[![](https://images.microbadger.com/badges/image/redwyvern/postfix.svg)](https://microbadger.com/images/redwyvern/postfix "Get your own image badge on microbadger.com")

An image running a the postfix mailer daemon that will forward and authenticate with another mail relay.

This image is useful if you have to relay to another legitimate SMTP server in order to send outgoing mail and that SMTP server uses TLS and authentication.

Copy the postfix.yml from the image source repository, configure it and then and use this to launch the container via docker compose.

You may also wish to uncomment the ports section including the "- 587:25" in the postfix.yml file so that it will publish its SMTP port as port 587 in the host. This port can then be used by the LAN or the host itself as a simple unauthenticated relay. 
