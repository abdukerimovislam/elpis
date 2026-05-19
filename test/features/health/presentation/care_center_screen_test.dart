import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:bloom_mama/features/family/data/bump_repository.dart';
import 'package:bloom_mama/features/family/data/name_repository.dart';
import 'package:bloom_mama/features/family/domain/baby_name.dart';
import 'package:bloom_mama/features/family/domain/bump_snapshot.dart';
import 'package:bloom_mama/features/family/presentation/name_swiper_sheet.dart';
import 'package:bloom_mama/features/health/presentation/care_center_screen.dart';
import 'package:bloom_mama/features/pregnancy/data/pregnancy_repository.dart';
import 'package:bloom_mama/features/subscription/data/subscription_repository.dart';
import 'package:bloom_mama/features/subscription/presentation/paywall_sheet.dart';
import 'package:bloom_mama/l10n/app_localizations.dart';
import 'package:isar/isar.dart';

class _FakeBumpRepository implements BumpRepository {
  _FakeBumpRepository(this.snapshots);

  final List<BumpSnapshot> snapshots;

  @override
  Stream<List<BumpSnapshot>> watchSnapshots() => Stream.value(snapshots);

  @override
  Future<void> savePhoto(int week, String tempPath) async {}

  @override
  Future<void> deletePhoto(int id) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

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
  Future<bool> voteName(int id, NameVote vote) async {
    return true;
  }

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

  testWidgets('locked gallery from care center opens paywall', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _wrapWithApp(
        const CareCenterScreen(),
        overrides: [
          isProProvider.overrideWith((ref) => Stream.value(false)),
          packagesProvider.overrideWith((ref) async => <Package>[]),
        ],
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));
    await tester.scrollUntilVisible(
      find.text('Bump Gallery'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.widgetWithText(GestureDetector, 'Bump Gallery'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(PaywallSheet), findsOneWidget);
    expect(find.text('Unlock Elpis PRO'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 100));
  });

  testWidgets('pro gallery from care center opens bump gallery sheet',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final fakeBumpRepo = _FakeBumpRepository(const []);

    await tester.pumpWidget(
      _wrapWithApp(
        const CareCenterScreen(),
        overrides: [
          isProProvider.overrideWith((ref) => Stream.value(true)),
          bumpRepositoryProvider.overrideWith((ref) => fakeBumpRepo),
        ],
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));
    await tester.scrollUntilVisible(
      find.text('Bump Gallery'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.widgetWithText(GestureDetector, 'Bump Gallery'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Bump Gallery'), findsWidgets);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 100));
  });

  testWidgets('name chooser opens from care center', (tester) async {
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
        const CareCenterScreen(),
        overrides: [
          isarDatabaseProvider.overrideWith((ref) async => fakeIsar),
          nameRepositoryProvider.overrideWith((ref) => fakeNameRepo),
          isProProvider.overrideWith((ref) => Stream.value(true)),
        ],
      ),
    );

    await tester.pump(const Duration(milliseconds: 300));
    await tester.scrollUntilVisible(
      find.text('Baby Names'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.widgetWithText(GestureDetector, 'Baby Names'));
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.byType(NameSwiperSheet), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 100));
  });
}
