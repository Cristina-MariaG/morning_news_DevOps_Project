#!/bin/bash

# Arrêter le script en cas d'erreur
set -e

# Variables
AWS_USER="admin"
AWS_HOST=$(terraform output -raw instance_public_ip)
SSH_KEY="./.ssh/backend-pre-prod"
DOCKER_COMPOSE_FILE="./docker-compose-pre-prod.yml"
REMOTE_DIR="/home/admin"
EMAIL_ADDRESS="arcusi_cristina@yahoo.com"


echo "Connecting to AWS instance and creating folder nginx"
ssh -i $SSH_KEY $AWS_USER@$AWS_HOST << EOF
    mkdir -p  $REMOTE_DIR/nginx/conf
    exit
EOF

# Copier le fichier docker-compose.yml vers la machine AWS
echo "Copying docker-compose file to AWS instance..."
scp -i $SSH_KEY ./.env $AWS_USER@$AWS_HOST:$REMOTE_DIR/.env
scp -i $SSH_KEY $DOCKER_COMPOSE_FILE $AWS_USER@$AWS_HOST:$REMOTE_DIR/docker-compose.yml
scp -i $SSH_KEY ./www.backend1.conf  $AWS_USER@$AWS_HOST:$REMOTE_DIR/nginx/conf/www.backend.conf

# Connexion à la machine AWS et exécution de Docker Compose et generation de certificat ssl
echo "Connecting to AWS instance and starting Docker Compose..."
ssh -i $SSH_KEY $AWS_USER@$AWS_HOST << EOF
    docker compose up -d
    docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -d backend.test.miksiei.fr --email $EMAIL_ADDRESS  -v --agree-tos
    exit
EOF

scp -i $SSH_KEY ./www.backend2.conf $AWS_USER@$AWS_HOST:$REMOTE_DIR/nginx/conf/www.backend.conf

scp -i $SSH_KEY ./renew_certif.sh $AWS_USER@$AWS_HOST:$REMOTE_DIR/renew_certif.sh

echo "Restart docker, install cron et ajout l'exec du fichier qui renouvelle le certif à chaque 3 mois"
ssh -i $SSH_KEY $AWS_USER@$AWS_HOST << EOF
    docker-compose restart
    sudo apt-get update
    sudo apt-get install -y cron
    sudo systemctl enable cron
    sudo systemctl start cron
    (crontab -l 2>/dev/null; echo "0 0 1 */3 * $REMOTE_DIR/renew_certif.sh") | crontab -
    echo "SSL renewal script and cron job setup complete!"
    exit
EOF

echo "Deployment complete!"
