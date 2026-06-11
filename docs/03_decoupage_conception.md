# Découpage de la conception — Annuaire des Startups et Incubateurs

## Vue d'ensemble

| Phase | Étapes | Durée estimée |
|---|---|---|
| **1. Fondations** | 1 à 4 | 15 min |
| **2. Modèle et données** | 5 à 6 | 15 min |
| **3. Design system** | 7 à 8 | 20 min |
| **4. Navigation** | 9 | 10 min |
| **5. Écrans** | 10 à 13 | 45 min |
| **6. Composants** | 14 à 17 | 30 min |
| **7. Finalisation** | 18 à 20 | 20 min |

---

## Phase 1 — Fondations

### Étape 1 : Création du projet Flutter
- `flutter create` avec le nom `annuaire_startup`
- Plateformes : Android, iOS, Windows

### Étape 2 : Ajout des dépendances
```yaml
dependencies:
  google_fonts: ^6.1.0    # Typographie Inter
  uuid: ^4.5.1             # Génération d'ID uniques
  intl: ^0.19.0            # Formatage de dates
```

### Étape 3 : Structure des dossiers
```
lib/
├── main.dart              # Point d'entrée
├── app.dart               # Configuration MaterialApp
├── theme/
│   └── app_theme.dart     # Thème global (couleurs, typo, formes)
├── models/
│   └── startup.dart       # Modèle de données
├── enums/
│   └── startup_enums.dart # Énumérations
├── data/
│   └── startup_repository.dart  # Couche CRUD en mémoire
├── routes/
│   └── app_router.dart    # Configuration des routes nommées
├── screens/
│   ├── startup_list_screen.dart   # Écran liste
│   ├── startup_detail_screen.dart # Écran détail
│   ├── startup_form_screen.dart   # Écran formulaire
│   └── about_screen.dart          # Écran À propos
└── widgets/
    ├── startup_card.dart          # Carte startup réutilisable
    ├── sector_tag.dart            # Tag secteur
    ├── incubated_badge.dart       # Badge incubée
    ├── stats_header.dart          # En-tête statistiques
    ├── empty_state_widget.dart    # État vide
    └── confirmation_dialog.dart   # Dialogue de confirmation
```

### Étape 4 : Configuration des assets
- Dossier `assets/` pour les ressources statiques (images, icônes)
- Déclaration dans `pubspec.yaml`

---

## Phase 2 — Modèle et données

### Étape 5 : Création de l'énumération Sector
**Fichier :** `lib/enums/startup_enums.dart`
- Valeurs : `fintech`, `agritech`, `edtech`, `other`
- Propriétés : `label` (String), `emoji` (String), `color` (Color)
- Méthode `fromString(String)` pour la conversion inverse

### Étape 6 : Création du modèle Startup
**Fichier :** `lib/models/startup.dart`
- Attributs : `id`, `nom`, `secteur`, `ville`, `anneeCreation`, `incubee`, `description`
- Constructeur avec paramètres nommés et `required`
- Propriété calculée : `age` (int) — nombre d'années depuis la création
- Méthode : `copyWith` pour l'édition partielle

### Étape 7 : Création du repository
**Fichier :** `lib/data/startup_repository.dart`
- Extension de `ChangeNotifier` pour la réactivité
- Stockage en mémoire : `List<Startup>`
- Méthodes CRUD : `add`, `update`, `remove`, `getById`
- Méthodes de filtre : `filterBySector(Sector?)`
- Méthodes de tri : `sortByYear(List, {ascending})`
- Méthode utilitaire : `countBySector(Sector)`
- Données d'exemple : 5 startups sénégalaises réelles

---

## Phase 3 — Design system

