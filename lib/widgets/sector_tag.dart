import 'package:flutter/material.dart';
import '../enums/startup_enums.dart';
import '../theme/app_theme.dart';

class SectorTag extends StatelessWidget {
  final Sector sector;
  final bool compact;

  const SectorTag({super.key, required this.sector, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: sector.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(sector.emoji, style: TextStyle(fontSize: compact ? 12 : 14)),
          const SizedBox(width: 4),
          Text(
            sector.label,
            style: TextStyle(
              fontSize: compact ? 11 : 13,
              fontWeight: FontWeight.w600,
              color: sector.color,
            ),
          ),
        ],
      ),
    );
  }
}

class SectorChip extends StatelessWidget {
  final Sector sector;
  final bool selected;
  final VoidCallback onTap;

  const SectorChip({
    super.key,
    required this.sector,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? sector.color : sector.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? sector.color : sector.color.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              sector.emoji,
              style: TextStyle(fontSize: 14, color: selected ? Colors.white : sector.color),
            ),
            const SizedBox(width: 6),
            Text(
              sector.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : sector.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllSectorsChip extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const AllSectorsChip({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryBlue : AppTheme.primaryBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppTheme.primaryBlue : AppTheme.primaryBlue.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          'Tous',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppTheme.primaryBlue,
          ),
        ),
      ),
    );
  }
}
