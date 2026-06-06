import 'package:flutter/material.dart';
import '../data/startup_repository.dart';
import '../enums/startup_enums.dart';
import '../models/startup.dart';
import '../routes/app_router.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/sector_tag.dart';
import '../widgets/startup_card.dart';
import '../widgets/stats_header.dart';

class StartupListScreen extends StatefulWidget {
  const StartupListScreen({super.key});

  @override
  State<StartupListScreen> createState() => _StartupListScreenState();
}

class _StartupListScreenState extends State<StartupListScreen> {
  Sector? _selectedSector;
  bool _sortAscending = false;
  late StartupRepository _repository;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  bool _listening = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repository = StartupRepository.of(context);
    if (!_listening) {
      _repository.addListener(_onDataChanged);
      _listening = true;
    }
  }

  @override
  void dispose() {
    _repository.removeListener(_onDataChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onDataChanged() {
    setState(() {});
  }

  List<Startup> get _filteredAndSortedStartups {
    var startups = _repository.searchByName(_searchQuery);
    startups = _repository.filterBySector(startups, _selectedSector);
    return _repository.sortByYear(startups, ascending: _sortAscending);
  }

  @override
  Widget build(BuildContext context) {
    final startups = _filteredAndSortedStartups;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Annuaire Startups'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'À propos',
            onPressed: () => Navigator.pushNamed(context, AppRouter.about),
          ),
        ],
      ),
      body: Column(
        children: [
          StatsHeader(repository: _repository),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Rechercher une startup...',
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.borderLight),
                ),
              ),
            ),
          ),
          _FilterBar(
            selectedSector: _selectedSector,
            sortAscending: _sortAscending,
            onSectorChanged: (sector) => setState(() => _selectedSector = sector),
            onSortChanged: (ascending) => setState(() => _sortAscending = ascending),
          ),
          Expanded(
            child: startups.isEmpty
                ? _repository.startups.isEmpty
                    ? EmptyStateWidget(
                        onAction: () => _navigateToForm(context),
                      )
                    : const EmptyStateWidget.filtered()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 88),
                    itemCount: startups.length,
                    itemBuilder: (context, index) {
                      final startup = startups[index];
                      return StartupCard(
                        startup: startup,
                        onTap: () => _navigateToDetail(context, startup),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Startup startup) {
    Navigator.pushNamed(context, AppRouter.detail, arguments: startup);
  }

  void _navigateToForm(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.form);
  }
}

class _FilterBar extends StatelessWidget {
  final Sector? selectedSector;
  final bool sortAscending;
  final ValueChanged<Sector?> onSectorChanged;
  final ValueChanged<bool> onSortChanged;

  const _FilterBar({
    required this.selectedSector,
    required this.sortAscending,
    required this.onSectorChanged,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  AllSectorsChip(
                    selected: selectedSector == null,
                    onTap: () => onSectorChanged(null),
                  ),
                  const SizedBox(width: 8),
                  ...Sector.values.map(
                    (sector) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SectorChip(
                        sector: sector,
                        selected: selectedSector == sector,
                        onTap: () => onSectorChanged(sector),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _SortButton(
            ascending: sortAscending,
            onChanged: onSortChanged,
          ),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final bool ascending;
  final ValueChanged<bool> onChanged;

  const _SortButton({required this.ascending, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!ascending),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              ascending ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16,
              color: AppTheme.primaryBlue,
            ),
            const SizedBox(width: 4),
            Text(
              'Année',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
