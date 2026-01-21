import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../health/domain/contraction.dart';

// ГЕНЕРАЦИЯ КОДА (Не забудь запустить build_runner!)
part 'contraction_timer_provider.g.dart';

// Состояние таймера (простой класс данных)
class TimerState {
  final bool isActive;
  final Duration duration;
  final Contraction? activeContraction;

  TimerState({
    this.isActive = false,
    this.duration = Duration.zero,
    this.activeContraction,
  });

  TimerState copyWith({
    bool? isActive,
    Duration? duration,
    Contraction? activeContraction,
  }) {
    return TimerState(
      isActive: isActive ?? this.isActive,
      duration: duration ?? this.duration,
      activeContraction: activeContraction ?? this.activeContraction,
    );
  }
}

@riverpod
class ContractionTimer extends _$ContractionTimer {
  Timer? _ticker;

  @override
  TimerState build() {
    // 1. При старте проверяем, не идет ли уже схватка (если приложение перезапустили)
    _checkActiveContraction();

    // 2. Убираем мусор за собой
    ref.onDispose(() {
      _ticker?.cancel();
    });

    return TimerState();
  }

  Future<void> _checkActiveContraction() async {
    final repo = ref.read(pregnancyRepositoryProvider);
    final active = await repo.getActiveContraction();

    if (active != null) {
      // Восстанавливаем состояние
      final startTime = active.startTime;
      final duration = DateTime.now().difference(startTime);

      state = TimerState(
        isActive: true,
        duration: duration,
        activeContraction: active,
      );
      _startTicker();
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.activeContraction != null) {
        final duration = DateTime.now().difference(state.activeContraction!.startTime);
        // Обновляем состояние каждую секунду
        state = state.copyWith(duration: duration);
      }
    });
  }

  Future<void> toggleTimer() async {
    final repo = ref.read(pregnancyRepositoryProvider);

    if (state.isActive) {
      // ОСТАНОВКА
      if (state.activeContraction != null) {
        await repo.stopContraction(state.activeContraction!.id);
      }
      _ticker?.cancel();
      state = TimerState(isActive: false, duration: Duration.zero, activeContraction: null);
    } else {
      // ЗАПУСК
      final newContraction = await repo.startContraction();
      state = TimerState(isActive: true, duration: Duration.zero, activeContraction: newContraction);
      _startTicker();
    }
  }
}