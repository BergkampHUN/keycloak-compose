#!/bin/bash
#
# Copyright 2022 mbo.dev
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if [ -e keystore.jks ]; then
  echo "exiting(1): keystore exists"
  exit 1
fi
echo "just type password wherever prompted for a password"
openssl pkcs12 -export -out pkcs.p12 -inkey privkey.pem -in cert.pem -certfile chain.pem -name letsencrypt
keytool -importkeystore -destkeystore keystore.jks -srckeystore pkcs.p12 \
        -srcstoretype PKCS12 -alias letsencrypt