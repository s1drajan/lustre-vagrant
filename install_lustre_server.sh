#!/bin/bash

echo "🚀 Starting Lustre Server setup..."

# Kernel Check ✅
echo "🔍 Checking current kernel..."
REQUIRED_KERNEL="4.18.0-553.27.1.el8_lustre.x86_64"
CURRENT_KERNEL=$(uname -r)

if [ "$CURRENT_KERNEL" != "$REQUIRED_KERNEL" ]; then
    echo "❌ Kernel mismatch: expected $REQUIRED_KERNEL but got $CURRENT_KERNEL."
    echo "👉 Make sure you've manually installed and booted into the correct kernel BEFORE running this script."
    exit 1
else
    echo "✅ Kernel is correct: $CURRENT_KERNEL"
fi

# Set devices (adjust if needed) 🔧
MGS_DEV="/dev/sdb"
MDT_DEV="/dev/sdb"
OST1_DEV="/dev/sdc"
OST2_DEV="/dev/sdd"

# Download necessary RPMs for Lustre and dependencies
echo "⬇️ Downloading Lustre server RPMs..."
mkdir -p ~/lustre-install && cd ~/lustre-install

# Lustre RPMs
wget -q https://downloads.whamcloud.com/public/lustre/latest-release/el8.10/server/RPMS/x86_64/kmod-lustre-2.15.6-1.el8.x86_64.rpm
wget -q https://downloads.whamcloud.com/public/lustre/latest-release/el8.10/server/RPMS/x86_64/kmod-lustre-osd-ldiskfs-2.15.6-1.el8.x86_64.rpm
wget -q https://downloads.whamcloud.com/public/lustre/latest-release/el8.10/server/RPMS/x86_64/lustre-2.15.6-1.el8.x86_64.rpm
wget -q https://downloads.whamcloud.com/public/lustre/latest-release/el8.10/server/RPMS/x86_64/lustre-osd-ldiskfs-mount-2.15.6-1.el8.x86_64.rpm

# e2fsprogs dependencies
wget -q https://downloads.whamcloud.com/public/e2fsprogs/latest/el8/RPMS/x86_64/e2fsprogs-1.47.1-wc2.el8.x86_64.rpm
wget -q https://downloads.whamcloud.com/public/e2fsprogs/latest/el8/RPMS/x86_64/e2fsprogs-libs-1.47.1-wc2.el8.x86_64.rpm
wget -q https://downloads.whamcloud.com/public/e2fsprogs/latest/el8/RPMS/x86_64/libcom_err-1.47.1-wc2.el8.x86_64.rpm
wget -q https://downloads.whamcloud.com/public/e2fsprogs/latest/el8/RPMS/x86_64/libss-1.47.1-wc2.el8.x86_64.rpm

# Handle conflicts if needed 🔥
echo "⚠️ Removing conflicting packages if present..."
sudo dnf remove -y krb5-devel libcom_err-devel openssl-devel || true

# Install everything 🚀
echo "📦 Installing Lustre server packages + dependencies..."
sudo dnf install -y ./*.rpm || {
    echo "❌ Failed to install Lustre server packages. Check dependencies."
    exit 1
}

# Format MDT + OSTs 🖴
echo "🛠️ Formatting MDT on $MDT_DEV..."
sudo mkfs.lustre --mdt --mgs --fsname=lustrefs $MDT_DEV

echo "🛠️ Formatting OST 1 on $OST1_DEV..."
sudo mkfs.lustre --ost --fsname=lustrefs --mgsnode=lustre-server@tcp --index=0 $OST1_DEV

echo "🛠️ Formatting OST 2 on $OST2_DEV..."
sudo mkfs.lustre --ost --fsname=lustrefs --mgsnode=lustre-server@tcp --index=1 $OST2_DEV

# Mount MDT + OSTs 🗂️
echo "📂 Mounting MDT and OSTs..."
sudo mkdir -p /mnt/mdt /mnt/ost1 /mnt/ost2
sudo mount -t lustre $MDT_DEV /mnt/mdt
sudo mount -t lustre $OST1_DEV /mnt/ost1
sudo mount -t lustre $OST2_DEV /mnt/ost2

# Confirm ✅
echo "✅ Lustre server setup complete!"
echo "🖥️ Mounted file systems:"
mount | grep lustre
echo "🎉 Done! The server is now ready for Lustre clients to connect."

