import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:isar/isar.dart';

// ИМПОРТЫ ЛОКАЛИЗАЦИИ
import 'l10n/app_localizations.dart';

// ИМПОРТЫ ЭКРАНОВ И ДАННЫХ
import 'features/home/presentation/living_orbit_screen.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'features/pregnancy/data/pregnancy_repository.dart';
import 'features/pregnancy/domain/pregnancy_settings.dart';
import 'core/theme/app_theme.dart';

// ИМПОРТЫ ПОДПИСОК И РЕЖИМА РОДОВ
import 'features/subscription/data/subscription_repository.dart';
import 'features/subscription/data/mock_subscription_repository.dart';
import 'features/labor/presentation/labor_dashboard.dart';

// Глобальная переменная для доступа к Isar
late final Isar isarInstance;

void main() async {
  // 1. Инициализация движка Flutter
  WidgetsFlutterBinding.ensureInitialized();

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
    isarInstance = await container.read(isarDatabaseProvider.future);
  } catch (e) {
    debugPrint("CRITICAL ERROR: Failed to initialize Isar: $e");
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: StartupErrorApp(error: e.toString()),
      ),
    );
    return;
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const BloomApp(),
    ),
  );
}

class BloomApp extends ConsumerWidget {
  const BloomApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Слушаем поток настроек прямо из репозитория
    final settingsStream =
        ref.watch(pregnancyRepositoryProvider).watchSettings();

    return StreamBuilder<PregnancySettings?>(
      stream: settingsStream,
      builder: (context, snapshot) {
        // Данные настроек
        final settings = snapshot.data;

        // 1. ЛОГИКА ТЕМЫ
        final themeKey = settings?.themeKey ?? 'serenity';

        // 2. ЛОГИКА ЯЗЫКА
        final userLocale =
            settings != null ? Locale(settings.languageCode) : null;

        return MaterialApp(
          title: 'Bloom Mama',
          debugShowCheckedModeBanner: false,

          // Подставляем тему динамически
          theme: AppTheme.getTheme(themeKey),

          // Язык приложения
          locale: userLocale,

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // Английский
            Locale('ru'), // Русский
          ],

          // МАРШРУТИЗАЦИЯ (Router)
          home: Builder(
            builder: (context) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor:
                      AppTheme.getTheme('serenity').scaffoldBackgroundColor,
                  body: const Center(child: CircularProgressIndicator()),
                );
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
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline,
                    size: 48, color: Colors.redAccent),
                const SizedBox(height: 16),
                const Text(
                  'Bloom Mama could not start correctly.',
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
      ),
    );
  }
}
