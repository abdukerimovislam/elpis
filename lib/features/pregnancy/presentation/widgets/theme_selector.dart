import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_mama/features/pregnancy/data/pregnancy_repository.dart';
import 'package:bloom_mama/features/pregnancy/domain/pregnancy_settings.dart';
import 'package:bloom_mama/l10n/app_localizations.dart';
import 'package:flutter/material.dart';


// Если этот провайдер уже объявлен в settings_sheet.dart или глобально,
// этот дубликат можно удалить и импортировать существующий.
final settingsStreamProvider = StreamProvider<PregnancySettings?>((ref) {
  final repo = ref.watch(pregnancyRepositoryProvider);
  return repo.watchSettings();
});

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!; // Локализация
    final settingsAsync = ref.watch(settingsStreamProvider);
    final currentTheme = settingsAsync.value?.themeKey ?? 'serenity';
    final repo = ref.read(pregnancyRepositoryProvider);

    // Данные для тем с локализованными названиями
    final themes = [
      {
        'key': 'serenity',
        'color': const Color(0xFF7D93B2),
        'label': l10n.settingsThemeSerenity // "Serenity" / "Спокойствие"
      },
      {
        'key': 'sage',
        'color': const Color(0xFF9CAF88),
        'label': l10n.settingsThemeNature // "Nature" / "Природа"
      },
      {
        'key': 'peach',
        'color': const Color(0xFFE29587),
        'label': l10n.settingsThemeWarmth // "Warmth" / "Тепло"
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: themes.map((theme) {
        final key = theme['key'] as String;
        final color = theme['color'] as Color;
        final label = theme['label'] as String;
        final isSelected = currentTheme == key;

        return GestureDetector(
          onTap: () async {
            if (!isSelected) {
              HapticFeedback.selectionClick(); // Премиум тактильность
              try {
                await repo.setTheme(key);
              } catch (e) {
                // Тихая обработка ошибки UI, можно добавить лог
                debugPrint("Error changing theme: $e");
              }
            }
          },
          child: Column( // Добавил Column, чтобы подписать цвета (опционально)
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(4), // Отступ для рамки выделения
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: color, width: 2)
                      : Border.all(color: Colors.transparent, width: 2), // Прозрачная рамка, чтобы не прыгало
                ),
                child: Container(
                  width: 48, // Чуть увеличил для удобства нажатия
                  height: 48,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, spreadRadius: 2)
                    ],
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 24)
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              // Подпись темы (опционально, если нужно как в дизайне настроек)
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? color : Colors.grey,
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}