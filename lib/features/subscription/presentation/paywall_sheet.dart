import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../l10n/app_localizations.dart';

class PaywallSheet extends ConsumerWidget {
  const PaywallSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final l10n = AppLocalizations.of(context)!;

    final isAndroid = Platform.isAndroid;

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
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),

          Text("Bloom Premium", style: theme.textTheme.displaySmall),
          const SizedBox(height: 12),
          Text(
            // Текст зависит от платформы
            isAndroid
                ? "Pro version is currently in development for Android."
                : "Support development and unlock all features.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),

          const SizedBox(height: 32),

          // Показываем, что будет в Про версии (Маркетинг)
          _buildFeature(context, Icons.picture_as_pdf_outlined, l10n.settingsExportPdf ?? "PDF Export"),
          _buildFeature(context, Icons.backup_outlined, "Full Cloud Backup (Soon)"),
          _buildFeature(context, Icons.insights, "Advanced Health Insights"),
          _buildFeature(context, Icons.check_circle_outline, "No Ads (Always)"),

          const Spacer(),

          // --- ГЛАВНАЯ КНОПКА ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryColor.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(Icons.construction, size: 40, color: primaryColor),
                const SizedBox(height: 12),
                Text(
                  isAndroid
                      ? "Payments are not yet available in your region."
                      : "Coming Soon",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "We are working hard to bring Premium features to everyone. Stay tuned for updates!",
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
            child: Text(l10n.commonUnderstood ?? "Understood", style: TextStyle(color: Colors.black87)),
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
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}