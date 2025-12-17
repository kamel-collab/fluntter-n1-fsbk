# 📦 Flutter — Génération d’un APK & AAB et Publication sur Google Play

Ce guide complet explique **comment générer un `.apk` et un `.aab` signé** pour une application Flutter, à quoi ils servent, **leurs différences**, et **comment publier l’application sur Google Play**.

---

## 🧠 Table des matières

1. 📌 Présentation : APK vs AAB  
2. 🔑 Générer une clé de signature  
3. ⚙️ Configurer la signature dans Flutter  
4. 📦 Générer un APK signé  
5. 📦 Générer un AAB signé  
6. 📲 Installer et partager un APK  
7. 🚀 Publier sur Google Play  
8. 📊 Comparatif APK vs AAB  
9. 📌 Rappels & Bonnes pratiques

---

## 1️⃣ 📌 Présentation : APK vs AAB

### 📄 **APK (Android Package)**
- Format classique d’application Android
- Installable **directement** sur un appareil
- Utilisé pour les tests, la distribution interne, le partage hors Play Store

### 📦 **AAB (Android App Bundle)**
- Format officiel demandé par **Google Play**
- Non installable directement
- Google Play génère des APK optimisés pour chaque appareil
- Obligatoire pour **publier une application sur Google Play**

---

## 2️⃣ 🔑 Générer une clé de signature

⚠️ Cette étape est obligatoire pour signer ton application (APK & AAB).

Ouvre un terminal :

```bash
keytool -genkey -v \
  -keystore ~/chemin/vers/ma-cle.jks \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias mon_alias
Réponds aux questions :

Mot de passe du keystore

Nom, organisation, ville, pays

👉 Conserve précieusement :

Le fichier ma-cle.jks

Tous les mots de passe

3️⃣ ⚙️ Configurer la signature dans Flutter
📄 Crée le fichier :
android/key.properties

properties
Copier le code
storePassword=mot_de_passe_du_keystore
keyPassword=mot_de_passe_de_la_cle
keyAlias=mon_alias
storeFile=../chemin/vers/ma-cle.jks
4️⃣ 🛠️ Modifier android/app/build.gradle
Ajoute en haut :

gradle
Copier le code
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file("key.properties")
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
Dans signingConfigs :

gradle
Copier le code
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}
Dans buildTypes :

gradle
Copier le code
buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled false
        shrinkResources false
        proguardFiles getDefaultProguardFile(
            'proguard-android-optimize.txt'
        ), 'proguard-rules.pro'
    }
}
5️⃣ 📱 Générer un APK signé
Dans le terminal, à la racine du projet :

bash
Copier le code
flutter build apk
📄 Fichier généré :

swift
Copier le code
build/app/outputs/flutter-apk/app-release.apk
6️⃣ 📦 Générer un AAB signé
Toujours à la racine du projet :

bash
Copier le code
flutter build appbundle
📄 Fichier généré :

arduino
Copier le code
build/app/outputs/bundle/release/app-release.aab
Ce format est obligatoire pour Google Play.

7️⃣ 📲 Installer & partager un APK
Sur un téléphone Android
Copie l’APK sur le téléphone

Active “Sources inconnues”

Ouvre le fichier app-release.apk

Ou via ADB :

bash
Copier le code
adb install app-release.apk
👉 L’AAB ne s’installe pas directement : il faut passer par Google Play.

8️⃣ 🚀 Publier sur Google Play
🧑‍💻 1. Ouvre Google Play Console
👉 https://play.google.com/console

🪪 2. Crée un compte développeur
Frais unique : 25 $

Remplis les informations requises

📄 3. Crée une application
Nom

Langue principale

Catégorie

Politique de confidentialité

📦 4. Téléverse ton AAB
Menu → Production → Créer une nouvelle version
➡️ Ajoute :

Description courte & complète

Captures d’écran

Icône

Tags & catégorie

📤 5. Envoyer pour validation
Google Play vérifiera ton application
Cela peut prendre : quelques heures à 2–3 jours

9️⃣ 📊 Comparatif APK vs AAB
Critère	APK	AAB
Installable directement	✅	❌
Partage hors Play Store	✅	❌
Publication Google Play	❌	✅
Taille optimisée par appareil	❌	✅
Usage principal	Tests, partage	Production (Play Store)

📌 10️⃣ Rappels & bonnes pratiques
✅ Conserve toujours ta clé (.jks)
❌ Ne publie jamais un APK sur Google Play pour une nouvelle app
📦 Utilise l’AAB pour toute publication officielle
🔐 Garde tes mots de passe en sécurité
📄 Documente bien ton processus dans ton repo GitHub

🎉 Félicitations !
Tu as maintenant un guide complet pour gérer APK + AAB + publication Play Store avec Flutter.