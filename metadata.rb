name             "opa"

maintainer       "admin"
maintainer_email "admin@opadescuentos.com"
description      "Installs and configures opa modules"
version          "1.0.0"

depends "aws"

recommends 'java'
recommends 'monit'

provides 'opa::discounts'
