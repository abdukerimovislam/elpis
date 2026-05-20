import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// ИМПОРТЫ ЛОКАЛИЗАЦИИ
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

// ИМПОРТЫ ЭКРАНОВ И ДАННЫХ
import 'features/home/presentation/living_orbit_screen.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'features/pregnancy/data/pregnancy_repository.dart';
import 'features/pregnancy/domain/pregnancy_settings.dart';
import 'core/theme/app_theme.dart';
import 'core/notifications/notification_service.dart';
import 'features/auth/data/auth_session_repository.dart';
import 'features/auth/presentation/account_entry_screen.dart';

// ИМПОРТЫ ПОДПИСОК И РЕЖИМА РОДОВ
import 'features/subscription/data/subscription_repository.dart';
import 'features/subscription/data/mock_subscription_repository.dart';
import 'features/labor/presentation/labor_dashboard.dart';
import 'features/splash/presentation/splash_screen.dart';

void main() async {
  // 1. Инициализация движка Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 1.1 Инициализация Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 1.2 Перехват всех ошибок через Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // --- 🔥 FPS & MEMORY OPTIMIZATION 🔥 ---
  // Ограничиваем кеш изображений до 100 МБ.
  // Это критически важно для предотвращения вылетов (OOM) на слабых устройствах.
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1024 * 1024 * 100;

  // Ограничиваем количество картинок в памяти (дефолт 1000, снижаем до 50)
  PaintingBinding.instance.imageCache.maximumSize = 50;
  // ---------------------------------------

  // 2. Фиксация ориентации (Только портретная)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 3. Настройка статус-бара
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  // ⚠️ КОНФИГУРАЦИЯ ТЕСТОВ
  const bool useMockSubscriptions = bool.fromEnvironment(
    'USE_MOCK_SUBSCRIPTIONS',
    defaultValue: kDebugMode,
  );

  // 4. Инициализация ProviderContainer с переопределениями (Overrides)
  final container = ProviderContainer(
    overrides: [
      if (useMockSubscriptions)
        subscriptionRepositoryProvider
            .overrideWithValue(MockSubscriptionRepository()),
    ],
  );

  // 5. Инициализация БД (Ждем перед запуском UI)
  try {
    await container.read(authBootstrapProvider.future);
    await container.read(isarDatabaseProvider.future);
    await container.read(notificationServiceProvider).init();
  } catch (e, stackTrace) {
    debugPrint("CRITICAL ERROR: Failed to initialize: $e\n$stackTrace");
    FirebaseCrashlytics.instance.recordError(e, stackTrace, fatal: true);
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: StartupErrorApp(error: e.toString()),
      ),
    );
    return;
  }

  // 6. Запуск приложения
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const BloomApp(),
    ),
  );
}

class BloomApp extends ConsumerStatefulWidget {
  const BloomApp({super.key});

  @override
  ConsumerState<BloomApp> createState() => _BloomAppState();
}

class _BloomAppState extends ConsumerState<BloomApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Показываем красивый сплэш скрин 2.5 секунды перед маршрутизацией
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _showSplash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBootstrap = ref.watch(authBootstrapProvider);
    final entryChoiceAsync = ref.watch(entryChoiceCompletedProvider);
    final isarAsync = ref.watch(isarDatabaseProvider);

    if (authBootstrap.hasError) {
      return StartupErrorApp(error: authBootstrap.error.toString());
    }
    if (entryChoiceAsync.hasError) {
      return StartupErrorApp(error: entryChoiceAsync.error.toString());
    }
    if (isarAsync.hasError) {
      return StartupErrorApp(error: isarAsync.error.toString());
    }

    final hasCompletedEntryChoice = entryChoiceAsync.value ?? false;
    final shouldShowLoader =
        authBootstrap.isLoading || entryChoiceAsync.isLoading || isarAsync.isLoading;

    final settingsStream = shouldShowLoader || !hasCompletedEntryChoice
        ? null
        : ref.watch(pregnancyRepositoryProvider).watchSettings();

    return StreamBuilder<PregnancySettings?>(
      stream: settingsStream,
      builder: (context, snapshot) {
        final settings = snapshot.data;
        final userLocale =
            settings != null ? Locale(settings.languageCode) : null;

        return MaterialApp(
          onGenerateTitle: (context) => AppLocalizations.of(context)?.appName ?? 'Elpis',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          locale: userLocale,

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // ✅ МАСШТАБИРУЕМО: Список языков берётся напрямую из AppLocalizations.
          // Чтобы добавить новый язык — достаточно создать app_XX.arb и
          // запустить `flutter gen-l10n`. main.dart трогать НЕ нужно.
          supportedLocales: AppLocalizations.supportedLocales,

          // МАРШРУТИЗАЦИЯ (Router)
          home: AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: _showSplash 
              ? const SplashScreen(key: ValueKey('splash'))
              : Builder(
                  key: const ValueKey('app'),
                  builder: (context) {
                    if (shouldShowLoader ||
                        (snapshot.connectionState == ConnectionState.waiting &&
                            settings == null &&
                            hasCompletedEntryChoice)) {
                      return Scaffold(
                        backgroundColor: AppTheme.light.scaffoldBackgroundColor,
                        body: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (!hasCompletedEntryChoice) {
                      return const AccountEntryScreen();
                    }

                    // СЦЕНАРИЙ 1: Первый вход (нет настроек)
                    if (settings == null) {
                      return const OnboardingScreen();
                    }

                    // СЦЕНАРИЙ 2: 🔥 РЕЖИМ РОДОВ ВКЛЮЧЕН (Emergency Mode)
                    if (settings.isLaborMode == true) {
                      return const LaborDashboard();
                    }

                    // СЦЕНАРИЙ 3: Обычный режим (Главный экран)
                    return const LivingOrbitScreen();
                  },
                ),
          ),
        );
      },
    );
  }
}

class StartupErrorApp extends StatelessWidget {
  final String error;

  const StartupErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      home: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context);
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(
                      l10n?.startupErrorTitle ?? 'Bloom Mama could not start correctly.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
