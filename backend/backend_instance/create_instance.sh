#!/bin/bash

# Arrêter le script en cas d'erreur
set -e

# Variables
KEY_NAME="backend-pre-prod"
KEY_FILE="./.ssh/${KEY_NAME}"
PUBLIC_KEY_FILE="${KEY_FILE}.pub"

# Vérifier si la clé SSH existe déjà
mkdir -p  ./.ssh/
if [ ! -f "$KEY_FILE" ]; then
    echo "Clé SSH non trouvée, génération d'une nouvelle clé SSH..."
    ssh-keygen -t rsa -b 4096 -f "$KEY_FILE" 
else
    echo "Clé SSH trouvée : $KEY_FILE"
fi

#Initialiser Terraform et appliquer la configuration pour créer l'instance EC2
echo "Initialisation et application de Terraform..."
terraform init
terraform apply -auto-approve

# Obtenir l'adresse IP publique de l'instance EC2
echo "Récupération de l'adresse IP publique de l'instance EC2..."
INSTANCE_IP=$(terraform output -raw instance_public_ip)
echo "Instance ip"
echo ${INSTANCE_IP}

# Créer un fichier d'inventaire Ansible dynamique
echo "Création de l'inventaire Ansible..."
cat > inventory.ini <<EOF
[awsservers]
$INSTANCE_IP ansible_user=admin
EOF

# Exécuter le playbook Ansible pour installer Docker
echo "Exécution du playbook Ansible..."

sleep 60

ansible-playbook -i inventory.ini ansible_playbook.yml --private-key ./.ssh/backend-pre-prod --ssh-extra-args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

echo "Déploiement terminé avec succès !"
