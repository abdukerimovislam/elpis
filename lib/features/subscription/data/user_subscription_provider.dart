import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'subscription_repository.dart';

part 'user_subscription_provider.g.dart';

@Riverpod(keepAlive: true)
class UserSubscription extends _$UserSubscription {
  @override
  Stream<bool> build() {
    return _checkStatus();
  }

  Stream<bool> _checkStatus() async* {
    final repo = ref.watch(subscriptionRepositoryProvider);
    await repo.init();
    // Сейчас это всегда вернет false
    final isPremium = await repo.checkSubscriptionStatus();
    yield isPremium;
  }
}