import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

// ИМПОРТ ЛОКАЛИЗАЦИИ
import '../../../l10n/app_localizations.dart';

// ИМПОРТЫ РЕПОЗИТОРИЯ
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';

part 'labor_mode_provider.g.dart';

@Riverpod(keepAlive: true)
class LaborMode extends _$LaborMode {
  @override
  bool build() {
    // Этот провайдер работает как контроллер действий.
    // Реальное состояние (включен режим или нет) UI слушает напрямую из репозитория (Stream).
    return false;
  }

  /// Включение / Выключение режима
  Future<void> toggleLaborMode(bool isActive) async {
    final repo = ref.read(pregnancyRepositoryProvider);
    await repo.updateSettings(isLaborMode: isActive);
  }

  /// Сохранение контактов (вызывается из настроек или модального окна)
  Future<void> saveContacts({
    String? partnerName,
    String? partnerPhone,
    String? doctorPhone,
    String? hospitalAddress,
  }) async {
    final repo = ref.read(pregnancyRepositoryProvider);

    // Теперь метод updateSettings поддерживает эти аргументы
    await repo.updateSettings(
      partnerName: partnerName,
      partnerPhone: partnerPhone,
      doctorPhone: doctorPhone,
      hospitalAddress: hospitalAddress,
    );
  }

  /// ЭКСТРЕННОЕ УВЕДОМЛЕНИЕ (WhatsApp -> SMS)
  Future<void> notifyPartner(BuildContext context, String phone, String partnerName) async {
    final l10n = AppLocalizations.of(context)!;

    // 1. Формируем локализованное сообщение
    // "🚨 {name}, IT'S TIME!..."
    final message = l10n.laborHelpMessage(partnerName.isNotEmpty ? partnerName : "Honey");

    final encodedMessage = Uri.encodeComponent(message);

    // 2. Ссылки для WhatsApp и SMS
    final whatsappUrl = Uri.parse("whatsapp://send?phone=$phone&text=$encodedMessage");
    final smsUrl = Uri.parse("sms:$phone?body=$encodedMessage");

    try {
      // Пытаемся открыть WhatsApp
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        // Если нет WhatsApp, открываем SMS
        if (await canLaunchUrl(smsUrl)) {
          await launchUrl(smsUrl, mode: LaunchMode.externalApplication);
        } else {
          debugPrint("Could not launch SMS or WhatsApp");
        }
      }
    } catch (e) {
      debugPrint("Could not launch emergency contact: $e");
    }
  }
}