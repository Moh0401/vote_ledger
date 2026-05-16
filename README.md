# vote_ledger
Voici un modèle de `README.md` complet et professionnel pour le dépôt GitHub de ton application mobile **Flutter** (destinée aux agents de terrain pour la saisie et la soumission des PV) :

---

# VoteLedger — Application Mobile des Agents (Flutter)

Ce dépôt contient le code source de l'application mobile **VoteLedger**, développée avec **Flutter**. Cette application est un outil critique destiné aux agents électoraux sur le terrain pour numériser, valider localement et soumettre les Procès-Verbaux (PV) de vote directement à l'API de centralisation et de vérification décentralisée.

L'application garantit l'intégrité des données dès leur saisie grâce à un calcul d'empreinte locale avant transmission.

---

## 🚀 Fonctionnalités Principales

* **Saisie Sécurisée des Résultats** : Interface optimisée pour la saisie des voix de chaque candidat ($Candidat A \dots E$), des votes nuls et du total des votants.
* **Validation Mathématique Locale** : Vérification de la cohérence des totaux à la volée pour éviter les erreurs humaines avant l'envoi.
* **Génération d'Empreinte (Hashing)** : Calcul local du hash SHA-256 du payload du PV pour garantir la non-falsification lors du transport réseau.
* **Suivi des Soumissions** : Historique local des PV transmis avec retour visuel sur le statut d'ancrage blockchain (`INTEGRE`, `CORROMPU`, `EN_ATTENTE`).

---

## 🛠️ Tech Stack & Architecture

* **Framework** : Flutter (v3.x) / Dart
* **Gestion d'État** : BLoC / Riverpod ou Provider (selon implémentation)
* **Client HTTP** : Dio / Http pour la communication avec l'API Spring Boot
* **Sécurité** : Cryptographie native pour le hachage SHA-256 des données du scrutin.

---

## 📦 Installation & Initialisation

### Prérequis

* [Flutter SDK](https://docs.flutter.dev/get-started/install) installé sur votre machine.
* Un émulateur (Android/iOS) ou un appareil physique connecté en mode débogage.

### Instructions

1. Clôner le dépôt du projet :

```bash
git clone https://github.com/votre-username/voteledger-mobile.git
cd voteledger-mobile

```

2. Récupérer les dépendances du projet :

```bash
flutter pub get

```

3. Configurer l'environnement :
Créez un fichier de configuration ou un fichier `.env` à la racine (ou dans `assets/configs/`) pour pointer vers votre instance backend Spring Boot :

```env
API_BASE_URL=http://<VOTRE_IP_BACKEND>:8080/api

```

4. Lancer l'application :

```bash
# Pour lancer sur l'appareil connecté par défaut
flutter run

```

---

## 📁 Structure Globale du Projet

```text
lib/
│
├── core/                  # Configurations globales, thèmes et clients réseau (Dio)
│   ├── constants/
│   └── network/           # Gestion des requêtes vers l'API Spring Boot
│
├── data/                  # Modèles de données et Repositories
│   ├── models/            # ex: VerificationSubmissionDto, PvModel
│   └── repositories/      # Logique de communication de données
│
├── bloc/ ou providers/    # Gestion des états (Soumission, Validation)
│
└── ui/                    # Écrans et composants graphiques (UI)
    ├── screens/           # Saisie du PV, Scan de QR, Historique
    └── widgets/           # Boutons personnalisés, champs de saisie de votes

```

---

## 🔄 Intégration API

L'application mobile communique principalement avec l'endpoint suivant du backend Spring Boot :

* **POST** `/api/verification/submit`
* **Payload transmis (`VerificationSubmissionDto`)** :
```json
{
  "pvNumber": "PV-94012",
  "bureauId": "B-001",
  "agentUsername": "mohamed_ceni",
  "agentFullName": "Mohamed",
  "candidatAVotes": 142,
  "candidatBVotes": 89,
  "candidatCVotes": 12,
  "candidatDVotes": 5,
  "candidatEVotes": 3,
  "blockchainHash": "a1b2c3d4...",
  "documentHash": "e5f6g7h8...",
  "divergenceDetected": false,
  "severity": "AUCUNE",
  "auditLog": "Saisie initiale terrain sans anomalie."
}

```





---

## 🧪 Build & Déploiement

Pour générer l'artéfact de production (APK pour Android) à distribuer aux agents de centralisation sur le terrain :

```bash
# Génération de l'APK Release
flutter build apk --release

```

Le fichier généré se trouvera dans : `build/app/outputs/flutter-apk/app-release.apk`.
