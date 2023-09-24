. setenv.sh

# do nothing if already exists
if [[ -f ${ROOT_CA_KEY_PATH} ]]
then
    echo "Root CA key is already generated."
else
    openssl genrsa -des3 -passout env:ROOT_CA_PASSWORD -out ${ROOT_CA_KEY_PATH} 4096
    echo "Root CA key generated successfully at ${ROOT_CA_KEY_PATH}"
fi
openssl rsa -noout -text -in ${ROOT_CA_KEY_PATH} -passin env:ROOT_CA_PASSWORD
echo "Root CA key verified successfully."