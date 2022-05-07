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
KS=keystore.jks
P12=pkcs.p12
echo "delete ${KS} and ${P12} if existent"
rm -f ${KS} ${P12}
PASSWORD=password
KEY_ALIAS=letsencrypt
echo "creating ${P12}"
openssl pkcs12 -export -inkey privkey.pem -in cert.pem -certfile chain.pem \
        -name ${KEY_ALIAS} -password pass:${PASSWORD} -out ${P12}
echo "creating ${KS}"
keytool -importkeystore -destkeystore ${KS} -deststorepass ${PASSWORD} -srckeystore ${P12} \
        -srcstoretype PKCS12 -srcstorepass ${PASSWORD} -alias ${KEY_ALIAS}
echo "done"