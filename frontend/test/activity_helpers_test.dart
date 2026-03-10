import 'package:borning_challenge_frontend/utils/activity_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('colorForType', () {
    test('returns red for running', () {
      expect(colorForType('running'), Colors.red);
    });

    test('returns blue for cycling', () {
      expect(colorForType('cycling'), Colors.blue);
    });

    test('returns cyan for swimming', () {
      expect(colorForType('swimming'), Colors.cyan);
    });

    test('returns green for racket', () {
      expect(colorForType('racket'), Colors.green);
    });

    test('returns deepPurple for strength', () {
      expect(colorForType('strength'), Colors.deepPurple);
    });

    test('returns grey for unknown type', () {
      expect(colorForType('yoga'), Colors.grey);
    });
  });

  group('iconForType', () {
    test('returns directions_run for running', () {
      expect(iconForType('running'), Icons.directions_run);
    });

    test('returns directions_bike for cycling', () {
      expect(iconForType('cycling'), Icons.directions_bike);
    });

    test('returns pool for swimming', () {
      expect(iconForType('swimming'), Icons.pool);
    });

    test('returns sports_tennis for racket', () {
      expect(iconForType('racket'), Icons.sports_tennis);
    });

    test('returns fitness_center for strength', () {
      expect(iconForType('strength'), Icons.fitness_center);
    });

    test('returns sports for unknown type', () {
      expect(iconForType('yoga'), Icons.sports);
    });
  });

  group('formatType', () {
    test('returns "Course à pied" for running', () {
      expect(formatType('running'), 'Course à pied');
    });

    test('returns "Cyclisme" for cycling', () {
      expect(formatType('cycling'), 'Cyclisme');
    });

    test('returns "Natation" for swimming', () {
      expect(formatType('swimming'), 'Natation');
    });

    test('returns "Sport de raquettes" for racket', () {
      expect(formatType('racket'), 'Sport de raquettes');
    });

    test('returns "Musculation" for strength', () {
      expect(formatType('strength'), 'Musculation');
    });

    test('returns raw type for unknown', () {
      expect(formatType('yoga'), 'yoga');
    });
  });

  group('formatTypeShort', () {
    test('returns "Course" for running', () {
      expect(formatTypeShort('running'), 'Course');
    });

    test('returns "Vélo" for cycling', () {
      expect(formatTypeShort('cycling'), 'Vélo');
    });

    test('returns "Muscu" for strength', () {
      expect(formatTypeShort('strength'), 'Muscu');
    });

    test('returns raw type for unknown', () {
      expect(formatTypeShort('yoga'), 'yoga');
    });
  });

  group('formatDuration', () {
    test('formats minutes only', () {
      expect(formatDuration(45), '45min');
    });

    test('formats hours and minutes', () {
      expect(formatDuration(90), '1h 30min');
    });

    test('formats exact hours', () {
      expect(formatDuration(120), '2h 0min');
    });

    test('formats zero minutes', () {
      expect(formatDuration(0), '0min');
    });
  });
}
