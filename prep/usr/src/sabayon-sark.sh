echo "fetching Sabayon sark for arm64 Docker/chroot"
wget https://github.com/Sabayon/sabayon-sark/archive/master.zip -o /usr/src/sabayon-sark.zip
unzip sabayon-sark.zip && cd /usr/src/sabayon-sark
make 