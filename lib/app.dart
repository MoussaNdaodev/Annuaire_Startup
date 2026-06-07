import 'package:flutter/material.dart';
import 'data/repository_provider.dart';
import 'data/startup_repository.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

class StartupApp extends StatefulWidget {
  const StartupApp({super.key});

  @override
  State<StartupApp> createState() => _StartupAppState();
}

class _StartupAppState extends State<StartupApp> {
  final StartupRepository _repository = StartupRepository();
  bool _initialized = false;
  String? _initError;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _repository.init();
    } catch (e) {
      if (mounted) setState(() => _initError = e.toString());
      return;
    }
    if (mounted) setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Annuaire Startups',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.list,
      builder: (context, child) {
        if (!_initialized) {
          return Scaffold(
            body: Center(
              child: _initError != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: AppTheme.error),
                        const SizedBox(height: 16),
                        Text('Erreur de chargement : $_initError'),
                      ],
                    )
                  : const CircularProgressIndicator(),
            ),
          );
        }
        return RepositoryProvider(repository: _repository, child: child!);
      },
    );
  }
}
