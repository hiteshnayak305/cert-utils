. ./setenv.sh

# do nothing if already exists
if [[ -f ${ROOT_CA_DEC_KEY_PATH} ]]
then
    echo "Root CA decrypted key is already generated."
else
    openssl rsa -in ${ROOT_CA_KEY_PATH} -out ${ROOT_CA_DEC_KEY_PATH} -passin env:ROOT_CA_PASSWORD
    echo "Root CA decrypted key generated successfully at ${ROOT_CA_DEC_KEY_PATH}"
fi
