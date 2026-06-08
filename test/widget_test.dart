import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:annuaire_startup/app.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App affiche la liste des startups apres chargement', (WidgetTester tester) async {
    await tester.pumpWidget(const StartupApp());
    await tester.pumpAndSettle();

    expect(find.text('Annuaire Startups'), findsOneWidget);
    expect(find.textContaining('startup'), findsWidgets);
  });

  testWidgets('Le FAB d\'ajout est visible', (WidgetTester tester) async {
    await tester.pumpWidget(const StartupApp());
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Navigation vers ecran A propos', (WidgetTester tester) async {
    await tester.pumpWidget(const StartupApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('À propos'), findsOneWidget);
    expect(find.text('Moussa Ndao'), findsOneWidget);
  });

  testWidgets('Navigation vers le formulaire d\'ajout', (WidgetTester tester) async {
    await tester.pumpWidget(const StartupApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Ajouter une startup'), findsOneWidget);
  });

  testWidgets('Validation du formulaire - champs vides', (WidgetTester tester) async {
    await tester.pumpWidget(const StartupApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(Form), const Offset(0, -300));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ajouter cette startup'));
    await tester.pumpAndSettle();

    expect(find.text('Le nom est requis'), findsOneWidget);
    expect(find.text('La ville est requise'), findsOneWidget);
  });
}
