#!/bin/bash

# Jenkins EKS Agent / Jenkins Tool Configuration
# Version: 2026-10-02-v2

set -euo pipefail

########################################
# Configuration
########################################

LOG_FILE="/var/log/jenkins-agent-bootstrap.log"

########################################
# Validate execution user
########################################

if [[ "$(whoami)" != "ec2-user" ]]; then
    echo "ERROR: This script must be executed by ec2-user."
    echo "Current user: $(whoami)"
    exit 1
fi

########################################
# Validate sudo access
########################################

if ! sudo -n true 2>/dev/null; then
    echo "ERROR: ec2-user does not have passwordless sudo access."
    exit 1
fi

########################################
# Configure logging
########################################

sudo touch "${LOG_FILE}"
sudo chmod 644 "${LOG_FILE}"

exec > >(sudo tee -a "${LOG_FILE}") 2>&1

echo "========================================"
echo "Jenkins EKS Agent configuration started"
echo "Date    : $(date)"
echo "User    : $(whoami)"
echo "========================================"

########################################
# 1. Operating System
########################################

echo ""
echo "========================================"
echo "Checking operating system..."
echo "========================================"

cat /etc/os-release

########################################
# 2. Check existing packages
########################################

echo ""
echo "========================================"
echo "Checking existing packages..."
echo "========================================"

echo "curl-minimal:"
rpm -q curl-minimal || true

echo ""
echo "curl:"
rpm -q curl || true

echo ""
echo "git:"
rpm -q git || true

echo ""
echo "wget:"
rpm -q wget || true

########################################
# 3. Required OS packages
########################################

echo ""
echo "========================================"
echo "Installing required OS packages..."
echo "========================================"

# Amazon Linux 2023 already provides curl-minimal.
# Do NOT install the full curl package because it conflicts
# with curl-minimal.

sudo dnf install -y \
    git \
    wget \
    unzip \
    tar \
    gzip \
    jq \
    which \
    fontconfig

########################################
# 4. Verify curl
########################################

echo ""
echo "========================================"
echo "Verifying curl..."
echo "========================================"

curl --version

########################################
# 5. Java 21
########################################

echo ""
echo "========================================"
echo "Installing Java 21..."
echo "========================================"

sudo dnf install -y java-21-amazon-corretto

echo ""
echo "Java version:"
java -version

########################################
# 6. Git
########################################

echo ""
echo "========================================"
echo "Verifying Git..."
echo "========================================"

git --version

########################################
# 7. AWS CLI
########################################

echo ""
echo "========================================"
echo "Installing / verifying AWS CLI..."
echo "========================================"

if command -v aws >/dev/null 2>&1; then

    echo "AWS CLI is already installed."

else

    echo "AWS CLI not found. Installing AWS CLI v2..."

    rm -rf /tmp/aws /tmp/awscliv2.zip

    curl -L \
        "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
        -o /tmp/awscliv2.zip

    unzip -q \
        /tmp/awscliv2.zip \
        -d /tmp

    sudo /tmp/aws/install

    rm -rf /tmp/aws /tmp/awscliv2.zip

fi

echo ""
echo "AWS CLI version:"
aws --version

########################################
# 8. kubectl
########################################

echo ""
echo "========================================"
echo "Installing kubectl..."
echo "========================================"

if command -v kubectl >/dev/null 2>&1; then

    echo "kubectl is already installed."

else

    KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)"

    echo "kubectl version: ${KUBECTL_VERSION}"

    curl -L \
        -o /tmp/kubectl \
        "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

    sudo install \
        -m 0755 \
        /tmp/kubectl \
        /usr/local/bin/kubectl

    rm -f /tmp/kubectl

fi

echo ""
echo "kubectl version:"
kubectl version --client

########################################
# 9. Helm
########################################

echo ""
echo "========================================"
echo "Installing Helm..."
echo "========================================"

if command -v helm >/dev/null 2>&1; then

    echo "Helm is already installed."

else

    HELM_VERSION="$(
        curl -L -s \
        https://api.github.com/repos/helm/helm/releases/latest \
        | jq -r '.tag_name' \
        | sed 's/^v//'
    )"

    echo "Helm version: ${HELM_VERSION}"

    curl -L -o \
        "/tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
        "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz"

    tar -xzf \
        "/tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
        -C /tmp

    sudo install \
        -m 0755 \
        /tmp/linux-amd64/helm \
        /usr/local/bin/helm

    rm -rf \
        "/tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
        /tmp/linux-amd64

fi

echo ""
echo "Helm version:"
helm version

########################################
# 10. Trivy
########################################

echo ""
echo "========================================"
echo "Installing Trivy..."
echo "========================================"

if command -v trivy >/dev/null 2>&1; then

    echo "Trivy is already installed."

else

    echo "Configuring Trivy repository..."

    sudo tee /etc/yum.repos.d/trivy.repo > /dev/null <<'EOF'
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF

    echo "Installing Trivy..."

    sudo dnf install -y trivy

fi

echo ""
echo "Trivy version:"
trivy --version

########################################
# 11. Jenkins agent directory
########################################

echo ""
echo "========================================"
echo "Creating Jenkins agent directories..."
echo "========================================"

sudo mkdir -p /home/jenkins/agent

sudo chmod 755 /home/jenkins
sudo chmod 755 /home/jenkins/agent

########################################
# 12. Tool summary
########################################

echo ""
echo "========================================"
echo "Jenkins Agent Tool Summary"
echo "========================================"

echo ""
echo "Operating System:"
cat /etc/os-release | grep PRETTY_NAME

echo ""
echo "Java:"
java -version

echo ""
echo "Git:"
git --version

echo ""
echo "Curl:"
curl --version | head -n 1

echo ""
echo "AWS CLI:"
aws --version

echo ""
echo "kubectl:"
kubectl version --client

echo ""
echo "Helm:"
helm version

echo ""
echo "Trivy:"
trivy --version

echo ""
echo "Kaniko:"
echo "Kaniko will be provided as a container in the EKS Jenkins agent pod."

########################################
# 13. AWS identity
########################################

echo ""
echo "========================================"
echo "Checking AWS Identity"
echo "========================================"

aws sts get-caller-identity || true

########################################
# Completion
########################################

echo ""
echo "========================================"
echo "Jenkins EKS Agent configuration completed"
echo "Date : $(date)"
echo "Log  : ${LOG_FILE}"
echo "========================================"
