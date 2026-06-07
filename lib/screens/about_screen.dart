import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildHeader(),
            const SizedBox(height: 24),
            _buildInfoCard(),
            const SizedBox(height: 16),
            _buildDataCard(),
            const SizedBox(height: 16),
            _buildProjectCard(),
            const SizedBox(height: 24),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text('🚀', style: TextStyle(fontSize: 40)),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Annuaire Startups',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Répertoire des startups et incubateurs sénégalais',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return _Card(
      children: [
        _CardRow(label: 'Étudiant', value: 'Moussa Ndao'),
        const Divider(height: 20),
        _CardRow(label: 'ODD', value: '9 — Industrie, innovation et infrastructure'),
        const Divider(height: 20),
        _CardRow(label: 'Promotion', value: 'DAR26'),
        const Divider(height: 20),
        _CardRow(label: 'Module', value: 'Développement Multiplateforme'),
        const Divider(height: 20),
        _CardRow(label: 'Version', value: '1.0.0'),
      ],
    );
  }

  Widget _buildDataCard() {
    return _Card(
      children: [
        const Row(
          children: [
            Icon(Icons.storage_outlined, size: 18, color: AppTheme.textSecondary),
            SizedBox(width: 8),
            Text(
              'Données',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
        const Divider(height: 16),
        _CardRow(label: 'Source', value: 'Startup Sénégal, CTO, Digital Business Africa'),
        const SizedBox(height: 10),
        _CardRow(label: 'Date de collecte', value: 'Juin 2026'),
      ],
    );
  }

  Widget _buildProjectCard() {
    return _Card(
      children: [
        const Row(
          children: [
            Icon(Icons.assignment_outlined, size: 18, color: AppTheme.textSecondary),
            SizedBox(width: 8),
            Text(
              'Projet',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
        const Divider(height: 16),
        const Text(
          'Application Flutter réalisée dans le cadre du module de développement multiplateforme, '
          'promotion DAR26 à l\'ESMT. Elle répertorie les startups et incubateurs '
          'de l\'écosystème numérique sénégalais en lien avec l\'ODD 9.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        'ESMT • 2026',
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final List<Widget> children;

  const _Card({required this.children});

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
        children: children,
      ),
    );
  }
}

class _CardRow extends StatelessWidget {
  final String label;
  final String value;

  const _CardRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
