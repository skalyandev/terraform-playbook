#!/bin/bash
# Jenkins bootstrap version: 2026-09-18-v2


set -euo pipefail

LOG_FILE="/var/log/jenkins-bootstrap.log"

exec > >(tee -a "${LOG_FILE}") 2>&1

echo "========================================"
echo "Jenkins bootstrap started: $(date)"
echo "========================================"

echo "Checking operating system..."
cat /etc/os-release

echo "Checking existing curl package..."
rpm -q curl-minimal || true
rpm -q curl || true

echo "Installing required packages..."
dnf install -y wget fontconfig

echo "Installing Java 21..."
dnf install -y java-21-amazon-corretto

echo "Verifying Java..."
java -version

echo "Configuring Jenkins repository..."
wget -O /etc/yum.repos.d/jenkins.repo \
  https://pkg.jenkins.io/rpm-stable/jenkins.repo

echo "Importing Jenkins repository signing key..."
rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key

echo "Installing Jenkins..."
dnf install -y jenkins

echo "Reloading systemd..."
systemctl daemon-reload

echo "Enabling Jenkins..."
systemctl enable jenkins

echo "Starting Jenkins..."
systemctl start jenkins

echo "Checking Jenkins service..."
systemctl is-active --quiet jenkins

echo "Jenkins service status:"
systemctl --no-pager --full status jenkins || true

echo "Jenkins version:"
jenkins --version || true

echo "========================================"
echo "Jenkins bootstrap completed: $(date)"
echo "========================================"
