import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../data/health_repository.dart';

class WaterSheet extends ConsumerStatefulWidget {
  const WaterSheet({super.key});

  @override
  ConsumerState<WaterSheet> createState() => _WaterSheetState();
}

class _WaterSheetState extends ConsumerState<WaterSheet> {
  final int _goal = 8;
  int _glasses = 0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final record = await ref
        .read(healthRepositoryProvider)
        .getRecordForDate(DateTime.now());
    if (!mounted) {
      return;
    }

    setState(() {
      _glasses = record.waterGlasses;
    });
  }

  Future<void> _updateWater(int delta) async {
    if (_isSaving) {
      return;
    }

    final previousValue = _glasses;
    final nextValue = (_glasses + delta).clamp(0, 15);
    if (nextValue == previousValue) {
      return;
    }

    setState(() {
      _glasses = nextValue;
      _isSaving = true;
    });

    try {
      if (delta > 0) {
        await ref.read(healthRepositoryProvider).addWaterGlass(DateTime.now());
      } else {
        await ref
            .read(healthRepositoryProvider)
            .removeWaterGlass(DateTime.now());
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _glasses = previousValue;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;
    final progress = (_glasses / _goal).clamp(0.0, 1.0);

    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: mutedColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            l10n.waterTitle,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.waterFact,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: mutedColor,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE0F7FA), width: 2),
                ),
              ),
              AnimatedContainer(
                duration: 600.ms,
                curve: Curves.easeOutBack,
                width: 200 * (0.2 + progress * 0.8),
                height: 200 * (0.2 + progress * 0.8),
                decoration: BoxDecoration(
                  color: const Color(0xFFB2EBF2).withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$_glasses',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
                  ),
                  Text(l10n.waterProgress(_goal),
                      style: theme.textTheme.labelSmall),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                Icons.remove,
                () => _updateWater(-1),
                theme,
              ),
              const SizedBox(width: 40),
              _buildButton(
                Icons.add,
                () => _updateWater(1),
                theme,
                isPrimary: true,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_isSaving)
            SizedBox(
              height: 20,
              child: Text(
                l10n.commonSave,
                style: theme.textTheme.labelSmall?.copyWith(color: mutedColor),
              ),
            )
          else
            const SizedBox(height: 20),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildButton(
    IconData icon,
    VoidCallback onTap,
    ThemeData theme, {
    bool isPrimary = false,
  }) {
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final secondaryBg = theme.colorScheme.surfaceContainerHighest;
    final isDisabled = _isSaving;

    final button = Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFE0F7FA) : secondaryBg,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 32,
        color:
            isDisabled ? mainTextColor.withValues(alpha: 0.4) : mainTextColor,
      ),
    );

    final clickable = GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Opacity(opacity: isDisabled ? 0.6 : 1, child: button),
    );

    if (isPrimary) {
      return clickable
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scaleXY(end: 1.1, duration: 1.5.seconds, curve: Curves.easeInOut);
    }

    return clickable;
  }
}
