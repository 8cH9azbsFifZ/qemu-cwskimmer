# Install qemu on host
apt-get -y install qemu-system-x86 

# Setup a bridge on host
apt install bridge-utils
sysctl -w net.ipv4.ip_forward=1

mkdir /etc/qemu
echo allow br0 > /etc/qemu/bridge.conf

cat << eof > /etc/network/interfaces.d/br0
auto br0
iface br0 inet dhcp
    bridge_ports enp0s25
eof

# Start with bridge on host
qemu-system-x86_64 -cpu host -hda debian.qcow -m 512 -nographic -enable-kvm -nic bridge


https://wiki.archlinux.org/title/QEMU


