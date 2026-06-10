# Annuaire Startups

Application Flutter de répertoire des startups et incubateurs sénégalais.

Réalisée par **Moussa Ndao** — Promotion DAR26 — ESMT  
Module : Développement Multiplateforme  
ODD 9 — Industrie, innovation et infrastructure

## Fonctionnalités

- **CRUD complet** : Ajouter, lister, modifier et supprimer des startups
- **Filtres** : Filtrer les startups par secteur d'activité (Fintech, Agritech, Edtech, Autre)
- **Tri** : Trier par année de création (ascendant / descendant)
- **Recherche** : Rechercher une startup par son nom
- **Persistance** : Les données sont conservées après le redémarrage de l'application
- **Interface Material 3** : Design moderne avec thème personnalisé

## Captures d'écran

Les captures d'écran sont disponibles dans le dossier `captures/` :

| Écran | Aperçu |
|-------|--------|
| Accueil | `captures/Acceuil.jpeg` |
| Détail d'une startup | `captures/ecran details startup.jpeg` |
| Formulaire d'ajout | `captures/ecran formulaire ajouter une startup.jpeg` |
| Formulaire de modification | `captures/ecran modifier une startup.jpeg` |
| Confirmation de suppression | `captures/ecran formulaire supprimer une startup.jpeg` |
| Résultat filtre par secteur | `captures/resultats filtre par secteur.jpeg` |

## Technologies

- **Framework** : Flutter (Dart)
- **SDK** : ^3.11.1
- **Packages** :
  - `google_fonts` — Typographie Inter
  - `uuid` — Génération d'identifiants uniques
  - `shared_preferences` — Persistance locale

## Structure du projet

```
lib/
├── main.dart                 # Point d'entrée
├── app.dart                  # Configuration de l'application
├── theme/                    # Thème (couleurs, typographie)
├── models/                   # Modèle Startup
├── enums/                    # Énumération Sector
├── data/                     # Repository et persistance
├── routes/                   # Routes nommées
├── screens/                  # Écrans (Liste, Détail, Formulaire, À propos)
└── widgets/                  # Composants réutilisables
```

## Pour commencer

```bash
flutter pub get
flutter run
```

## Dépôt GitHub

```bash
https://github.com/MoussaNdaodev/Annuaire_Startup
```

## Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build windows    # Windows
```
