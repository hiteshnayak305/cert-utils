. secret.sh

export BUILD_PATH=build
# root
export ROOT_CA_KEY_PATH=build/root/root.key
export ROOT_CA_CRT_PATH=build/root/root.crt
export ROOT_CA_CRT_OLD_PATH=build/root/root.crt.bak
export ROOT_CA_CSR_PATH=build/root/root.csr
export ROOT_CA_OPENSSL_CONF_PATH=root-req.conf
export ROOT_CA_PASSWORD=${PASS}
export ROOT_CA_EXPIRY_DAYS=3650
# domain
export DOMAIN_KEY_PATH=build/domain/domain.key
export DOMAIN_CRT_PATH=build/domain/domain.crt
export DOMAIN_CRT_OLD_PATH=build/domain/domain.crt.bak
export DOMAIN_CSR_PATH=build/domain/domain.csr
export DOMAIN_OPENSSL_CONF_PATH=req.conf
export DOMAIN_PASSWORD=${PASS}
export DOMAIN_EXPIRY_DAYS=365
# generate build paths
mkdir -p build/root
mkdir -p build/domain
