import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/labor_mode_provider.dart';

// ИМПОРТ ЛОКАЛИЗАЦИИ
import '../../../l10n/app_localizations.dart';

// ИМПОРТЫ
import 'labor_contraction_timer.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../../pregnancy/domain/pregnancy_settings.dart';

class LaborDashboard extends ConsumerWidget {
  const LaborDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsStream = ref.watch(pregnancyRepositoryProvider).watchSettings();
    final l10n = AppLocalizations.of(context)!; // Локализация

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column( // Убрал const
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          l10n.laborModeTitle, // Убрал const
                          style: const TextStyle( // Стиль может быть const
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFF9A9E),
                              letterSpacing: 2
                          )
                      ),
                      Text(
                          l10n.laborMotivationalQuote, // Убрал const
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _showExitDialog(context, ref),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  )
                ],
              ),
            ),

            // --- MAIN CONTENT ---
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: LaborContractionTimer(),
              ),
            ),

            // --- BOTTOM ACTIONS ---
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
                            label: l10n.laborHospitalBtn, // Убрал const
                            color: Colors.blueAccent,
                            onTap: () {
                              if (settings?.hospitalAddress != null && settings!.hospitalAddress!.isNotEmpty) {
                                final query = Uri.encodeComponent(settings.hospitalAddress!);
                                final mapUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");
                                launchUrl(mapUrl, mode: LaunchMode.externalApplication);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(l10n.errorNoHospitalAddress))
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _EmergencyBtn(
                            icon: Icons.call,
                            label: l10n.laborDoctorBtn, // Убрал const
                            color: Colors.green,
                            onTap: () async {
                              if (settings?.doctorPhone != null && settings!.doctorPhone!.isNotEmpty) {
                                final phoneUrl = Uri.parse("tel:${settings.doctorPhone}");
                                if (await canLaunchUrl(phoneUrl)) {
                                  await launchUrl(phoneUrl);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(l10n.errorNoDoctorPhone))
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.laborExitTitle), // Убрал const
        content: Text(l10n.laborExitBody), // Убрал const
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel), // Убрал const
          ),
          TextButton(
            onPressed: () {
              ref.read(laborModeProvider.notifier).toggleLaborMode(false);
              Navigator.pop(context);
            },
            child: Text(l10n.laborExitEndBtn, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _EmergencyBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _EmergencyBtn({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}