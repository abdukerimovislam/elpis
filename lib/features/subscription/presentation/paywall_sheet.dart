import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';

class PaywallSheet extends ConsumerWidget {
  const PaywallSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final l10n = AppLocalizations.of(context)!;
    final languageCode = Localizations.localeOf(context).languageCode;
    final isAndroid =
        !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

    final subtitle = isAndroid
        ? (languageCode == 'ru'
            ? 'Премиум-функции для Android пока готовятся.'
            : 'Premium features for Android are still in development.')
        : (languageCode == 'ru'
            ? 'Поддержите разработку и откройте все возможности.'
            : 'Support development and unlock all features.');

    final backupFeature = languageCode == 'ru'
        ? 'Полный облачный бэкап скоро появится'
        : 'Full cloud backup coming soon';
    final insightsFeature = languageCode == 'ru'
        ? 'Расширенные health insights'
        : 'Advanced health insights';
    final noAdsFeature = languageCode == 'ru' ? 'Без рекламы' : 'No ads';
    final statusTitle = isAndroid
        ? (languageCode == 'ru'
            ? 'Покупки для Android скоро появятся'
            : 'Android purchases are coming soon')
        : (languageCode == 'ru' ? 'Скоро появится' : 'Coming soon');
    final statusBody = languageCode == 'ru'
        ? 'Мы работаем над запуском Premium для всех пользователей.'
        : 'We are working hard to bring Premium features to everyone.';

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text('Bloom Premium', style: theme.textTheme.displaySmall),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          _buildFeature(
            context,
            Icons.picture_as_pdf_outlined,
            l10n.settingsExportPdf,
          ),
          _buildFeature(context, Icons.backup_outlined, backupFeature),
          _buildFeature(context, Icons.insights, insightsFeature),
          _buildFeature(context, Icons.check_circle_outline, noAdsFeature),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Icon(Icons.construction, size: 40, color: primaryColor),
                const SizedBox(height: 12),
                Text(
                  statusTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  statusBody,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              side: BorderSide(color: Colors.grey[300]!),
            ),
            child: Text(
              l10n.commonUnderstood,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFeature(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
