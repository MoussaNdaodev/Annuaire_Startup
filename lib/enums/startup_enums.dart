import 'package:flutter/material.dart';

enum Sector {
  fintech('Fintech', '💳', Color(0xFF2D9CDB)),
  agritech('Agritech', '🌱', Color(0xFF27AE60)),
  edtech('Edtech', '📚', Color(0xFF9B59B6)),
  other('Autre', '🚀', Color(0xFFF2994A));

  final String label;

  final String emoji;
  final Color color;

  const Sector(this.label, this.emoji, this.color);

  static Sector fromString(String value) {
    return Sector.values.firstWhere(
      (s) => s.name == value,
      orElse: () => Sector.other,
    );
  }
}
