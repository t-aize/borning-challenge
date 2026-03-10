import 'package:flutter/material.dart';

import '../models/activity_stats.dart';
import '../utils/activity_helpers.dart';

class StatsCards extends StatelessWidget {
  final ActivityStats stats;

  const StatsCards({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem(
        icon: Icons.straighten,
        label: 'Distance totale',
        value: '${stats.totalKm.toStringAsFixed(1)} km',
        color: Colors.blue,
      ),
      _StatItem(
        icon: Icons.terrain,
        label: 'Dénivelé cumulé',
        value: '${stats.totalElevation.toStringAsFixed(0)} m',
        color: Colors.orange,
      ),
      _StatItem(
        icon: Icons.timer,
        label: 'Durée totale',
        value: formatDuration(stats.totalDuration),
        color: Colors.green,
      ),
      _StatItem(
        icon: Icons.fitness_center,
        label: 'Activités',
        value: '${stats.activityCount}',
        color: Colors.purple,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800
            ? 4
            : constraints.maxWidth > 500
            ? 2
            : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, color: item.color, size: 28),
                    const SizedBox(height: 8),
                    Text(
                      item.value,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _StatItem {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}