### Étape 8 : Création du thème
**Fichier :** `lib/theme/app_theme.dart`
- `ThemeData` complet avec Material 3
- `ColorScheme` personnalisé (primary: #2D9CDB, secondary: #F2994A)
- `TextTheme` avec Google Fonts Inter
- `CardTheme`, `ElevatedButtonTheme`, `InputDecorationTheme`
- `AppBarTheme`, `FloatingActionButtonTheme`, `ChipTheme`

### Étape 9 : Configuration des routes
**Fichier :** `lib/routes/app_router.dart`
- Routes nommées : `/` (liste), `/detail` (détail), `/form` (formulaire), `/about` (à propos)
- Utilisation de `onGenerateRoute` (exigence du cahier des charges)
- Passage d'arguments : objet `Startup` vers le détail, `Startup?` vers le formulaire

---

## Phase 4 — Composants réutilisables

### Étape 10 : StatsHeader
**Fichier :** `lib/widgets/stats_header.dart`
- Affiche le nombre total de startups
- Affiche la répartition par secteur (avec icônes)
- Animations lors des changements

### Étape 11 : StartupCard
**Fichier :** `lib/widgets/startup_card.dart`
- Carte élégante avec ombre subtile
- Affiche : icône secteur, nom, secteur (tag), ville, année
- Badge "Incubée" si applicable
- GestureDetector avec animation de scale au tap
- Hero pour animation de transition vers le détail

### Étape 12 : SectorTag
**Fichier :** `lib/widgets/sector_tag.dart`
- Tag coloré avec l'icône et le libellé du secteur
- Couleur adaptée à chaque secteur

### Étape 13 : IncubatedBadge
**Fichier :** `lib/widgets/incubated_badge.dart`
- Petit badge vert avec icône check et texte "Incubée"

### Étape 14 : EmptyState
**Fichier :** `lib/widgets/empty_state_widget.dart`
- Icône illustrative (fusée)
- Message "Aucune startup pour le moment"
- Sous-message "Ajoutez votre première startup !"
- Bouton d'action pour ajouter

### Étape 15 : ConfirmationDialog
**Fichier :** `lib/widgets/confirmation_dialog.dart`
- Dialogue Material Design avec:
  - Titre : "Confirmer la suppression"
  - Message : "Voulez-vous vraiment supprimer [nom] ?"
  - Boutons : "Annuler" et "Supprimer" (rouge)

---

## Phase 5 — Écrans

### Étape 16 : Écran Liste
**Fichier :** `lib/screens/startup_list_screen.dart`
- **Structure :**
  - `AppBar` avec titre et icône "À propos"
  - `StatsHeader` en haut du body
  - Filtres : `Wrap` de `ChoiceChip` pour chaque secteur
  - Tri : `PopupMenuButton` avec options "Année ↓", "Année ↑", "Nom A-Z"
  - `ListView.builder` avec `StartupCard` pour chaque élément
  - `EmptyState` quand liste vide
  - `FloatingActionButton` orange pour ajouter
- **État :** `StatefulWidget` avec `setState`
  - `selectedSector` : filtre actif (null = tous)
  - `sortAscending` : sens du tri
- **Interactions dynamiques :**
  - Filtre par secteur → mise à jour instantanée de la liste
  - Tri par année → re-tri instantané
  - Navigation vers détail au tap sur une carte
  - Navigation vers formulaire au tap sur FAB

### Étape 17 : Écran Détail
**Fichier :** `lib/screens/startup_detail_screen.dart`
- **Structure :**
  - `AppBar` avec nom de la startup + actions (modifier, supprimer)
  - Icône secteur large et centrée
  - Nom en grand
  - `SectorTag`
  - Informations structurées (ville, année, âge)
  - `IncubatedBadge` si incubée
  - Description (si présente)
- **Paramètres :** Reçoit l'objet `Startup` en argument
- **Actions :** Éditer → navigue vers form avec startup, Supprimer → dialogue

### Étape 18 : Écran Formulaire
**Fichier :** `lib/screens/startup_form_screen.dart`
- **Structure :**
  - `AppBar` avec "Ajouter" ou "Modifier" selon le contexte
  - `Form` avec `GlobalKey<FormState>`
  - `TextFormField` pour nom (validé : requis, 1-100)
  - `DropdownButtonFormField` pour secteur
  - `TextFormField` pour ville (validé : requis)
  - `TextFormField` pour année (validé : entier, 1900-2026)
  - `SwitchListTile` pour incubée
  - `TextFormField` multiligne pour description (max 500)
  - Bouton "Enregistrer" avec validation
- **Paramètres :** `startupToEdit` (nullable) → si fourni, pré-remplit le formulaire
- **Validation :** En temps réel, messages d'erreur précis
- **Soumission :** Appel à `add()` ou `update()` selon le mode

### Étape 19 : Écran À propos
**Fichier :** `lib/screens/about_screen.dart`
- Nom de l'étudiant : Moussa Ndao
- Titre du projet : Annuaire des startups et incubateurs
- ODD : 9 — Industrie, innovation et infrastructure
- Source des données : [à compléter par l'étudiant]
- Date de collecte : [à compléter par l'étudiant]
- Version de l'application

---

## Phase 6 — Finalisation

### Étape 20 : Configuration de l'app
**Fichier :** `lib/app.dart`
- `MaterialApp` avec `ThemeData` personnalisé
- `onGenerateRoute` pointant vers `AppRouter.generateRoute`
- `ChangeNotifierProvider` pour le repository

**Fichier :** `lib/main.dart`
- Point d'entrée avec `runApp`

### Étape 21 : Vérification et tests
- Vérification des 5 notions exigées (cf. checklist ci-dessous)
- Compilation sans erreur
- Test de tous les parcours CRUD
- Test de navigation entre les 3 écrans
- Vérification du passage d'arguments

---

## Checklist de conformité (cahier des charges)

| Exigence | Statut | Implémentation |
|---|---|---|
| **Classe modèle** avec constructeur + paramètres nommés | ✅ | `Startup` dans `models/startup.dart` |
| **Usage de List et Map** | ✅ | `List<Startup>` dans le repository |
| **Null safety** correcte | ✅ | `String? description` |
| **Au moins un enum** | ✅ | `Sector` dans `enums/startup_enums.dart` |
| **Méthode qui calcule** (total, moyenne, durée) | ✅ | `age` (getter), `countBySector`, `sortByYear` |
| **StatelessWidget présent** | ✅ | `SectorTag`, `IncubatedBadge`, `AboutScreen` |
| **StatefulWidget avec setState** | ✅ | `StartupListScreen` (filtre/tri), `StartupFormScreen` |
| **ThemeData personnalisé** | ✅ | `AppTheme.lightTheme` |
| **Widget réutilisable créé** | ✅ | `StartupCard`, `SectorTag`, `StatsHeader` |
| **CRUD complet** | ✅ | `add`, `read`, `update`, `delete` |
| **Formulaire avec validation** | ✅ | `StartupFormScreen` avec `FormState` |
| **Liste + Détail** | ✅ | Liste avec cartes, écran détail |
| **Modification (formulaire pré-rempli)** | ✅ | `startupToEdit` passé en argument |
| **Suppression avec dialogue de confirmation** | ✅ | `ConfirmationDialog` |
| **Stockage en mémoire** | ✅ | `StartupRepository` avec `ChangeNotifier` |
| **Au moins 3 écrans** | ✅ | Liste, Détail, Formulaire, À propos (4 écrans) |
| **Routes nommées / onGenerateRoute** | ✅ | `onGenerateRoute` dans `AppRouter` |
| **Passage d'arguments** | ✅ | Startup → Détail, Startup? → Formulaire |
| **Données réelles collectées** | ✅ | 10 startups sénégalaises réelles (voir `docs/05_donnees_collectees.md`) |
| **Écran À propos** | ✅ | Nom, source données, date collecte |
