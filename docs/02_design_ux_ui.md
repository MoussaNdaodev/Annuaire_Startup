# Design UX/UI — Annuaire des Startups et Incubateurs

## 1. Charte graphique

### 1.1 Palette de couleurs

```dart
// Couleurs principales
Primary Blue:    #2D9CDB  // Confiance, professionnalisme, technologie
Secondary Orange: #F2994A  // Dynamisme, innovation, énergie positive

// Couleurs fonctionnelles
Background:      #F8F9FA  // Fond clair, réduit la fatigue visuelle
Surface:         #FFFFFF  // Cartes et conteneurs
Text Primary:    #1A1A2E  // Contraste élevé pour la lisibilité
Text Secondary:  #6B7280  // Texte secondaire, labels
Success:         #10B981  // Vert pour les indicateurs positifs
Error:           #EF4444  // Rouge pour les erreurs et alertes

// Couleurs par secteur (pour les tags)
Fintech:         #2D9CDB  // Bleu — finance, technologie
Agritech:        #27AE60  // Vert — agriculture, nature
Edtech:          #9B59B6  // Violet — éducation, créativité
Autre:           #F2994A  // Orange — diversité, innovation
```

### 1.2 Typographie

- **Famille :** Inter (Google Fonts)
- **Hiérarchie :**

| Style | Taille | Poids | Usage |
|---|---|---|---|
| Headline Large | 28px | Bold (700) | Titre de page |
| Headline Medium | 22px | Semi-bold (600) | Sous-titres |
| Title Large | 18px | Semi-bold (600) | Titres de cartes |
| Title Medium | 16px | Medium (500) | Titres secondaires |
| Body Large | 16px | Regular (400) | Texte courant |
| Body Medium | 14px | Regular (400) | Texte secondaire |
| Label Large | 14px | Semi-bold (600) | Boutons, badges |

### 1.3 Espacements (base 8px)

| Token | Valeur | Usage |
|---|---|---|
| xs | 4px | Micro-espaces |
| sm | 8px | Petits écarts |
| md | 16px | Écart standard |
| lg | 24px | Sections |
| xl | 32px | Grands écarts |
| xxl | 48px | Héros, sections majeures |

### 1.4 Ombres (elevation)

| Niveau | Valeur | Usage |
|---|---|---|
| Subtile | 0 2px 4px rgba(0,0,0,0.06) | Cartes au repos |
| Moyenne | 0 4px 12px rgba(0,0,0,0.08) | Cartes survolées, FAB |
| Forte | 0 8px 24px rgba(0,0,0,0.12) | Modals, dialogues |

### 1.5 Bordures et coins (border radius)

| Token | Valeur | Usage |
|---|---|---|
| sm | 8px | Boutons, inputs |
| md | 12px | Champs de formulaire |
| lg | 16px | Cartes, conteneurs |
| xl | 24px | Modales |
| full | 999px | Badges, pills |

---

## 2. Principes UX appliqués

### 2.1 Les 10 heuristiques de Nielsen

| Heuristique | Application dans l'app |
|---|---|
| **Visibilité de l'état du système** | Stats header mis à jour en temps réel, snackbar après chaque action CRUD, badge "incubée" visible |
| **Correspondance monde réel** | Icônes sectorielles évocatrices (💳 Fintech, 🌱 Agritech, 📚 Edtech, 🚀 Autre), langage naturel |
| **Contrôle et liberté** | Bouton retour dans l'appbar, dialogue de confirmation avant suppression, formulaire annulable |
| **Cohérence et standards** | Même palette, typo, espacements sur tous les écrans ; conventions Material Design respectées |
| **Prévention des erreurs** | Validation de formulaire en temps réel, champs obligatoires marqués, sélecteur pour secteur (pas de texte libre) |
| **Reconnaissance plutôt que mémorisation** | Filtres visibles sous forme de chips, tri accessible en un clic, toutes les actions dans l'appbar |
| **Flexibilité et efficacité** | Filtre par secteur + tri par année combinables, FAB pour ajout rapide |
| **Design esthétique et minimal** | Interface épurée, pas d'informations superflues, hiérarchie visuelle claire |
| **Aide à la reconnaissance des erreurs** | Messages d'erreur précis dans le formulaire (ex: "Le nom est requis"), couleur rouge pour les champs invalides |
| **Aide et documentation** | Écran À propos, labels clairs, placeholder dans les champs |

### 2.2 Accessibilité

- Contraste des couleurs conforme WCAG AA minimum
- Zones tactiles d'au moins 48x48px
- Polices de taille suffisante (min 14px)
- Icônes accompagnées de texte ou de label sémantique
- Feedback visuel et haptique sur les interactions

### 2.3 Micro-interactions

| Interaction | Feedback |
|---|---|
| Appui sur une carte | Scale léger + ombre renforcée |
| Ajout d'une startup | Snackbar de confirmation + animation d'entrée dans la liste |
| Suppression | Dialogue de confirmation → snackbar annulation |
| Filtre actif | Chip surlignée, liste animée |
| Tri | Changement d'icône, liste re-triée |

---

## 3. Architecture de l'information

