import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';
import '../data/labor_mode_provider.dart';
import 'labor_contraction_timer.dart';

class LaborDashboard extends ConsumerWidget {
  const LaborDashboard({super.key});

  Future<void> _openHospital(
    BuildContext context,
    PregnancySettings? settings,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    if (settings?.hospitalAddress == null ||
        settings!.hospitalAddress!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorNoHospitalAddress)),
      );
      return;
    }

    final query = Uri.encodeComponent(settings.hospitalAddress!);
    final mapUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );

    try {
      final didLaunch = await launchUrl(
        mapUrl,
        mode: LaunchMode.externalApplication,
      );
      if (!didLaunch && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorOpenBrowser)),
        );
      }
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorOpenBrowser)),
      );
    }
  }

  Future<void> _callDoctor(
    BuildContext context,
    PregnancySettings? settings,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    if (settings?.doctorPhone == null || settings!.doctorPhone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorNoDoctorPhone)),
      );
      return;
    }

    final phoneUrl = Uri.parse('tel:${settings.doctorPhone}');

    try {
      final canLaunch = await canLaunchUrl(phoneUrl);
      if (!canLaunch) {
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorGeneric)),
        );
        return;
      }

      final didLaunch = await launchUrl(phoneUrl);
      if (!didLaunch && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.errorGeneric)),
        );
      }
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorGeneric)),
      );
    }
  }

  void _showExitDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        var isEnding = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.laborExitTitle),
              content: Text(l10n.laborExitBody),
              actions: [
                TextButton(
                  onPressed:
                      isEnding ? null : () => Navigator.pop(dialogContext),
                  child: Text(l10n.commonCancel),
                ),
                TextButton(
                  onPressed: isEnding
                      ? null
                      : () async {
                          setState(() => isEnding = true);
                          try {
                            await ref
                                .read(laborModeProvider.notifier)
                                .toggleLaborMode(false);
                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);
                            }
                          } catch (_) {
                            if (!dialogContext.mounted) {
                              return;
                            }
                            Navigator.pop(dialogContext);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.errorGeneric)),
                            );
                          }
                        },
                  child: isEnding
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          l10n.laborExitEndBtn,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsStream =
        ref.watch(pregnancyRepositoryProvider).watchSettings();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.laborModeTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF9A9E),
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        l10n.laborMotivationalQuote,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _showExitDialog(context, ref),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LaborContractionTimer(),
              ),
            ),
            StreamBuilder<PregnancySettings?>(
              stream: settingsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(height: 100);
                }

                final settings = snapshot.data;
                return Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: _EmergencyBtn(
                          icon: Icons.map,
                          label: l10n.laborHospitalBtn,
                          color: Colors.blueAccent,
                          onTap: () => _openHospital(context, settings),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _EmergencyBtn(
                          icon: Icons.call,
                          label: l10n.laborDoctorBtn,
                          color: Colors.green,
                          onTap: () => _callDoctor(context, settings),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Future<void> Function() onTap;

  const _EmergencyBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
