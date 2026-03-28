import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../pregnancy/data/pregnancy_repository.dart';

part 'time_navigation_provider.g.dart';

// 1. Вспомогательный провайдер, который следит за реальной текущей неделей из БД
@riverpod
Stream<int> realCurrentWeek(RealCurrentWeekRef ref) {
  final repo = ref.watch(pregnancyRepositoryProvider);
  // Слушаем настройки и возвращаем текущую неделю. Если настроек нет — 1.
  return repo.watchSettings().map((settings) => settings?.currentWeek ?? 1);
}

// 2. Состояние навигации: Какую неделю мы СМОТРИМ (UI)
@riverpod
class SelectedWeek extends _$SelectedWeek {
  @override
  int build() {
    // МАГИЯ RIVERPOD:
    // Мы подписываемся на реальную неделю.
    // Как только БД загрузится, этот провайдер АВТОМАТИЧЕСКИ инициализируется реальной неделей.
    // .valueOrNull вернет null, пока идет загрузка, поэтому ставим ?? 1
    final realWeekAsync = ref.watch(realCurrentWeekProvider);

    // Если мы еще не выбрали неделю вручную (первый запуск),
    // берем реальную неделю из базы.
    return realWeekAsync.value ?? 1;
  }

  /// Установка недели вручную (когда пользователь свайпает карусель)
  void set(int week) {
    // Валидация диапазонов (бизнес-логика)
    if (state == week) return;

    if (week < 1) {
      state = 1;
    } else if (week > 42) {
      state = 42;
    } else {
      state = week;
    }
  }

  /// Сброс к реальной неделе (например, кнопка "Вернуться к сегодня")
  void resetToCurrent() {
    final realWeek = ref.read(realCurrentWeekProvider).value;
    if (realWeek != null) {
      set(realWeek);
    }
  }
}
