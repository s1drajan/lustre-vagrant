#!/bin/bash

# install_lustre_client.sh
# Finalized Lustre Client Setup for AlmaLinux 8.7 (DKMS-based)

set -e
set -o pipefail

echo "🔧 Setting up Lustre Client (DKMS version)..."

# Step 1: Add Lustre client repository
echo "📦 Adding Lustre repo..."
sudo tee /etc/yum.repos.d/lustre-client.repo > /dev/null <<EOF
[lustre-client]
name=Lustre Client
baseurl=https://downloads.whamcloud.com/public/lustre/latest-release/el8.10/client/
enabled=1
gpgcheck=0
EOF

# Step 2: Enable CRB (CodeReady Builder) repo for dev libraries
echo "🔓 Enabling CodeReady Builder repo..."
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --set-enabled codeready-builder-for-rhel-8-x86_64-rpms || sudo dnf config-manager --enable powertools
sudo dnf makecache

# Step 3: Install dependencies and DKMS package
echo "⬇️ Installing dependencies and DKMS..."
sudo dnf install -y dkms libmount-devel libyaml-devel
sudo dnf install -y lustre-client-dkms

# Step 4: Ensure Lustre module loads on boot
echo "📁 Setting Lustre module to load at boot..."
echo "lustre" | sudo tee /etc/modules-load.d/lustre.conf > /dev/null

# Step 5: Load the Lustre module now
echo "📦 Loading Lustre kernel module..."
sudo modprobe lustre

# Step 6: Done!
echo "✅ Lustre client setup complete."
echo ""
echo "👉 To mount the Lustre file system, use:"
echo "   sudo mkdir -p /mnt/lustre"
echo "   sudo mount -t lustre <mgs_hostname>@tcp:/<fsname> /mnt/lustre"

