import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_repository.g.dart';

@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(SubscriptionRepositoryRef ref) {
  return SubscriptionRepository();
}

class SubscriptionRepository {
  static const String _apiKeyIOS = 'appl_YOUR_KEY';
  static const String _apiKeyAndroid = 'goog_YOUR_KEY';
  static const String _placeholderIosKey = 'appl_YOUR_KEY';
  static const String _placeholderAndroidKey = 'goog_YOUR_KEY';

  bool get _isConfigured {
    if (kIsWeb) return false;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return _apiKeyIOS != _placeholderIosKey;
      case TargetPlatform.android:
        return _apiKeyAndroid != _placeholderAndroidKey;
      default:
        return false;
    }
  }

  String? get _activeApiKey {
    if (!_isConfigured) return null;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return _apiKeyIOS;
      case TargetPlatform.android:
        return _apiKeyAndroid;
      default:
        return null;
    }
  }

  Future<void> init() async {
    final apiKey = _activeApiKey;
    if (apiKey == null) return;

    await Purchases.configure(PurchasesConfiguration(apiKey));
  }

  /// Получение товаров (Возвращаем пустоту пока нет мерчанта)
  Future<List<Package>> fetchOffers() async {
    if (!_isConfigured) return [];

    try {
      final offerings = await Purchases.getOfferings();
      return offerings.current?.availablePackages ?? [];
    } catch (_) {
      return [];
    }
  }

  /// Покупка (В режиме заглушки всегда возвращает false)
  Future<bool> purchasePackage(Package package) async {
    if (!_isConfigured) return false;

    try {
      final result = await Purchases.purchase(
        PurchaseParams.package(package),
      );
      return result.customerInfo.entitlements.all['premium']?.isActive ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Проверка статуса (Пока всегда false - юзер бесплатный)
  Future<bool> checkSubscriptionStatus() async {
    if (!_isConfigured) return false;

    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.all['premium']?.isActive ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    if (!_isConfigured) return false;

    try {
      final info = await Purchases.restorePurchases();
      return info.entitlements.all['premium']?.isActive ?? false;
    } catch (_) {
      return false;
    }
  }
}
