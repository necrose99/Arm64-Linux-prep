mkdir -p /etc/portage/repos.conf/

cat <<EOG > /etc/portage/repos.conf/hacking-gentoo.conf
[hacking-gentoo]
location = /usr/local/overlay/hacking-gentoo
sync-type = rsync
sync-uri = rsync://rsync.mad-hacking.net/hacking-gentoo-overlay 
EOG