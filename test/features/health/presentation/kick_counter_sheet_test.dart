import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bloom_mama/features/health/domain/health_record.dart';
import 'package:bloom_mama/features/health/presentation/kick_counter_sheet.dart';
import 'package:bloom_mama/features/pregnancy/data/pregnancy_repository.dart';
import 'package:bloom_mama/l10n/app_localizations.dart';

class _FakePregnancyRepository implements PregnancyRepository {
  final _controller = StreamController<List<HealthRecord>>.broadcast();
  final List<HealthRecord> _records = [];

  _FakePregnancyRepository() {
    _controller.add(const []);
  }

  @override
  Stream<List<HealthRecord>> watchKickHistory() => _controller.stream;

  @override
  Future<void> saveKickSession({
    required DateTime date,
    required int kicks,
  }) async {
    _records.add(
      HealthRecord(
        date: DateTime(date.year, date.month, date.day),
        totalKicks: kicks,
        kickSessionsCount: 1,
      ),
    );
    _controller.add(List.of(_records));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _wrapWithApp(Widget child, {List<Override> overrides = const []}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('kick counter starts and shows success dialog after ten kicks',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final fakeRepo = _FakePregnancyRepository();

    await tester.pumpWidget(
      _wrapWithApp(
        const KickCounterSheet(),
        overrides: [
          pregnancyRepositoryProvider.overrideWith((ref) => fakeRepo),
        ],
      ),
    );

    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Start Session'), findsOneWidget);

    await tester.tap(find.text('Start Session'));
    await tester.pump(const Duration(milliseconds: 100));

    for (var i = 0; i < 9; i++) {
      await tester.tap(find.text('Tap on\nmovement'));
      await tester.pump(const Duration(milliseconds: 80));
    }

    expect(find.text('Great Job!'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });
}
