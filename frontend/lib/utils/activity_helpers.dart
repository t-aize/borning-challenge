import 'package:flutter/material.dart';

/// Returns the icon associated with an activity [type].
IconData iconForType(String type) {
  switch (type) {
    case 'running':
      return Icons.directions_run;
    case 'cycling':
      return Icons.directions_bike;
    case 'swimming':
      return Icons.pool;
    case 'racket':
      return Icons.sports_tennis;
    case 'strength':
      return Icons.fitness_center;
    default:
      return Icons.sports;
  }
}

/// Returns the color associated with an activity [type].
Color colorForType(String type) {
  switch (type) {
    case 'running':
      return Colors.red;
    case 'cycling':
      return Colors.blue;
    case 'swimming':
      return Colors.cyan;
    case 'racket':
      return Colors.green;
    case 'strength':
      return Colors.deepPurple;
    default:
      return Colors.grey;
  }
}

/// Returns the French label for an activity [type].
String formatType(String type) {
  switch (type) {
    case 'running':
      return 'Course à pied';
    case 'cycling':
      return 'Cyclisme';
    case 'swimming':
      return 'Natation';
    case 'racket':
      return 'Sport de raquettes';
    case 'strength':
      return 'Musculation';
    default:
      return type;
  }
}

/// Returns the short French label for an activity [type] (used in charts).
String formatTypeShort(String type) {
  switch (type) {
    case 'running':
      return 'Course';
    case 'cycling':
      return 'Vélo';
    case 'swimming':
      return 'Natation';
    case 'racket':
      return 'Raquette';
    case 'strength':
      return 'Muscu';
    default:
      return type;
  }
}

/// Formats a duration in [minutes] to a human-readable string (e.g. "1h 30min").
String formatDuration(int minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  if (h > 0) return '${h}h ${m}min';
  return '${m}min';
}
