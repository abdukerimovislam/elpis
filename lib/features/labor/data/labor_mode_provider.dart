import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';

part 'labor_mode_provider.g.dart';

@Riverpod(keepAlive: true)
class LaborMode extends _$LaborMode {
  @override
  bool build() {
    return false;
  }

  Future<void> toggleLaborMode(bool isActive) async {
    final repo = ref.read(pregnancyRepositoryProvider);
    await repo.updateSettings(isLaborMode: isActive);
  }

  Future<void> saveContacts({
    String? partnerName,
    String? partnerPhone,
    String? doctorPhone,
    String? hospitalAddress,
  }) async {
    final repo = ref.read(pregnancyRepositoryProvider);

    await repo.updateSettings(
      partnerName: partnerName,
      partnerPhone: partnerPhone,
      doctorPhone: doctorPhone,
      hospitalAddress: hospitalAddress,
    );
  }

  Future<void> notifyPartner(
    BuildContext context,
    String phone,
    String partnerName,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final message =
        l10n.laborHelpMessage(partnerName.isNotEmpty ? partnerName : "Honey");
    final encodedMessage = Uri.encodeComponent(message);

    final whatsappUrl =
        Uri.parse("whatsapp://send?phone=$phone&text=$encodedMessage");
    final smsUrl = Uri.parse("sms:$phone?body=$encodedMessage");

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        final didLaunch = await launchUrl(
          whatsappUrl,
          mode: LaunchMode.externalApplication,
        );
        if (!didLaunch) {
          throw StateError("Could not launch WhatsApp");
        }
        return;
      }

      if (await canLaunchUrl(smsUrl)) {
        final didLaunch = await launchUrl(
          smsUrl,
          mode: LaunchMode.externalApplication,
        );
        if (!didLaunch) {
          throw StateError("Could not launch SMS");
        }
        return;
      }

      throw StateError("Could not launch SMS or WhatsApp");
    } catch (e) {
      debugPrint("Could not launch emergency contact: $e");
      rethrow;
    }
  }
}
