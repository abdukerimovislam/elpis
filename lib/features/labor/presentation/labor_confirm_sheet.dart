import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../data/labor_mode_provider.dart';

class LaborConfirmSheet extends ConsumerStatefulWidget {
  const LaborConfirmSheet({super.key});

  @override
  ConsumerState<LaborConfirmSheet> createState() => _LaborConfirmSheetState();
}

class _LaborConfirmSheetState extends ConsumerState<LaborConfirmSheet> {
  final _phoneController = TextEditingController();
  bool _isNotifying = true;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(pregnancyRepositoryProvider).watchSettings().first;
    settings.then((s) {
      if (s?.partnerPhone != null) {
        _phoneController.text = s!.partnerPhone!;
      }
    });
  }

  void _startLabor() async {
    final phone = _phoneController.text.trim();

    // Сохраняем телефон, если изменился
    if (phone.isNotEmpty) {
      await ref.read(laborModeProvider.notifier).saveContacts(partnerPhone: phone);
    }

    await ref.read(laborModeProvider.notifier).toggleLaborMode(true);

    if (_isNotifying && phone.isNotEmpty && mounted) {
      // Имя партнера можно подтянуть из настроек, пока заглушка "Partner"
      await ref.read(laborModeProvider.notifier).notifyPartner(context, phone, "");
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.only(
          left: 24, right: 24, top: 32,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.laborConfirmTitle, // Убрал const
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.laborConfirmBody, // Убрал const
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 32),

          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: l10n.laborConfirmPartnerPhone, // Убрал const
              prefixIcon: const Icon(Icons.phone),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),

          const SizedBox(height: 16),

          SwitchListTile(
            value: _isNotifying,
            onChanged: (val) => setState(() => _isNotifying = val),
            title: Text(l10n.laborConfirmNotifySwitch), // Убрал const
            activeColor: const Color(0xFFFF9A9E),
            contentPadding: EdgeInsets.zero,
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _startLabor,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: const Color(0xFFFF9A9E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 8,
                shadowColor: const Color(0xFFFF9A9E).withOpacity(0.5),
              ),
              child: Text(
                l10n.laborConfirmStartBtn, // Убрал const
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.laborConfirmFalseAlarm, style: const TextStyle(color: Colors.grey)), // Убрал const
            ),
          )
        ],
      ),
    );
  }
}