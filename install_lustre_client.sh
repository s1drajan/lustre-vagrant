#!/bin/bash

echo "🚀 Starting Lustre Client setup..."

# Add Lustre client repo
echo "📦 Adding Lustre client repo..."
sudo dnf config-manager --add-repo https://downloads.whamcloud.com/public/lustre/latest-release/el8/client.repo

# Enable PowerTools (needed for dependencies)
echo "🔓 Enabling PowerTools repo (if needed)..."
if sudo dnf config-manager --set-enabled powertools; then
    echo "✅ Enabled powertools."
elif sudo dnf config-manager --set-enabled PowerTools; then
    echo "✅ Enabled PowerTools."
else
    echo "⚠️ Could not enable PowerTools automatically. Make sure it's enabled manually if you hit issues."
fi

# Add EPEL (for dkms and other extras)
echo "📦 Installing EPEL release for DKMS..."
sudo dnf install -y epel-release

# Update repos
echo "🔄 Updating repositories..."
sudo dnf makecache

# Install dependencies + DKMS
echo "⬇️ Installing kernel development tools + DKMS..."
sudo dnf install -y dkms kernel-devel kernel-headers

# Install Lustre client
echo "📦 Installing Lustre client packages..."
sudo dnf install -y kmod-lustre lustre-client

# Confirm loaded modules
echo "🔍 Checking loaded Lustre modules..."
lsmod | grep lustre || echo "ℹ️ Lustre module not loaded yet. You can load it with: sudo modprobe lustre"

echo "✅ Lustre client setup complete!"

