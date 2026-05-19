import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'subscription_repository.dart';

part 'user_subscription_provider.g.dart';

// ✅ ИСПРАВЛЕНО: Теперь корректно слушает полный стрим из репозитория.
// Предыдущая реализация эмитировала только 1 значение и умирала —
// покупка подписки никогда не обновляла провайдер.
@Riverpod(keepAlive: true)
class UserSubscription extends _$UserSubscription {
  @override
  Stream<bool> build() {
    // 1. Инициализируем RevenueCat (если ещё не запущен)
    final repo = ref.read(subscriptionRepositoryProvider);
    repo.init();

    // 2. Слушаем ЖИВОЙ стрим — он будет эмитировать при каждом изменении
    //    статуса подписки (покупка, восстановление, истечение срока)
    return repo.isProStream;
  }
}
