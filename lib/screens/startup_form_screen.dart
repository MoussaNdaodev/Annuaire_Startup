import 'package:flutter/material.dart';
import '../data/startup_repository.dart';
import '../enums/startup_enums.dart';
import '../models/startup.dart';
import '../theme/app_theme.dart';

class StartupFormScreen extends StatefulWidget {
  final Startup? startupToEdit;

  const StartupFormScreen({super.key, this.startupToEdit});

  @override
  State<StartupFormScreen> createState() => _StartupFormScreenState();
}

class _StartupFormScreenState extends State<StartupFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomController;
  late final TextEditingController _villeController;
  late final TextEditingController _anneeController;
  late final TextEditingController _descriptionController;
  late Sector _secteur;
  late bool _incubee;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.startupToEdit != null;
    final startup = widget.startupToEdit;

    _nomController = TextEditingController(text: startup?.nom ?? '');
    _villeController = TextEditingController(text: startup?.ville ?? '');
    _anneeController = TextEditingController(
      text: startup?.anneeCreation.toString() ?? '',
    );
    _descriptionController = TextEditingController(text: startup?.description ?? '');
    _secteur = startup?.secteur ?? Sector.fintech;
    _incubee = startup?.incubee ?? false;
  }

  @override
  void dispose() {
    _nomController.dispose();
    _villeController.dispose();
    _anneeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final repository = StartupRepository.of(context);
    final nom = _nomController.text.trim();
    final ville = _villeController.text.trim();
    final annee = int.parse(_anneeController.text.trim());
    final description = _descriptionController.text.trim();

    if (_isEditing) {
      final updated = widget.startupToEdit!.copyWith(
        nom: nom,
        secteur: _secteur,
        ville: ville,
        anneeCreation: annee,
        incubee: _incubee,
        description: description.isEmpty ? null : description,
      );
      await repository.update(updated);
    } else {
      await repository.add(
        nom: nom,
        secteur: _secteur,
        ville: ville,
        anneeCreation: annee,
        incubee: _incubee,
        description: description.isEmpty ? null : description,
      );
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isEditing ? 'Startup modifiée avec succès' : 'Startup ajoutée avec succès'),
        backgroundColor: AppTheme.success,
      ),
    );

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Modifier la startup' : 'Ajouter une startup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionLabel(label: 'Informations générales'),
              const SizedBox(height: 12),
              _buildNomField(),
              const SizedBox(height: 16),
              _buildSecteurField(),
              const SizedBox(height: 16),
              _buildVilleField(),
              const SizedBox(height: 16),
              _buildAnneeField(),
              const SizedBox(height: 20),
              _buildIncubeeSwitch(),
              const SizedBox(height: 24),
              _SectionLabel(label: 'Description (optionnelle)'),
              const SizedBox(height: 12),
              _buildDescriptionField(),
              const SizedBox(height: 32),
              _buildSubmitButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNomField() {
    return TextFormField(
      controller: _nomController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'Nom de la startup *',
        hintText: 'Ex: Wave, Lomart, PayDunya...',
        prefixIcon: Icon(Icons.business_outlined),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le nom est requis';
        }
        if (value.trim().length > 100) {
          return 'Le nom ne peut pas dépasser 100 caractères';
        }
        return null;
      },
    );
  }

  Widget _buildSecteurField() {
    return DropdownButtonFormField<Sector>(
      initialValue: _secteur,
      decoration: const InputDecoration(
        labelText: 'Secteur *',
        prefixIcon: Icon(Icons.category_outlined),
      ),
      items: Sector.values.map((sector) {
        return DropdownMenuItem(
          value: sector,
          child: Row(
            children: [
              Text(sector.emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Text(sector.label),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) setState(() => _secteur = value);
      },
      validator: (value) => value == null ? 'Le secteur est requis' : null,
    );
  }

  Widget _buildVilleField() {
    return TextFormField(
      controller: _villeController,
      textCapitalization: TextCapitalization.words,
      decoration: const InputDecoration(
        labelText: 'Ville *',
        hintText: 'Ex: Dakar, Thiès, Saint-Louis...',
        prefixIcon: Icon(Icons.location_on_outlined),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'La ville est requise';
        }
        return null;
      },
    );
  }

  Widget _buildAnneeField() {
    final currentYear = DateTime.now().year;
    return TextFormField(
      controller: _anneeController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Année de création *',
        hintText: 'Ex: 2020',
        prefixIcon: const Icon(Icons.calendar_today_outlined),
        suffixText: '(1900 - $currentYear)',
        suffixStyle: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'L\'année de création est requise';
        }
        final year = int.tryParse(value.trim());
        if (year == null) {
          return 'Veuillez entrer une année valide';
        }
        if (year < 1900 || year > currentYear) {
          return 'L\'année doit être entre 1900 et $currentYear';
        }
        return null;
      },
    );
  }

  Widget _buildIncubeeSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Material(
        color: Colors.transparent,
        child: SwitchListTile(
          value: _incubee,
          onChanged: (value) => setState(() => _incubee = value),
          title: const Text(
            'Incubée',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitle: const Text(
            'La startup bénéficie-t-elle d\'un programme d\'incubation ?',
            style: TextStyle(fontSize: 12),
          ),
          activeTrackColor: AppTheme.success,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 4,
      maxLength: 500,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'Description',
        hintText: 'Décrivez la startup, sa mission, son impact...',
        alignLabelWithHint: true,
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: Icon(Icons.description_outlined),
        ),
      ),
      validator: (value) {
        if (value != null && value.length > 500) {
          return 'La description ne peut pas dépasser 500 caractères';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: _submit,
        icon: Icon(_isEditing ? Icons.save_outlined : Icons.add_circle_outline),
        label: Text(_isEditing ? 'Enregistrer les modifications' : 'Ajouter cette startup'),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
