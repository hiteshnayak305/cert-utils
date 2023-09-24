. ./setenv.sh

# do nothing if already exists
if [[ -f ${ROOT_CA_CRT_PATH} ]]
then
    echo "Root CA crt is already generated."
else
    openssl req -new -x509 -days ${ROOT_CA_EXPIRY_DAYS} -key ${ROOT_CA_KEY_PATH} -out ${ROOT_CA_CRT_PATH} -passin env:ROOT_CA_PASSWORD -config ${ROOT_CA_OPENSSL_CONF_PATH}
    echo "Root CA crt generated successfully at ${ROOT_CA_CRT_PATH}"
fi
# print crt details
openssl x509 -noout -text -in ${ROOT_CA_CRT_PATH}
# verify integrity
openssl x509 -noout -modulus -in ${ROOT_CA_CRT_PATH} | openssl md5
openssl rsa -noout -modulus -in ${ROOT_CA_KEY_PATH} -passin env:ROOT_CA_PASSWORD | openssl md5
echo "Root CA crt and key verified successfully."
