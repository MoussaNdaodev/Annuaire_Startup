# Modélisation Merise — Annuaire des Startups et Incubateurs

## 1. Règles de gestion

| RG | Énoncé |
|---|---|
| RG01 | Une startup est identifiée de manière unique par un identifiant (UUID) |
| RG02 | Une startup a obligatoirement un nom (1-100 caractères) |
| RG03 | Une startup appartient à un et un seul secteur parmi : Fintech, Agritech, Edtech, Autre |
| RG04 | Une startup est obligatoirement située dans une ville |
| RG05 | Une startup a obligatoirement une année de création comprise entre 1900 et l'année en cours |
| RG06 | Une startup peut être incubée ou non |
| RG07 | Une startup peut avoir une description optionnelle (max 500 caractères) |
| RG08 | La liste des startups peut être filtrée par secteur |
| RG09 | La liste des startups peut être triée par année de création (ascendant/descendant) |
| RG10 | La suppression d'une startup doit être précédée d'une confirmation |

## 2. Dictionnaire des données

| Champ | Type | Taille | Contrainte | Description |
|---|---|---|---|---|
| id | Chaîne | 36 | PK, UUID v4 | Identifiant unique |
| nom | Chaîne | 1-100 | NOT NULL | Nom de la startup |
| secteur | Énumération | - | NOT NULL, 4 valeurs | Secteur d'activité |
| ville | Chaîne | 1-100 | NOT NULL | Ville d'implantation |
| anneeCreation | Entier | 4 | NOT NULL, 1900-2026 | Année de création |
| incubee | Booléen | - | NOT NULL, défaut: false | Statut d'incubation |
| description | Chaîne | 0-500 | NULLABLE | Description de la startup |

### Valeurs de l'énumération `Secteur`

| Code | Libellé |
|---|---|
| fintech | Fintech |
| agritech | Agritech |
| edtech | Edtech |
| autre | Autre |

## 3. Modèle Conceptuel de Données (MCD)

```
┌─────────────────────────────┐
│          STARTUP            │
├─────────────────────────────┤
│ *id (PK)                    │
│ *nom                        │
│ *secteur                    │
│ *ville                      │
│ *anneeCreation              │
│  incubee                    │
│  description                │
└─────────────────────────────┘
```

## 4. Modèle Logique de Données (MLD)

**STARTUP** (id, nom, secteur, ville, anneeCreation, incubee, description)
- Clé primaire : id
- `secteur` contraint aux valeurs : 'fintech', 'agritech', 'edtech', 'autre'

## 5. Modèle Physique (implémentation Flutter/Dart)

La classe Dart `Startup` (cf. `lib/models/startup.dart`) implémente directement ce modèle :

```dart
class Startup {
  final String id;
  String nom;
  Sector secteur;
  String ville;
  int anneeCreation;
  bool incubee;
  String? description;
}
```

L'énumération `Sector` (cf. `lib/enums/startup_enums.dart`) :

```dart
enum Sector {
  fintech('Fintech', '💳'),
  agritech('Agritech', '🌱'),
  edtech('Edtech', '📚'),
  other('Autre', '🚀');
}
```

## 6. Contraintes et validations

| Champ | Validation |
|---|---|
| nom | Requis, longueur 1-100 |
| secteur | Requis, doit être une valeur valide de l'énum |
| ville | Requis, longueur 1-100 |
| anneeCreation | Requis, min 1900, max année courante |
| description | Optionnel, max 500 caractères |

## 7. Opérations CRUD

| Opération | Description | Méthode |
|---|---|---|
| Create | Ajouter une nouvelle startup | `add(Startup)` |
| Read | Lister toutes les startups / filtrer / trier | `startups`, `filterBySector()`, `sortByYear()` |
| Read | Obtenir une startup par son ID | `getById(String)` |
| Update | Modifier une startup existante | `update(Startup)` |
| Delete | Supprimer une startup | `remove(String)` |
