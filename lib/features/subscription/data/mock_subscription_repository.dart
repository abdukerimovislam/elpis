import 'package:purchases_flutter/purchases_flutter.dart';
import 'subscription_repository.dart'; // Убедись, что путь правильный к абстрактному репозиторию

class MockSubscriptionRepository implements SubscriptionRepository {

  bool _isPremium = false;

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    print("🔹 MOCK: Subscription SDK Initialized");
  }

  @override
  Future<List<Package>> fetchOffers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Возвращаем пустой список, чтобы пейволл показал тестовую кнопку
    return [];
  }

  @override
  Future<bool> purchasePackage(Package package) async {
    // В моке мы игнорируем сам пакет
    await Future.delayed(const Duration(seconds: 2));
    _isPremium = true;
    print("🔹 MOCK: Purchase Successful! User is now Premium.");
    return true;
  }

  @override
  Future<bool> restorePurchases() async {
    await Future.delayed(const Duration(seconds: 1));
    _isPremium = true;
    print("🔹 MOCK: Restore Successful!");
    return true;
  }

  @override
  Future<bool> checkSubscriptionStatus() async {
    return _isPremium;
  }
}