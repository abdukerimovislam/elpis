import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'subscription_repository.dart';

class MockSubscriptionRepository implements SubscriptionRepository {
  bool _isPremium = false;
  final _isProController = StreamController<bool>.broadcast();

  @override
  Stream<bool> get isProStream => _isProController.stream;

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("MOCK: Subscription SDK Initialized");
  }

  @override
  Future<List<Package>> fetchOffers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Возвращаем пустой список, чтобы пейволл показал тестовую кнопку
    return [];
  }

  @override
  Future<bool> purchasePackage(Package package) async {
    await Future.delayed(const Duration(seconds: 2));
    _isPremium = true;
    _isProController.add(true);
    debugPrint("MOCK: Purchase successful. User is now Premium.");
    return true;
  }

  @override
  Future<bool> restorePurchases() async {
    await Future.delayed(const Duration(seconds: 1));
    _isPremium = true;
    _isProController.add(true);
    debugPrint("MOCK: Restore successful.");
    return true;
  }

  @override
  Future<bool> checkSubscriptionStatus() async {
    return _isPremium;
  }
}
