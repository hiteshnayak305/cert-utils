. setenv.sh

echo "Root CA certificate :"
cat ${ROOT_CA_CRT_PATH} | base64 -w 0
echo

echo
echo "Domain certificate :"
cat ${DOMAIN_CRT_PATH} | base64 -w 0
echo

echo
echo "Domain key :"
cat ${DOMAIN_KEY_PATH} | base64 -w 0
echo