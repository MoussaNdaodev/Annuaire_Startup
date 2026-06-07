import 'package:flutter/material.dart';
import '../data/startup_repository.dart';
import '../models/startup.dart';
import '../routes/app_router.dart';
import '../theme/app_theme.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/incubated_badge.dart';
import '../widgets/sector_tag.dart';

class StartupDetailScreen extends StatelessWidget {
  final Startup startup;

  const StartupDetailScreen({super.key, required this.startup});

  @override
  Widget build(BuildContext context) {
    final repository = StartupRepository.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(startup.nom),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppTheme.primaryBlue),
            tooltip: 'Modifier',
            onPressed: () async {
              final updated = await Navigator.pushNamed(
                context,
                AppRouter.form,
                arguments: startup,
              );
              if (updated != null && context.mounted) {
                final updatedStartup = repository.getById(startup.id);
                if (updatedStartup != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Startup modifiée avec succès')),
                  );
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: AppTheme.error),
            tooltip: 'Supprimer',
            onPressed: () => _confirmDelete(context, repository),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _HeaderSection(startup: startup),
            const SizedBox(height: 16),
            _InfoSection(startup: startup),
            if (startup.description != null && startup.description!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _DescriptionSection(description: startup.description!),
            ],
            const SizedBox(height: 16),
            _DataSourceHint(),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, StartupRepository repository) async {
    final confirmed = await ConfirmationDialog.show(
      context,
      message: 'Voulez-vous vraiment supprimer "${startup.nom}" ? Cette action est irréversible.',
      confirmLabel: 'Supprimer',
    );
    if (confirmed == true && context.mounted) {
      await repository.remove(startup.id);
      if (!context.mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${startup.nom}" a été supprimé')),
      );
    }
  }
}

class _HeaderSection extends StatelessWidget {
  final Startup startup;

  const _HeaderSection({required this.startup});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: startup.secteur.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(startup.secteur.emoji, style: const TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            startup.nom,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          SectorTag(sector: startup.secteur),
          if (startup.incubee) ...[
            const SizedBox(height: 10),
            const IncubatedBadge(),
          ],
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final Startup startup;

  const _InfoSection({required this.startup});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Ville',
            value: startup.ville,
          ),
          const Divider(height: 24),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Année de création',
            value: '${startup.anneeCreation}',
          ),
          const Divider(height: 24),
          _InfoRow(
            icon: Icons.timeline_outlined,
            label: 'Âge',
            value: '${startup.age} an${startup.age > 1 ? 's' : ''}',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: AppTheme.primaryBlue),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final String description;

  const _DescriptionSection({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description_outlined, size: 20, color: AppTheme.textSecondary),
              SizedBox(width: 8),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppTheme.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _DataSourceHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 18, color: AppTheme.success),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              '10 startups senegalaises reelles collectees en juin 2026.',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
