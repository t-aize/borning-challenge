import 'package:flutter/material.dart';

import '../models/activity_stats.dart';
import '../services/api_service.dart';
import '../widgets/activity_list.dart';
import '../widgets/async_content.dart';
import '../widgets/charts_widget.dart';
import '../widgets/stats_cards.dart';

class UserActivitiesPage extends StatefulWidget {
  const UserActivitiesPage({super.key});

  @override
  State<UserActivitiesPage> createState() => _UserActivitiesPageState();
}

class _UserActivitiesPageState extends State<UserActivitiesPage> {
  List<String> _userIds = [];
  String? _selectedUserId;
  ActivityStats? _stats;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserIds();
  }

  Future<void> _loadUserIds() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final ids = await ApiService.fetchUserIds();
      setState(() {
        _userIds = ids;
        _selectedUserId = ids.isNotEmpty ? ids.first : null;
      });
      if (_selectedUserId != null) {
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
    if (_selectedUserId == null) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final stats = await ApiService.fetchUserActivities(_selectedUserId!);
      setState(() {
        _stats = stats;
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
        // User selector
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              const Icon(Icons.person, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Utilisateur :',
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
                    value: _selectedUserId,
                    hint: const Text('Chargement...'),
                    items: _userIds.map((id) {
                      final displayName = 'Utilisateur ${id.split('_').last}';
                      return DropdownMenuItem(
                        value: id,
                        child: Text(displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedUserId = value);
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
          child: AsyncContent<ActivityStats>(
            loading: _loading,
            error: _error,
            data: _stats,
            onRetry: _fetchData,
            builder: (stats) => SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            ),
          ),
        ),
      ],
    );
  }
}
