import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../data/labor_mode_provider.dart';

class LaborConfirmSheet extends ConsumerStatefulWidget {
  const LaborConfirmSheet({super.key});

  @override
  ConsumerState<LaborConfirmSheet> createState() => _LaborConfirmSheetState();
}

class _LaborConfirmSheetState extends ConsumerState<LaborConfirmSheet> {
  final _phoneController = TextEditingController();

  bool _isNotifying = true;
  bool _isStarting = false;

  @override
  void initState() {
    super.initState();
    _loadPartnerPhone();
  }

  Future<void> _loadPartnerPhone() async {
    final settings =
        await ref.read(pregnancyRepositoryProvider).watchSettings().first;

    if (!mounted || settings?.partnerPhone == null) {
      return;
    }

    _phoneController.text = settings!.partnerPhone!;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _startLabor() async {
    if (_isStarting) {
      return;
    }

    final phone = _phoneController.text.trim();
    setState(() => _isStarting = true);

    try {
      if (phone.isNotEmpty) {
        await ref.read(laborModeProvider.notifier).saveContacts(
              partnerPhone: phone,
            );
      }

      await ref.read(laborModeProvider.notifier).toggleLaborMode(true);

      if (_isNotifying && phone.isNotEmpty && mounted) {
        await ref
            .read(laborModeProvider.notifier)
            .notifyPartner(context, phone, '');
      }

      if (!mounted) {
        return;
      }
      Navigator.pop(context);
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
      );
      setState(() => _isStarting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 32,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
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
            l10n.laborConfirmTitle,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.laborConfirmBody,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            enabled: !_isStarting,
            decoration: InputDecoration(
              labelText: l10n.laborConfirmPartnerPhone,
              prefixIcon: const Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            value: _isNotifying,
            onChanged: _isStarting
                ? null
                : (value) => setState(() => _isNotifying = value),
            title: Text(l10n.laborConfirmNotifySwitch),
            activeThumbColor: const Color(0xFFFF9A9E),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isStarting ? null : _startLabor,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: const Color(0xFFFF9A9E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: const Color(0xFFFF9A9E).withValues(alpha: 0.5),
              ),
              child: _isStarting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      l10n.laborConfirmStartBtn,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: _isStarting ? null : () => Navigator.pop(context),
              child: Text(
                l10n.laborConfirmFalseAlarm,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
