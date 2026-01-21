import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../../core/ui/glass_text_field.dart';

// ИМПОРТ ВИДЖЕТА ВЫБОРА ТЕМЫ
import '../../pregnancy/presentation/widgets/theme_selector.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();

  // Дата зачатия / последней менструации
  DateTime _selectedDate = DateTime.now().subtract(const Duration(days: 60)); // Дефолт ~8 недель

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == 0) {
      // Переход к дате
      FocusScope.of(context).unfocus(); // Скрываем клавиатуру
      _pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic
      );
    } else {
      // Завершение
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    final name = _nameController.text.trim();
    // Рассчитываем ПДР (LMP + 280 дней)
    final dueDate = _selectedDate.add(const Duration(days: 280));

    // Язык определяем автоматически из контекста
    final localeCode = Localizations.localeOf(context).languageCode;

    // Сохраняем всё одним махом
    // Примечание: ThemeKey и FruitMode сохраняются реактивно через ThemeSelector (он сам пишет в базу),
    // но для надежности можно передать дефолты, если юзер ничего не тыкнул.
    await ref.read(pregnancyRepositoryProvider).updateSettings(
      name: name.isNotEmpty ? name : null,
      dueDate: dueDate,
      languageCode: localeCode,
      // Остальные настройки (Theme, FruitMode) уже обновлены через UI, если пользователь их трогал
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // Используем LayoutBuilder для защиты от переполнения
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Прогресс бар (точки)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(0),
                            const SizedBox(width: 8),
                            _buildDot(1),
                          ],
                        ),

                        const Spacer(),

                        // PAGE VIEW (Имя+Тема / Дата)
                        SizedBox(
                          height: 500, // Увеличил высоту, чтобы вместить ThemeSelector
                          child: PageView(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(), // Блокируем свайп руками
                            onPageChanged: (idx) => setState(() => _currentPage = idx),
                            children: [
                              // СТРАНИЦА 1: ИМЯ + ТЕМА
                              _buildNamePage(l10n),

                              // СТРАНИЦА 2: ДАТА
                              _buildDatePage(l10n),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // КНОПКА NEXT
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _nextPage,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 4,
                              shadowColor: theme.primaryColor.withOpacity(0.4),
                            ),
                            child: Text(
                              _currentPage == 0
                                  ? l10n.commonNext.toUpperCase()
                                  : l10n.onboardingAction.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.5
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    final theme = Theme.of(context);
    final isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? theme.primaryColor : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildNamePage(AppLocalizations l10n) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.onboardingTitle, // "Hi, Mama!"
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.onboardingNameTitle, // "How should we call you?"
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        // Ввод имени
        GlassTextField(
          controller: _nameController,
          hintText: l10n.onboardingNameHint, // "Your Name"
          onEditingComplete: _nextPage,
          // autofocus: true, // Убрал, чтобы клавиатура не перекрывала тему сразу
        ),

        const SizedBox(height: 40),

        // Выбор темы (сразу даем пощупать стиль)
        Text(
          l10n.settingsThemeTitle.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
        ),
        const SizedBox(height: 12),
        const ThemeSelector(),
      ],
    );
  }

  Widget _buildDatePage(AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.onboardingLmpLabel, // "First day of last period"
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.onboardingSubtitle, // "We use this to calculate..."
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),

        // DATE PICKER (Используем календарь Material для LMP, это удобнее)
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
          ),
          child: Theme(
            data: theme.copyWith(
              colorScheme: ColorScheme.light(primary: theme.primaryColor),
            ),
            child: CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 300)),
              lastDate: DateTime.now(),
              onDateChanged: (val) {
                setState(() => _selectedDate = val);
              },
            ),
          ),
        ),
      ],
    );
  }
}