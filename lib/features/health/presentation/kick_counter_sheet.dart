import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../health/domain/health_record.dart';
import '../../pregnancy/data/pregnancy_repository.dart';

class KickCounterSheet extends ConsumerStatefulWidget {
  const KickCounterSheet({super.key});

  @override
  ConsumerState<KickCounterSheet> createState() => _KickCounterSheetState();
}

class _KickCounterSheetState extends ConsumerState<KickCounterSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Stopwatch _stopwatch;
  Timer? _timer;

  int _kicks = 0;
  String _elapsedTime = '00:00';
  bool _isActive = false; // ✅ ИСПРАВЛЕНО: Начинаем в неактивном состоянии
  bool _isSavingSession = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _stopwatch = Stopwatch(); // ✅ Создаём Stopwatch, но НЕ запускаем таймер
  }

  void _startTimer() {
    _timer?.cancel();
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        final duration = _stopwatch.elapsed;
        _elapsedTime =
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();
    _tabController.dispose();
    super.dispose();
  }

  void _addKick() {
    HapticFeedback.heavyImpact();
    setState(() => _kicks++);

    if (_kicks == 10) {
      _finishSession(success: true);
    }
  }

  void _resetSession({bool startImmediately = false}) {
    _timer?.cancel();
    _stopwatch
      ..reset()
      ..stop();

    setState(() {
      _kicks = 0;
      _elapsedTime = '00:00';
      _isActive = startImmediately;
      _isSavingSession = false;
    });

    if (startImmediately) {
      _startTimer();
    }
  }

  Future<void> _saveSession(BuildContext dialogContext, void Function(void Function()) setModalState) async {
    try {
      await ref.read(pregnancyRepositoryProvider).saveKickSession(
        date: DateTime.now(),
        kicks: _kicks,
      );

      if (!mounted || !dialogContext.mounted) return;

      Navigator.pop(dialogContext);
      _tabController.animateTo(1);
      _resetSession();
    } catch (_) {
      if (!mounted) return;

      setState(() => _isSavingSession = false);
      setModalState(() => _isSavingSession = false);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorGeneric)),
      );
    }
  }

  void _finishSession({bool success = false}) {
    _timer?.cancel();
    _stopwatch.stop();
    setState(() {
      _isActive = false;
      _isSavingSession = false;
    });

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          title: Text(
            success ? l10n.kickDialogTitle : l10n.kickSessionDone,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          content: Text(
            l10n.kickDialogBody(_kicks, _elapsedTime),
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: _isSavingSession
                  ? null
                  : () {
                      Navigator.pop(dialogContext);
                      _startTimer();
                      setState(() => _isActive = true);
                    },
              child: Text(
                l10n.commonCancel,
                style: TextStyle(color: mutedColor),
              ),
            ),
            TextButton(
              onPressed: _isSavingSession
                  ? null
                  : () async {
                      setState(() => _isSavingSession = true);
                      setModalState(() => _isSavingSession = true);
                      await _saveSession(dialogContext, setModalState);
                    },
              child: _isSavingSession
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    )
                  : Text(
                      l10n.commonSave,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E1E2C),
              Color(0xFF121212),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
                title: TabBar(
                  controller: _tabController,
                  indicatorColor: primaryColor,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white38,
                  dividerColor: Colors.transparent,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  tabs: [
                    Tab(text: l10n.kickTabTimer),
                    Tab(text: l10n.kickTabHistory),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTimerTab(context, primaryColor, l10n),
                    _buildHistoryTab(context, primaryColor, l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerTab(
      BuildContext context,
      Color primaryColor,
      AppLocalizations l10n,
      ) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Text(
                l10n.kickTitle.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white54,
                  letterSpacing: 3,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _elapsedTime,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.w100,
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 3000.ms, color: Colors.white24),
            const Spacer(),
            GestureDetector(
              onTap: _isActive
                  ? _addKick
                  : () {
                _resetSession(startImmediately: true);
                _addKick();
              },
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: _isActive ? 0.3 : 0.1),
                      blurRadius: 50,
                      spreadRadius: _isActive ? 10 : 0,
                    ),
                  ],
                  gradient: RadialGradient(
                    colors: [
                      primaryColor.withValues(alpha: 0.4),
                      primaryColor.withValues(alpha: 0.05),
                    ],
                  ),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_rounded, color: Colors.white, size: _isActive ? 90 : 70)
                          .animate(target: _kicks > 0 ? 1 : 0)
                          .scale(
                        curve: Curves.elasticOut,
                        duration: 500.ms,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _isActive ? l10n.kickInstruction : l10n.kickBtnStart,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                .animate(
                onPlay: (controller) => controller.repeat(reverse: true))
                .scale(
              begin: const Offset(0.97, 0.97),
              end: const Offset(1.03, 1.03),
              duration: 2000.ms,
              curve: Curves.easeInOutSine,
            ),
            const Spacer(),
            if (_isActive) ...[
              Text(
                l10n.kickCount(_kicks),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ).animate(key: ValueKey(_kicks)).slideY(begin: 0.2, end: 0, duration: 200.ms).fadeIn(),
              const SizedBox(height: 20),
              SizedBox(
                width: 240,
                height: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (_kicks / 10).clamp(0.0, 1.0),
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (_kicks < 10)
                Text(
                  l10n.kickGoal,
                  style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w500),
                ),
            ] else ...[
              TextButton.icon(
                onPressed: () => _resetSession(startImmediately: true),
                icon: const Icon(Icons.refresh, color: Colors.white54),
                label: Text(
                  l10n.nameReset,
                  style: const TextStyle(color: Colors.white54),
                ),
              ),
            ],
            const Spacer(),
            if (_isActive && _kicks > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: TextButton(
                  onPressed: () => _finishSession(success: false),
                  // ИСПРАВЛЕНО: Заменен хардкод на l10n
                  child: Text(
                    l10n.kickSessionDone,
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab(
      BuildContext context,
      Color primaryColor,
      AppLocalizations l10n,
      ) {
    final historyStream =
    ref.watch(pregnancyRepositoryProvider).watchKickHistory();

    return StreamBuilder<List<HealthRecord>>(
      stream: historyStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final records = snapshot.data!;
        if (records.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 64,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.kickHistoryEmpty,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            final kicks = record.totalKicks;
            final sessions = record.kickSessionsCount;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.05),
                    Colors.white.withValues(alpha: 0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  // Date Badge
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd').format(record.date),
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          DateFormat('MMM').format(record.date).toUpperCase(),
                          style: TextStyle(
                            color: primaryColor.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.kickTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.replay_circle_filled_rounded, color: Colors.white54, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$sessions',
                                    style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (kicks >= 10)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 14),
                                    SizedBox(width: 4),
                                    Text('Goal', style: TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Total Kicks
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$kicks',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}