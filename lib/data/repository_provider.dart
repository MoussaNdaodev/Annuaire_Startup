import 'package:flutter/material.dart';
import 'startup_repository.dart';

class RepositoryProvider extends InheritedWidget {
  final StartupRepository repository;

  const RepositoryProvider({
    super.key,
    required this.repository,
    required super.child,
  });

  static StartupRepository of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<RepositoryProvider>();
    if (provider == null) {
      throw FlutterError('RepositoryProvider introuvable dans le contexte');
    }
    return provider.repository;
  }

  @override
  bool updateShouldNotify(RepositoryProvider oldWidget) {
    return repository != oldWidget.repository;
  }
}
