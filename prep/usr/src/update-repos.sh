mkdir -p /etc/portage/repos.conf/

cat <<EOG > /etc/portage/repos.conf/gentoo.conf
[DEFAULT]
main-repo = gentoo
[gentoo]
location = /usr/portage
sync-type = rsync
sync-uri = rsync://rsync.namerica.gentoo.org
EOG

cat <<EOF > /etc/portage/repos.conf/pentoo.conf
[pentoo]
location = /usr/local/overlay/pentoo
sync-type = git
sync-uri = https://github.com/pentoo/pentoo-overlay.git
auto-sync = yes
EOF

cat <<EOS > /etc/portage/repos.conf/sabayon.conf
[sabayon]
location = /usr/local/overlay/sabayon
sync-type = git
sync-uri = https://github.com/Sabayon/for-gentoo.git
auto-sync = yes
EOS

cat <<EOSD > /etc/portage/repos.conf/sabayon-distro.conf
[sabayon-distro]
location = /usr/local/overlay/sabayon-distro
sync-type = git
sync-uri = https://github.com/Sabayon/sabayon-distro.git
auto-sync = yes
EOSD

cat <<EOSN > /etc/portage/repos.conf/necromancy.conf
[pentoo]
location = /usr/local/overlay/necromancy
sync-type = git
sync-uri = https://github.com/necrose99/necromancy-overlay.git
auto-sync = yes
EOSN


cat <<EOSZ > /etc/portage/repos.conf/zeldin.conf
[pentoo]
location = /usr/local/overlay/zeldin
sync-type = git
sync-uri = https://github.com/zeldin/gentoo.overlay.git
auto-sync = yes
EOSZ



# Upgrading packages

rsync -av "rsync://rsync.at.gentoo.org/gentoo-portage/licenses/" "/usr/portage/licenses/" && ls /usr/portage/licenses -1 | xargs -0 > /etc/entropy/packages/license.accept && \
echo -5 | equo conf update