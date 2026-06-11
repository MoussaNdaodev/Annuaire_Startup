# Packages utilisés — Annuaire des Startups et Incubateurs

## Liste des dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^8.1.0
  uuid: ^4.5.3
  shared_preferences: ^2.3.4
```

---

## 1. `google_fonts` — Typographie

**Version :** ^8.1.0  
**Lien :** https://pub.dev/packages/google_fonts

### Justification
La typographie est un élément fondamental du design UI. Plutôt que d'utiliser la typographie par défaut de Flutter (Roboto), ce package permet d'utiliser la police **Inter**, reconnue pour :
- Son excellente lisibilité sur écran (optimisée pour les interfaces)
- Son large éventail de graisses (Regular, Medium, Semi-bold, Bold)
- Son aspect moderne et professionnel
- Sa gratuité (licence SIL Open Font)

### Usage dans le projet
```dart
TextTheme: GoogleFonts.interTextTheme().copyWith(
  headlineLarge: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700),
  // ...
)
```

### Alternative non retenue
- **Roboto (par défaut)** : Trop commune, ne se démarque pas
- **Poppins** : Très belle mais moins lisible en corps de texte
- **Manrope** : Bonne alternative, mais Inter offre une meilleure couverture de graisses

---

## 2. `uuid` — Identifiants uniques

**Version :** ^4.5.3  
**Lien :** https://pub.dev/packages/uuid

### Justification
Chaque startup doit être identifiée de manière unique. UUID v4 garantit :
- L'unicité sans collision, même sans base de données
- Un format standard (36 caractères, ex: `a1b2c3d4-e5f6-7890-abcd-ef1234567890`)
- Pas besoin de compteur ou d'auto-incrémentation

### Usage dans le projet
```dart
final _uuid = const Uuid();
final id = _uuid.v4(); // Généré à chaque ajout de startup
```

### Alternative non retenue
- **Incrémentation manuelle** : Fragile, pas de persistance entre sessions
- **DateTime**.millisecondsSinceEpoch : Risque de collision en cas d'ajouts simultanés
- **nanoid** : Plus léger mais moins standard

---

## 3. `shared_preferences` — Persistance locale

**Version :** ^2.3.4  
**Lien :** https://pub.dev/packages/shared_preferences

### Justification
Le cahier des charges accepte le stockage en mémoire, mais `shared_preferences` a été ajouté pour offrir une persistance minimale : les startups ajoutées par l'utilisateur survivent au redémarrage de l'application. C'est un bonus qui améliore l'expérience utilisateur sans alourdir le projet avec une base de données complète.

### Usage dans le projet
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString(_storageKey, json);
final json = prefs.getString(_storageKey);
```

### Alternative non retenue
- **sqflite** : Trop lourd pour un simple annuaire (nécessite schéma, migrations)
- **hive** : Performant mais dépendance supplémentaire ; shared_preferences est déjà dans le SDK Flutter
- **Aucune persistance** : Les données sont perdues au redémarrage, mauvaise UX

---

## Packages volontairement non utilisés (et pourquoi)

| Package | Raison de l'exclusion |
|---|---|
| `provider` / `riverpod` | Le cahier des charges exige `setState` pour la gestion d'état ; in-memory + ChangeNotifier suffit |
| `sqflite` | Trop lourd pour ce projet ; `shared_preferences` est utilisé à la place pour une persistance minimale |
| `go_router` | Le cahier des charges exige `onGenerateRoute` avec routes nommées |
| `flutter_animate` / `animations` | Les animations natives (AnimatedContainer, AnimatedOpacity, Hero) suffisent sans dépendance supplémentaire |
| `build_runner` / `json_serializable` | Pas de sérialisation JSON nécessaire (stockage en mémoire) |
| `equatable` | La comparaison d'objets se fait par ID, pas besoin de surcharge |
| `flutter_svg` | Pas d'icônes SVG nécessaires (émojis + icônes Material suffisent) |

---

## Politique de versionnement

- Les versions sont fixées avec `^` (compatible) pour bénéficier des corrections de bugs mineurs
- Aucun package de génération de code ou de build runner n'est utilisé
- Tous les packages sont stables (version majeure ≥ 1.0.0)

---

## Impact sur la taille de l'application

| Package | Taille estimée |
|---|---|
| `google_fonts` | ~200 KB (cache des polices) |
| `uuid` | ~50 KB |
| `shared_preferences` | ~50 KB |

**Total estimé :** ~300 KB (négligeable par rapport à la taille d'une app Flutter standard)
