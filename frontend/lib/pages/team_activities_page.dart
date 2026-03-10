import 'package:flutter/material.dart';

import '../models/team_stats.dart';
import '../services/api_service.dart';
import '../widgets/activity_list.dart';
import '../widgets/async_content.dart';
import '../widgets/charts_widget.dart';
import '../widgets/stats_cards.dart';

class TeamActivitiesPage extends StatefulWidget {
  const TeamActivitiesPage({super.key});

  @override
  State<TeamActivitiesPage> createState() => _TeamActivitiesPageState();
}

class _TeamActivitiesPageState extends State<TeamActivitiesPage> {
  List<String> _teamIds = [];
  String? _selectedTeamId;
  TeamStats? _teamStats;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTeamIds();
  }

  Future<void> _loadTeamIds() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final ids = await ApiService.fetchTeamIds();
      setState(() {
        _teamIds = ids;
        _selectedTeamId = ids.isNotEmpty ? ids.first : null;
      });
      if (_selectedTeamId != null) {
        await _fetchData();
      } else {
        setState(() => _loading = false);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _fetchData() async {
    if (_selectedTeamId == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final stats = await ApiService.fetchTeamActivities(_selectedTeamId!);
      setState(() {
        _teamStats = stats;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Team selector
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              const Icon(Icons.group, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Équipe :',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedTeamId,
                    hint: const Text('Chargement...'),
                    items: _teamIds.map((id) {
                      final displayName = 'Équipe ${id.split('_').last}';
                      return DropdownMenuItem(
                        value: id,
                        child: Text(displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedTeamId = value);
                        _fetchData();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        // Content
        Expanded(
          child: AsyncContent<TeamStats>(
            loading: _loading,
            error: _error,
            data: _teamStats,
            onRetry: _fetchData,
            builder: (teamStats) {
              final stats = teamStats.stats;
              final members = teamStats.members;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Membres (${members.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: members.map((m) {
                        return Chip(
                          avatar: const CircleAvatar(
                            child: Icon(Icons.person, size: 16),
                          ),
                          label: Text('Utilisateur ${m.split('_').last}'),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    StatsCards(stats: stats),
                    const SizedBox(height: 24),
                    ChartsWidget(activities: stats.activities),
                    const SizedBox(height: 24),
                    Text(
                      'Historique des activités',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ActivityList(activities: stats.activities),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
