. setenv.sh

# Ask confirmation
echo "Root CA is valid till : "
openssl x509 -enddate -noout -in ${ROOT_CA_CRT_PATH}
read -p "This will invalidate existing Root CA certificate. Are you sure wan't to continue? y/n [n] " yn

case $yn in
    [Yy]* ) 
        mv -b ${ROOT_CA_CRT_PATH} ${ROOT_CA_CRT_OLD_PATH}
        echo "Moving existing crt to ${ROOT_CA_CRT_OLD_PATH}"
        openssl x509 -x509toreq -in ${ROOT_CA_CRT_OLD_PATH} -signkey ${ROOT_CA_KEY_PATH} -passin env:ROOT_CA_PASSWORD -out ${ROOT_CA_CSR_PATH} -extfile ${ROOT_CA_OPENSSL_CONF_PATH} -extensions v3_x509
        echo "Root CA renewal csr generated successfully at ${ROOT_CA_CSR_PATH}"
        openssl x509 -req -days ${ROOT_CA_EXPIRY_DAYS} -in ${ROOT_CA_CSR_PATH} -signkey ${ROOT_CA_KEY_PATH} -passin env:ROOT_CA_PASSWORD -out ${ROOT_CA_CRT_PATH} -extfile ${ROOT_CA_OPENSSL_CONF_PATH} -extensions v3_x509
        echo "Root CA crt generated successfully at ${ROOT_CA_CRT_PATH}"
        rm ${ROOT_CA_CSR_PATH}
        echo "Removing csr file ${ROOT_CA_CSR_PATH}";;
    [Nn]* ) exit;;
        * ) exit;;
esac
# print crt details
openssl x509 -noout -text -in ${ROOT_CA_CRT_PATH}
# verify integrity
openssl x509 -noout -modulus -in ${ROOT_CA_CRT_PATH} | openssl md5
openssl rsa -noout -modulus -in ${ROOT_CA_KEY_PATH} -passin env:ROOT_CA_PASSWORD | openssl md5
echo "Root CA crt and key verified successfully."