```
Annuaire Startups
├── Écran Liste (accueil)
│   ├── Stats header (total, répartition)
│   ├── Barre de filtres (chips secteur)
│   ├── Bouton de tri (année)
│   └── Liste des startups
│       └── Carte startup (nom, secteur, ville, année, badge incubée)
├── Écran Détail
│   ├── En-tête (nom, icône secteur)
│   ├── Informations (ville, année, âge)
│   ├── Badge incubée
│   ├── Description
│   └── Actions (modifier, supprimer)
├── Écran Formulaire (Ajout / Modification)
│   ├── Champ nom
│   ├── Sélecteur secteur
│   ├── Champ ville
│   ├── Champ année
│   ├── Switch incubée
│   ├── Champ description (multiligne)
│   └── Bouton enregistrer
└── Écran À propos
    ├── Nom de l'étudiant
    ├── Source des données
    └── Date de collecte
```

---

## 4. Wireframes (description textuelle)

### 4.1 Écran Liste

```
┌─────────────────────────────────────────────┐
│  ←  Annuaire Startups            ℹ️          │  AppBar
├─────────────────────────────────────────────┤
│  12 startups · 4 Fintech · 3 Agritech ...   │  Stats
├─────────────────────────────────────────────┤
│ [Tous] [Fintech] [Agritech] [Edtech] [Autre]│  Filtres
│                               🔽 Année ↓     │  Tri
├─────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────┐ │
│ │ 💳 Wave                          ⏺     │ │  Carte
│ │ Fintech · Dakar · 2018                  │ │
│ └─────────────────────────────────────────┘ │
│ ┌─────────────────────────────────────────┐ │
│ │ 🌱 Lomart                          ⏺   │ │  Carte
│ │ Agritech · Thiès · 2020                │ │
│ └─────────────────────────────────────────┘ │
│ ...                                         │
├─────────────────────────────────────────────┤
│                          [+ 🚀]             │  FAB
└─────────────────────────────────────────────┘
```

### 4.2 Écran Détail

```
┌─────────────────────────────────────────────┐
│  ←  Wave                          ✏️ 🗑️    │  AppBar
├─────────────────────────────────────────────┤
│                                             │
│              💳                             │  Icône secteur
│                                             │
│           Wave                              │  Nom
│      Application Fintech                    │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ 📍 Dakar              🏢 2018      │   │  Infos
│  │                                7 ans │   │
│  └─────────────────────────────────────┘   │
│                                             │
│              ✅ Incubée                      │  Badge
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │ Description                          │   │  Description
│  │ Application de transfert d'argent    │   │
│  │ mobile pour l'Afrique de l'Ouest     │   │
│  └─────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

### 4.3 Écran Formulaire

```
┌─────────────────────────────────────────────┐
│  ←  Ajouter une startup                     │  AppBar
├─────────────────────────────────────────────┤
│                                             │
│  Nom de la startup *                        │
│  ┌─────────────────────────────────────┐   │
│  │ Ex: Wave                             │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  Secteur *                                  │
│  ┌─────────────────────────────────────┐   │
│  │ 💳 Fintech                     ▼    │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  Ville *                                    │
│  ┌─────────────────────────────────────┐   │
│  │ Ex: Dakar                            │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  Année de création *                        │
│  ┌─────────────────────────────────────┐   │
│  │ Ex: 2020                             │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  Incubée                            [🔘]   │
│                                             │
│  Description                                │
│  ┌─────────────────────────────────────┐   │
│  │ Description de la startup...         │   │
│  │                                     │   │
│  └─────────────────────────────────────┘   │
│                                             │
│  ┌─────────────────────────────────────┐   │
│  │         💾 Enregistrer               │   │
│  └─────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

---

## 5. Composants UI

| Composant | Fichier | Rôle |
|---|---|---|
| `StartupCard` | `widgets/startup_card.dart` | Carte réutilisable affichant le résumé d'une startup |
| `SectorTag` | `widgets/sector_tag.dart` | Tag coloré indiquant le secteur d'activité |
| `IncubatedBadge` | `widgets/incubated_badge.dart` | Badge "Incubée" avec icône check |
| `StatsHeader` | `widgets/stats_header.dart` | Bandeau statistique (total, répartition) |
| `EmptyState` | `widgets/empty_state_widget.dart` | État vide illustré quand aucune startup |
| `ConfirmationDialog` | `widgets/confirmation_dialog.dart` | Dialogue de confirmation avant suppression |

---

## 6. Parcours utilisateur (User Flow)

```
Accueil (Liste)
  ├── ➕ Appuyer sur FAB
  │     └── Formulaire d'ajout
  │           └── ✅ Enregistrer → Retour liste (snackbar confirmation)
  │
  ├── 🔍 Appuyer sur une carte
  │     └── Écran détail
  │           ├── ✏️ Modifier → Formulaire pré-rempli → ✅ → Retour détail
  │           └── 🗑️ Supprimer → Dialogue confirmation → ✅ → Retour liste
  │
  ├── 🔽 Changer le tri
  │     └── Liste re-triée instantanément
  │
  ├── 🏷️ Sélectionner un filtre secteur
  │     └── Liste filtrée instantanément
  │
  └── ℹ️ Appuyer sur info
        └── Écran À propos
```

---

## 7. Identité visuelle

- **Icône d'application :** 🚀 (fusée) — symbole d'innovation et de croissance
- **Nom :** StartUp Sénégal — simple, localisé, identifiable
- **Ton :** Professionnel, moderne, confiant, ancré dans l'écosystème sénégalais
