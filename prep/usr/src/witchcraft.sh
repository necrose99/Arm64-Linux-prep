emerge dev-perl/Class-Load dev-perl/Class-Load-XS dev-perl/List-MoreUtils dev-perl/DateTime-Local dev-perl/libwww-perl App-cpanminus

# downloading and install witchcraft
cd /usr/src/App-witchcraft-master && cpanm --installdeps -n . && cpanm .

# configuring witchcraft
mkdir -p /root/.witchcraft && cp -rfv /usr/src/App-witchcraft-master/witchcraft.conf /root/.witchcraft/witchcraft.conf && sed -i s:pushbullet:Git:g /root/.witchcraft/witchcraft.conf && sed -i s:Sabayon:Qacheck:g /root/.witchcraft/witchcraft.conf