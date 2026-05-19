import 'package:flutter_test/flutter_test.dart';

import 'package:bloom_mama/features/health/domain/contraction.dart';
import 'package:bloom_mama/features/health/domain/contraction_pattern.dart';

void main() {
  test('matches511Rule returns true for a sustained 5-1-1 style pattern', () {
    final now = DateTime(2026, 5, 19, 18, 0);
    final history = List.generate(6, (index) {
      final start = now.subtract(Duration(minutes: index * 5));
      return Contraction(
        id: index + 1,
        startTime: start,
        endTime: start.add(const Duration(seconds: 60)),
      );
    });

    expect(matches511Rule(history, now: now), isTrue);
  });

  test('matches511Rule returns false when contractions are too irregular', () {
    final now = DateTime(2026, 5, 19, 18, 0);
    final offsets = [0, 2, 9, 16, 24, 31];
    final history = List.generate(offsets.length, (index) {
      final start = now.subtract(Duration(minutes: offsets[index]));
      return Contraction(
        id: index + 1,
        startTime: start,
        endTime: start.add(const Duration(seconds: 30)),
      );
    });

    expect(matches511Rule(history, now: now), isFalse);
  });
}
