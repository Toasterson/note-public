DISK='/dev/vda'

FQDN='arch.eymatt.wegmueller.it'
KEYMAP='de_CH-latin1'
LANGUAGE='en_US.UTF-8'
PASSWORD=''
TIMEZONE='Europe/Zurich'
CONFIG_SCRIPT='/usr/local/bin/arch-config.sh'
TARGET_DIR='/mnt'
IP_CIDR='192.168.10.44/24'
IFACE='enp0s6'
ROUTER='192.168.10.1'

echo "==> Clearing partition table on ${DISK}"
/usr/bin/sgdisk --zap ${DISK}

echo "==> Destroying magic strings and signatures on ${DISK}"
/usr/bin/dd if=/dev/zero of=${DISK} bs=512 count=2048
/usr/bin/wipefs --all ${DISK}

echo "==> Creating rpool on ${DISK}"
parted --script ${DISK} mklabel gpt mkpart non-fs 0% 2 mkpart primary fat32 2 512M mkpart primary ext4 512M 100% set 1 bios_grub on set 2 boot on
mkfs.fat -F32 ${DISK}2
mkfs.ext4 ${DISK}3
mount ${DISK}3 /mnt
mkdir /mnt/boot
mount ${DISK}2 /mnt/boot

echo '==> Bootstrapping the base installation'
/usr/bin/pacstrap ${TARGET_DIR} base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
/usr/bin/arch-chroot ${TARGET_DIR} pacman -Sy --noconfirm gptfdisk openssh grub efibootmgr netctl vim

echo '==> Generating the system configuration script'
/usr/bin/install --mode=0755 /dev/null "${TARGET_DIR}${CONFIG_SCRIPT}"

cat <<-EOF > "${TARGET_DIR}/etc/netctl/eth0"
Description='A basic static ethernet connection'
Interface=${IFACE}
Connection=ethernet
IP=static
Address=('${IP_CIDR}')
Gateway='${ROUTER}'
DNS=('${ROUTER}')

## For IPv6 autoconfiguration
IP6=stateless
EOF

cat <<-EOF > "${TARGET_DIR}${CONFIG_SCRIPT}"
    echo '${FQDN}' > /etc/hostname
    /usr/bin/ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    echo 'KEYMAP=${KEYMAP}' > /etc/vconsole.conf
    /usr/bin/sed -i 's/#${LANGUAGE}/${LANGUAGE}/' /etc/locale.gen
    /usr/bin/sed -i 's/#COMPRESSION=.*/COMPRESSION="lz4"/' /etc/mkinitcpio.conf
    /usr/bin/sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="console=tty0 console=ttyS0,115200"/' /etc/default/grub

    /usr/bin/grub-install --target=i386-efi --removable --efi-directory=/boot --bootloader-id=GRUB
    /usr/bin/grub-install --target=x86_64-efi --removable --efi-directory=/boot --bootloader-id=GRUB
    /usr/bin/grub-mkconfig -o /boot/grub/grub.cfg
    /usr/bin/locale-gen
    /usr/bin/mkinitcpio -p linux
    echo root:${PASSWORD} | chpasswd
    /usr/bin/sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
    /usr/bin/sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    /usr/bin/systemctl enable sshd.service
    /usr/bin/pacman -S --noconfirm rng-tools
    /usr/bin/systemctl enable rngd
    /usr/bin/pacman -Rcns --noconfirm gptfdisk
    /usr/bin/yes | /usr/bin/pacman -Scc
EOF

echo '==> Entering chroot and configuring system'
/usr/bin/arch-chroot ${TARGET_DIR} ${CONFIG_SCRIPT}
rm "${TARGET_DIR}${CONFIG_SCRIPT}"

echo '==> Installation complete!'
umount /mnt/boot
umount /mnt
