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

> Ajoute ici des captures d'écran de ton application (écran liste, écran détail, formulaire).
>
> Pour générer des captures sur Android : `flutter screenshot`
> Ou utilise un émulateur et fais une capture d'écran manuellement.
>
> Exemple :
> ```
> screenshots/
>   liste.png
>   detail.png
>   formulaire.png
> ```

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
docs/                         # Documentation du projet
```

## Pour commencer

```bash
flutter pub get
flutter run
```

## Icône de l'application

Pour personnaliser l'icône de l'application :
1. Crée un dossier `assets/` et place une image `icon.png` (1024x1024 px)
2. Ajoute `flutter_launcher_icons` dans `pubspec.yaml` en dev_dependencies
3. Ajoute la configuration suivante dans `pubspec.yaml` :
   ```yaml
   flutter_launcher_icons:
     android: true
     ios: true
     windows: true
     image_path: "assets/icon.png"
   ```
4. Exécute : `flutter pub get && dart run flutter_launcher_icons`

## Documentation

Consultez le dossier `docs/` pour la documentation complète :
- `01_modelisation_merise.md` — Modélisation Merise (MCD, MLD, dictionnaire des données)
- `02_design_ux_ui.md` — Design system, charte graphique, wireframes
- `03_decoupage_conception.md` — Découpage et checklist de conformité
- `04_packages.md` — Justification des packages utilisés

## Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build windows    # Windows
```
