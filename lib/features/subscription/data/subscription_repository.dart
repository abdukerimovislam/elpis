import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_repository.g.dart';

@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(SubscriptionRepositoryRef ref) {
  return SubscriptionRepository();
}

class SubscriptionRepository {
  // Флаг: Если false, мы даже не пытаемся стучаться в RevenueCat
  // Когда решишь вопрос с Merchant, просто поставишь true и впишешь ключи
  static const bool _isLive = false;

  static const String _apiKeyIOS = 'appl_YOUR_KEY';
  static const String _apiKeyAndroid = 'goog_YOUR_KEY';

  Future<void> init() async {
    if (!_isLive) return; // В режиме заглушки ничего не инициализируем

    // Сюда потом вставим реальную инициализацию
    // await Purchases.configure(...);
  }

  /// Получение товаров (Возвращаем пустоту пока нет мерчанта)
  Future<List<Package>> fetchOffers() async {
    if (!_isLive) return [];

    try {
      final offerings = await Purchases.getOfferings();
      return offerings.current?.availablePackages ?? [];
    } catch (_) {
      return [];
    }
  }

  /// Покупка (В режиме заглушки всегда возвращает false)
  Future<bool> purchasePackage(Package package) async {
    if (!_isLive) return false;

    // Реальная логика будет тут
    return false;
  }

  /// Проверка статуса (Пока всегда false - юзер бесплатный)
  Future<bool> checkSubscriptionStatus() async {
    if (!_isLive) return false;

    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.all['premium']?.isActive ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> restorePurchases() async => false;
}