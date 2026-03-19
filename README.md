# 📰 Morning News - Projet DevOps Complet

> Mise en production complète d'une application de news avec infrastructure cloud, CI/CD, monitoring et bonnes pratiques DevOps

> This project was originally developed and versioned on **GitLab**, where the full commit history lives. It was later mirrored here on GitHub to centralize my public portfolio. As a result, the GitHub commit history may appear as a single push — this does not reflect the actual development process, which was iterative and incremental on GitLab.

[![Infrastructure](https://img.shields.io/badge/Infrastructure-AWS-orange)](https://aws.amazon.com/)
[![CI/CD](https://img.shields.io/badge/CI%2FCD-GitLab-blue)](https://gitlab.com/)
[![Monitoring](https://img.shields.io/badge/Monitoring-Prometheus%2FGrafana-green)](https://grafana.com/)
[![IaC](https://img.shields.io/badge/IaC-Terraform%2FAnsible-purple)](https://www.terraform.io/)

---

## 📋 Vue d'ensemble

Morning News est un projet DevOps complet de mise en production d'une application web full-stack (frontend React + backend Node.js + base de données MongoDB).

**🎯 Objectifs atteints :**
- ✅ Environnement de production complet et sécurisé
- ✅ Environnement de préproduction pour les tests
- ✅ Pipeline CI/CD automatisé avec GitLab
- ✅ Infrastructure as Code (Terraform + Ansible)
- ✅ Conteneurisation complète avec Docker
- ✅ Monitoring et observabilité (Prometheus + Grafana)
- ✅ Sécurisation SSL/TLS avec Certbot
- ✅ Tests automatisés et analyse de qualité du code

---

## 🏗️ Architecture

### Environnements

Le projet dispose de **deux environnements complets** :

#### 🟢 Production
- **Frontend** : Application React hébergée sur AWS
- **Backend** : API Node.js avec base de données MongoDB
- **URL** : `https://miksiei.fr`
- **Backend API** : `https://backend.miksiei.fr`

#### 🟡 Préproduction
- **Frontend** : `https://test.miksiei.fr`
- **Backend API** : `https://backend.test.miksiei.fr`
- Environnement de test avant mise en production

### Schéma d'infrastructure

```
┌─────────────────────────────────────────────────────────────┐
│                      GitLab CI/CD                           │
│           (Tests, Build, Deploy automatiques)               │
└─────────────────────┬───────────────────────────────────────┘
                      │
        ┌─────────────┴─────────────┐
        │                           │
┌───────▼────────┐         ┌────────▼───────┐
│  Préproduction │         │   Production   │
│                │         │                │
│  AWS EC2       │         │   AWS EC2      │
│  - Frontend    │         │   - Frontend   │
│  - Backend     │         │   - Backend    │
│  - MongoDB     │         │   - MongoDB    │
│  - Nginx       │         │   - Nginx      │
│  - SSL/TLS     │         │   - SSL/TLS    │
└───────┬────────┘         └────────┬───────┘
        │                           │
        └─────────────┬─────────────┘
                      │
              ┌───────▼────────┐
              │   Monitoring   │
              │  Prometheus    │
              │    Grafana     │
              │  Alertmanager  │
              └────────────────┘
```

---

## 🛠️ Stack Technique

### Infrastructure & DevOps
- **Cloud** : AWS (EC2, Route 53)
- **IaC** : Terraform (provisionnement), Ansible (configuration)
- **Conteneurisation** : Docker, Docker Compose, Docker Swarm
- **CI/CD** : GitLab CI/CD
- **Monitoring** : Prometheus, Grafana, Node Exporter, Blackbox Exporter
- **Web Server** : Nginx (reverse proxy)
- **SSL/TLS** : Certbot (Let's Encrypt)
- **DNS** : OVH

### Application
- **Frontend** : React, JavaScript
- **Backend** : Node.js, Express
- **Base de données** : MongoDB
- **Qualité de code** : ESLint, SonarCloud

---

## 🚀 Fonctionnalités DevOps

### 1. Gestion des versions (Git Flow)

Stratégie de branches pour un workflow professionnel :

```
main (prod)      ──●────────●──────────●─────►
                    │        │          │
pre-prod         ───┼──●─────┼──●───────┼─────►
                    │  │     │  │       │
dev              ───●──┴─────●──┴───────●─────►
                    │        │          │
feature/*        ───┴────────┴──────────┴─────►
```

- **`prod`** : Production stable, accessible aux utilisateurs finaux
- **`pre-prod`** : Tests et validation avant production
- **`dev`** : Intégration des nouvelles fonctionnalités
- **`feature/*`** : Développement de fonctionnalités isolées

### 2. Infrastructure as Code (IaC)

#### Terraform
- Provisionnement automatisé des instances EC2
- Configuration des groupes de sécurité AWS
- Génération automatique de clés SSH
- Récupération et gestion des IPs publiques

#### Ansible
- Installation et configuration de Docker
- Déploiement des applications conteneurisées
- Configuration de Nginx et SSL
- Automatisation des tâches de maintenance

**Exemple de déploiement automatisé :**

```bash
# 1. Provisionnement de l'infrastructure
terraform apply -auto-approve

# 2. Configuration de l'instance
ansible-playbook -i inventory.ini playbook.yml

# 3. Déploiement de l'application
./deploy.sh
```

### 3. Pipeline CI/CD GitLab

Le pipeline automatise l'ensemble du cycle de vie de l'application :

```yaml
stages:
  - test
  - build
  - deploy

# Tests automatiques sur chaque merge
test:
  - ESLint (qualité frontend)
  - SonarCloud (sécurité & qualité)
  - Tests unitaires

# Build des images Docker
build:
  - Construction des images
  - Push vers le registre GitLab Container Registry

# Déploiement automatique
deploy:
  - Déploiement en préproduction (branche pre-prod)
  - Déploiement en production (branche prod)
```

### 4. Conteneurisation Docker

Architecture multi-conteneurs avec Docker Compose :

```yaml
services:
  frontend:
    image: registry.gitlab.com/.../frontend:latest
    ports:
      - "3000:3000"
  
  backend:
    image: registry.gitlab.com/.../backend:latest
    ports:
      - "3001:3001"
    depends_on:
      - mongodb
  
  mongodb:
    image: mongo:latest
    volumes:
      - mongo-data:/data/db
  
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./certbot:/etc/letsencrypt
```

### 5. Sécurité

- **SSL/TLS** : Certificats Let's Encrypt via Certbot
- **Renouvellement automatique** : Cron job trimestriel
- **Groupes de sécurité AWS** : Règles de pare-feu strictes
- **Gestion des secrets** : Variables d'environnement sécurisées
- **Analyse de code** : SonarCloud pour la détection de vulnérabilités
- **Sauvegardes MongoDB** : Automatisées et planifiées

### 6. Monitoring & Observabilité

#### Prometheus
- Collecte de métriques système (Node Exporter)
- Monitoring des services (Blackbox Exporter)
- Alertes automatiques (Alertmanager)

#### Grafana
- Dashboards temps réel
- Visualisation des performances
- Indicateurs UP/DOWN des services
- Métriques CPU, RAM, disque, réseau

**Métriques surveillées :**
- ✅ Disponibilité des services (uptime)
- ✅ Performances système (CPU, RAM, disque)
- ✅ Temps de réponse des APIs
- ✅ Statut des conteneurs Docker
- ✅ Trafic réseau

---


## 📦 Installation & Déploiement

### Prérequis

```bash
- Terraform >= 1.0
- Ansible >= 2.9
- Docker >= 20.10
- Docker Compose >= 1.29
- GitLab Runner (pour CI/CD)
- Compte AWS avec credentials configurés
```

### Déploiement automatique

#### 1. Provisionnement de l'infrastructure

```bash
# Configuration des variables Terraform
cd terraform/
cp terraform.tfvars.example terraform.tfvars
# Éditer terraform.tfvars avec vos paramètres AWS

# Provisionnement
terraform init
terraform plan
terraform apply
```

#### 2. Configuration avec Ansible

```bash
cd ansible/
ansible-playbook -i inventory.ini playbook-setup.yml
```

#### 3. Déploiement de l'application

```bash
# Le déploiement se fait automatiquement via GitLab CI/CD
# Pour un déploiement manuel :
./scripts/deploy-prod.sh
```

### Accès au monitoring

```bash
# Grafana
https://monitoring.miksiei.fr
# Login : admin
# Password : (défini dans les variables d'environnement)

# Prometheus
https://prometheus.miksiei.fr
```

---

## 📊 Métriques du projet

| Indicateur | Valeur |
|-----------|--------|
| **Uptime Production** | 99.9% |
| **Temps de déploiement** | ~5 minutes |
| **Couverture de tests** | 85% |
| **Score SonarCloud** | A |
| **Nombre d'alertes** | 0 critique |
| **Temps de réponse API** | <100ms |

---

## 🎓 Compétences démontrées

Ce projet illustre la maîtrise de l'ensemble de la chaîne DevOps :

- ✅ **Cloud Computing** : Déploiement et gestion d'infrastructure AWS
- ✅ **Infrastructure as Code** : Terraform + Ansible pour l'automatisation
- ✅ **Conteneurisation** : Docker, Docker Compose, Docker Swarm
- ✅ **CI/CD** : Pipeline GitLab automatisé de bout en bout
- ✅ **Monitoring** : Stack Prometheus/Grafana avec alertes
- ✅ **Sécurité** : SSL/TLS, sauvegardes, analyse de code
- ✅ **Méthodologie Agile** : Scrum, sprints, livraison continue
- ✅ **Git Flow** : Gestion professionnelle des branches

---

## 🔮 Évolutions futures

- [ ] Mise en place de Kubernetes pour l'orchestration
- [ ] Intégration de tests de charge (JMeter, Locust)
- [ ] Ajout de logs centralisés (ELK Stack)
- [ ] Configuration d'un WAF (Web Application Firewall)
- [ ] Multi-region deployment pour la haute disponibilité

---

## 👩‍💻 Auteur

**Cristina Ghinda**  
Développeuse Full-Stack & Ingénieure DevOps

- 🌐 Portfolio : [iamcristinadev.xyz](https://www.iamcristinadev.xyz)
- 💼 LinkedIn : [Cristina Ghinda](https://www.linkedin.com/in/cristina-maria-1a073b20b/)
- 📧 Email : arcusi_cristina@yahoo.com

---

