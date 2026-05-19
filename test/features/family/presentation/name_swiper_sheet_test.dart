import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'package:bloom_mama/features/family/data/name_repository.dart';
import 'package:bloom_mama/features/family/domain/baby_name.dart';
import 'package:bloom_mama/features/family/presentation/name_swiper_sheet.dart';
import 'package:bloom_mama/features/pregnancy/data/pregnancy_repository.dart';
import 'package:bloom_mama/l10n/app_localizations.dart';

class _FakeIsar implements Isar {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeNameRepository implements NameRepository {
  _FakeNameRepository(this.names);

  final List<BabyName> names;

  @override
  bool get isReady => true;

  @override
  Future<void> ensureInitialized() async {}

  @override
  Future<List<BabyName>> getNamesToSwipe({
    NameGender? gender,
    List<String>? nationalities,
  }) async {
    return names.where((name) {
      final genderMatches = gender == null || name.gender == gender;
      final nationMatches = nationalities == null ||
          nationalities.isEmpty ||
          nationalities.contains(name.nationality);
      return genderMatches && nationMatches;
    }).toList();
  }

  @override
  Future<List<String>> getAvailableNationalities() async {
    return names.map((name) => name.nationality).toSet().toList();
  }

  @override
  Future<bool> voteName(int id, NameVote vote) async => true;

  @override
  Stream<List<BabyName>> watchLikedNames() => Stream.value(const []);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _wrapWithApp(Widget child, {required List<Override> overrides}) {
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

  testWidgets('name swiper renders a seeded baby name', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final fakeIsar = _FakeIsar();
    final fakeNameRepo = _FakeNameRepository([
      BabyName(
        id: 1,
        name: 'Mila',
        meaning: 'gracious',
        origin: 'Slavic',
        nationality: 'ru',
        gender: NameGender.girl,
      ),
    ]);

    await tester.pumpWidget(
      _wrapWithApp(
        const NameSwiperSheet(),
        overrides: [
          isarDatabaseProvider.overrideWith((ref) async => fakeIsar),
          nameRepositoryProvider.overrideWith((ref) => fakeNameRepo),
        ],
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Mila'), findsOneWidget);
    expect(find.text('gracious'), findsOneWidget);
  });
}
