import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../l10n/app_localizations.dart';
import '../data/subscription_repository.dart';

final packagesProvider = FutureProvider.autoDispose<List<Package>>((ref) async {
  return ref.watch(subscriptionRepositoryProvider).fetchOffers();
});

class PaywallSheet extends ConsumerStatefulWidget {
  const PaywallSheet({super.key});

  @override
  ConsumerState<PaywallSheet> createState() => _PaywallSheetState();
}

class _PaywallSheetState extends ConsumerState<PaywallSheet> {
  bool _isAnnual = true;
  bool _isLoading = false;

  void _showTermsUnavailable() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.paywallTerms),
        content: Text(
          l10n.privacyUnavailable,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonUnderstood),
          ),
        ],
      ),
    );
  }

  Future<void> _processPurchase(Package? package) async {
    if (package == null) return;
    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();

    final success =
        await ref.read(subscriptionRepositoryProvider).purchasePackage(package);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      HapticFeedback.heavyImpact();
      Navigator.pop(context);
    } else {
      HapticFeedback.vibrate();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.paywallError)),
      );
    }
  }

  Future<void> _restorePurchases() async {
    setState(() => _isLoading = true);
    HapticFeedback.lightImpact();
    final success =
        await ref.read(subscriptionRepositoryProvider).restorePurchases();
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (success) {
      HapticFeedback.heavyImpact();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final l10n = AppLocalizations.of(context)!;
    final packagesAsync = ref.watch(packagesProvider);
    final repository = ref.read(subscriptionRepositoryProvider);
    final isMockMode = repository.isMockMode;
    final isBillingConfigured = repository.isBillingConfigured;

    final title = isMockMode
        ? l10n.paywallMockTitle
        : isBillingConfigured
            ? l10n.paywallProTitle
            : l10n.paywallStatusTitleDefault;
    final subtitle = isMockMode
        ? l10n.paywallMockBody
        : isBillingConfigured
            ? l10n.paywallProSubtitle
            : l10n.paywallStatusBody;

    final features = [
      {
        'icon': Icons.touch_app_outlined,
        'title': l10n.paywallFeatBabyTitle,
        'desc': l10n.paywallFeatBabyDesc,
      },
      {
        'icon': Icons.timer_outlined,
        'title': l10n.paywallFeatReportTitle,
        'desc': l10n.paywallFeatReportDesc,
      },
      {
        'icon': Icons.healing_outlined,
        'title': l10n.paywallFeatAnalyticsTitle,
        'desc': l10n.paywallFeatAnalyticsDesc,
      },
      {
        'icon': Icons.photo_library_outlined,
        'title': l10n.paywallFeatGalleryTitle,
        'desc': l10n.paywallFeatGalleryDesc,
      },
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: const BoxDecoration(
        color: Color(0xFF0F0F0F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.15),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE29587).withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: const SizedBox(),
            ),
          ),

          // Content
          Column(
            children: [
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Header Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withValues(alpha: 0.1),
                    border:
                        Border.all(color: primaryColor.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ]),
                child: Icon(Icons.workspace_premium_rounded,
                        size: 48, color: primaryColor)
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .scaleXY(
                        begin: 1.0,
                        end: 1.1,
                        duration: 1500.ms,
                        curve: Curves.easeInOut),
              ),
              const SizedBox(height: 24),

              Text(
                title,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),

              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, color: Colors.white54, height: 1.4),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),
              ),

              const SizedBox(height: 32),

              // Features List
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  itemCount: features.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final f = features[index];
                    return Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(f['icon'] as IconData,
                              color: primaryColor, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(f['title'] as String,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text(f['desc'] as String,
                                  style: const TextStyle(
                                      color: Colors.white54, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: (200 + index * 100).ms)
                        .slideX(begin: 0.1, end: 0);
                  },
                ),
              ),

              // Tiers
              if (isMockMode)
                _buildMockStateCard(l10n, primaryColor)
              else if (!isBillingConfigured)
                _buildStatusCard(
                  icon: Icons.schedule_rounded,
                  title: l10n.paywallStatusTitleDefault,
                  body: l10n.paywallStatusBody,
                )
              else
                packagesAsync.when(
                  data: (packages) {
                    if (packages.isEmpty) {
                      return _buildStatusCard(
                        icon: Icons.credit_card_off_rounded,
                        title: l10n.paywallOffersLoadError,
                        body: l10n.paywallStatusBody,
                      );
                    }

                    final monthPackage = packages.firstWhere(
                      (p) => p.packageType == PackageType.monthly,
                      orElse: () => packages.first,
                    );
                    final yearPackage = packages.firstWhere(
                      (p) => p.packageType == PackageType.annual,
                      orElse: () => packages.last,
                    );

                    final monthPrice = monthPackage.storeProduct.priceString;
                    final yearPrice = yearPackage.storeProduct.priceString;
                    final selectedPackage =
                        _isAnnual ? yearPackage : monthPackage;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildTierCard(
                                  title: l10n.paywallMonth,
                                  price: monthPrice,
                                  isSelected: !_isAnnual,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() => _isAnnual = false);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildTierCard(
                                  title: l10n.paywallYear,
                                  price: yearPrice,
                                  badge: l10n.paywallSaveBadge,
                                  isSelected: _isAnnual,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    setState(() => _isAnnual = true);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : () => _processPurchase(selectedPackage),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 8,
                                shadowColor:
                                    primaryColor.withValues(alpha: 0.5),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      l10n.paywallContinue,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                            ),
                          )
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .scaleXY(
                                begin: 1.0,
                                end: 1.02,
                                duration: 1500.ms,
                                curve: Curves.easeInOut,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.paywallCancelAnytime,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ).animate().fadeIn(delay: 500.ms),
                      ],
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  error: (e, st) => _buildStatusCard(
                    icon: Icons.wifi_tethering_error_rounded,
                    title: l10n.paywallOffersLoadError,
                    body: l10n.paywallStatusBody,
                  ),
                ),

              // Footer
              Padding(
                padding: EdgeInsets.only(
                    top: 16,
                    bottom: MediaQuery.of(context).padding.bottom + 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _showTermsUnavailable,
                      child: Text(l10n.paywallTerms,
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 12)),
                    ),
                    const Text("•", style: TextStyle(color: Colors.white38)),
                    TextButton(
                      onPressed: _isLoading || !isBillingConfigured
                          ? null
                          : _restorePurchases,
                      child: Text(l10n.paywallRestore,
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white70, size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMockStateCard(AppLocalizations l10n, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.35),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.science_rounded,
              color: primaryColor,
              size: 30,
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _restorePurchases,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        l10n.paywallMockCta,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTierCard({
    required String title,
    required String price,
    String? badge,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.white10,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Text(title,
                    style: TextStyle(
                        color: isSelected ? primaryColor : Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0)),
                const SizedBox(height: 8),
                Text(price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800)),
              ],
            ),
            if (badge != null)
              Positioned(
                top: -30,
                right: -10,
                left: -10,
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(badge,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
