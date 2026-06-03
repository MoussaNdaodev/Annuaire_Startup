import '../enums/startup_enums.dart';

class Startup {
  final String id;
  String nom;
  Sector secteur;
  String ville;
  int anneeCreation;
  bool incubee;
  String? description;

  Startup({
    required this.id,
    required this.nom,
    required this.secteur,
    required this.ville,
    required this.anneeCreation,
    this.incubee = false,
    this.description,
  });

  int get age => DateTime.now().year - anneeCreation;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'secteur': secteur.name,
        'ville': ville,
        'anneeCreation': anneeCreation,
        'incubee': incubee,
        'description': description,
      };

  factory Startup.fromJson(Map<String, dynamic> json) => Startup(
        id: json['id'] as String,
        nom: json['nom'] as String,
        secteur: Sector.fromString(json['secteur'] as String),
        ville: json['ville'] as String,
        anneeCreation: json['anneeCreation'] as int,
        incubee: json['incubee'] as bool? ?? false,
        description: json['description'] as String?,
      );

  Startup copyWith({
    String? nom,
    Sector? secteur,
    String? ville,
    int? anneeCreation,
    bool? incubee,
    String? description,
  }) {
    return Startup(
      id: id,
      nom: nom ?? this.nom,
      secteur: secteur ?? this.secteur,
      ville: ville ?? this.ville,
      anneeCreation: anneeCreation ?? this.anneeCreation,
      incubee: incubee ?? this.incubee,
      description: description ?? this.description,
    );
  }
}
