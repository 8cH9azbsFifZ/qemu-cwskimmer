# Install qemu on host
apt-get -y install qemu-system-x86 qemu-kvm

# Setup a bridge on host
apt install bridge-utils
sysctl -w net.ipv4.ip_forward=1

mkdir /etc/qemu
echo allow br0 > /etc/qemu/bridge.conf

cat << eof > /etc/network/interfaces.d/br0
auto br0
iface br0 inet dhcp
    bridge_ports eno1
eof

- Warning: disable eno1 in /etc/network/interfaces!!

# Start with bridge on host 
qemu-system-x86_64 -cpu host -hda debian.qcow -m 512 -nographic -enable-kvm -nic bridge
qemu-system-x86_64 -cpu host -hda debian.qcow -m 512 -nographic -enable-kvm -net tap -net nic 


https://wiki.archlinux.org/title/QEMU


