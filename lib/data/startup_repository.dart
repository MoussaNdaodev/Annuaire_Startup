import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../enums/startup_enums.dart';
import '../models/startup.dart';
import 'repository_provider.dart';

class StartupRepository extends ChangeNotifier {
  static const String _storageKey = 'startups';

  static StartupRepository of(BuildContext context) {
    return RepositoryProvider.of(context);
  }

  final List<Startup> _startups = [];
  final _uuid = const Uuid();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await _loadData();
    if (_startups.isEmpty) {
      _addSampleData();
      await _saveData();
    }
    _initialized = true;
  }

  void _addSampleData() {
    _startups.addAll([
      Startup(
        id: _uuid.v4(),
        nom: 'Wave',
        secteur: Sector.fintech,
        ville: 'Dakar',
        anneeCreation: 2018,
        incubee: false,
        description:
            'Application mobile de transfert d\'argent et services financiers. Leader du mobile money en Afrique de l\'Ouest.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'Mlouma',
        secteur: Sector.agritech,
        ville: 'Dakar',
        anneeCreation: 2012,
        incubee: true,
        description:
            'Plateforme numérique agricole : météo, prix du marché, e-learning, marketplace Louma Mbay.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'Starlink',
        secteur: Sector.other,
        ville: 'Dakar (national)',
        anneeCreation: 2026,
        incubee: false,
        description:
            'Fournisseur Internet satellitaire. Objectif : connecter 1M de Sénégalais et réduire les zones blanches.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'Volkeno',
        secteur: Sector.other,
        ville: 'Dakar',
        anneeCreation: 2015,
        incubee: true,
        description:
            'Startup studio numérique. +200 projets réalisés. Ambition : créer 1000 startups africaines en 10 ans.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'PayDunya',
        secteur: Sector.fintech,
        ville: 'Dakar',
        anneeCreation: 2016,
        incubee: false,
        description:
            'Solutions de paiement en ligne pour entreprises africaines. API de paiement et facturation électronique.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'Cauridor',
        secteur: Sector.fintech,
        ville: 'Dakar',
        anneeCreation: 2019,
        incubee: true,
        description:
            'Plateforme de microcrédit et inclusion financière pour PME et particuliers.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'SuyuTech',
        secteur: Sector.agritech,
        ville: 'Thiès',
        anneeCreation: 2020,
        incubee: true,
        description:
            'Solutions digitales pour la traçabilité et la gestion des exploitations agricoles.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'Keewu',
        secteur: Sector.other,
        ville: 'Dakar',
        anneeCreation: 2017,
        incubee: true,
        description:
            'Startup culturelle et créative. Production audiovisuelle et diffusion numérique.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'Kamerpower',
        secteur: Sector.edtech,
        ville: 'Dakar',
        anneeCreation: 2019,
        incubee: true,
        description:
            'Plateforme éducative avec cours en ligne, mentorat et orientation académique.',
      ),
      Startup(
        id: _uuid.v4(),
        nom: 'BaySeddo',
        secteur: Sector.agritech,
        ville: 'Dakar',
        anneeCreation: 2015,
        incubee: true,
        description:
            'Coopérative digitale permettant aux citadins d\'investir dans des exploitations agricoles.',
      ),
    ]);
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(_startups.map((s) => s.toJson()).toList());
    await prefs.setString(_storageKey, json);
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_storageKey);
    if (json == null || json.isEmpty) return;
    final list = jsonDecode(json) as List<dynamic>;
    _startups.addAll(list.map((e) => Startup.fromJson(e as Map<String, dynamic>)));
  }

  List<Startup> get startups => List.unmodifiable(_startups);

  int get count => _startups.length;

  Startup? getById(String id) {
    try {
      return _startups.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> add({
    required String nom,
    required Sector secteur,
    required String ville,
    required int anneeCreation,
    bool incubee = false,
    String? description,
  }) async {
    _startups.add(Startup(
      id: _uuid.v4(),
      nom: nom,
      secteur: secteur,
      ville: ville,
      anneeCreation: anneeCreation,
      incubee: incubee,
      description: description,
    ));
    notifyListeners();
    await _saveData();
  }

  Future<void> update(Startup startup) async {
    final index = _startups.indexWhere((s) => s.id == startup.id);
    if (index != -1) {
      _startups[index] = startup;
      notifyListeners();
      await _saveData();
    }
  }

  Future<void> remove(String id) async {
    _startups.removeWhere((s) => s.id == id);
    notifyListeners();
    await _saveData();
  }

  List<Startup> filterBySector(List<Startup> list, Sector? sector) {
    if (sector == null) return list;
    return list.where((s) => s.secteur == sector).toList();
  }

  List<Startup> sortByYear(List<Startup> list, {bool ascending = false}) {
    final sorted = List<Startup>.from(list);
    sorted.sort(
      (a, b) =>
          ascending
              ? a.anneeCreation.compareTo(b.anneeCreation)
              : b.anneeCreation.compareTo(a.anneeCreation),
    );
    return sorted;
  }

  List<Startup> searchByName(String query) {
    if (query.isEmpty) return _startups;
    final lower = query.toLowerCase();
    return _startups.where((s) => s.nom.toLowerCase().contains(lower)).toList();
  }

  int countBySector(Sector sector) {
    return _startups.where((s) => s.secteur == sector).length;
  }

  int get incubatedCount => _startups.where((s) => s.incubee).length;
}
