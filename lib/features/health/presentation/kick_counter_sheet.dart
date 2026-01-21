import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';

import '../../pregnancy/data/pregnancy_repository.dart';
import '../../health/domain/health_record.dart';

class KickCounterSheet extends ConsumerStatefulWidget {
  const KickCounterSheet({super.key});

  @override
  ConsumerState<KickCounterSheet> createState() => _KickCounterSheetState();
}

class _KickCounterSheetState extends ConsumerState<KickCounterSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Состояние таймера
  int _kicks = 0;
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTime = "00:00";
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _startTimer();
  }

  void _startTimer() {
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          final duration = _stopwatch.elapsed;
          _elapsedTime = "${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    _tabController.dispose();
    super.dispose();
  }

  void _addKick() {
    HapticFeedback.heavyImpact();
    setState(() {
      _kicks++;
    });

    if (_kicks == 10) {
      _finishSession(success: true);
    }
  }

  void _finishSession({bool success = false}) {
    _timer.cancel();
    _stopwatch.stop();
    setState(() => _isActive = false);

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
            success ? l10n.kickDialogTitle : l10n.kickSessionDone,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24)
        ),
        content: Text(
          l10n.kickDialogBody(_kicks, _elapsedTime),
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Отмена: возвращаемся к таймеру
              Navigator.pop(context);
              _startTimer();
              setState(() => _isActive = true);
            },
            child: Text(l10n.commonCancel, style: TextStyle(color: mutedColor)),
          ),
          TextButton(
            onPressed: () {
              // Сохранение
              ref.read(pregnancyRepositoryProvider).saveKickSession(
                  date: DateTime.now(),
                  kicks: _kicks
              );
              Navigator.pop(context); // Закрываем диалог

              // Переходим на вкладку истории
              _tabController.animateTo(1);

              // Сбрасываем таймер
              setState(() {
                _kicks = 0;
                _elapsedTime = "00:00";
                _stopwatch.reset();
                _isActive = false;
              });
            },
            child: Text(l10n.commonSave, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Темный фон
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white54),
          onPressed: () => Navigator.pop(context),
        ),
        title: TabBar(
          controller: _tabController,
          indicatorColor: primaryColor,
          labelColor: primaryColor,
          unselectedLabelColor: Colors.white38,
          dividerColor: Colors.transparent,
          tabs: [
            Tab(text: l10n.kickTabTimer),   // Используем ключи из l10n
            Tab(text: l10n.kickTabHistory),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Вкладка 1: ТАЙМЕР
          _buildTimerTab(context, primaryColor, l10n),

          // Вкладка 2: ИСТОРИЯ
          _buildHistoryTab(context, primaryColor, l10n),
        ],
      ),
    );
  }

  Widget _buildTimerTab(BuildContext context, Color primaryColor, AppLocalizations l10n) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),

            Text(
                l10n.kickTitle,
                style: const TextStyle(
                    color: Colors.white38,
                    letterSpacing: 2,
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                )
            ),
            const SizedBox(height: 8),
            Text(
                _elapsedTime,
                style: const TextStyle(color: Colors.white, fontSize: 56, fontWeight: FontWeight.w200, fontFamily: 'Courier')
            ),

            const Spacer(),

            // КНОПКА - СТУПНЯ
            GestureDetector(
              onTap: _isActive ? _addKick : () {
                // Если сессия не активна, запускаем новую
                _startTimer();
                setState(() => _isActive = true);
                _addKick();
              },
              child: Container(
                width: 260, height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      primaryColor.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                  border: Border.all(color: primaryColor.withOpacity(0.5), width: 1),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, color: Colors.white, size: 80)
                          .animate(target: _kicks > 0 ? 1 : 0)
                          .scale(curve: Curves.elasticOut, duration: 300.ms),

                      const SizedBox(height: 16),
                      Text(
                          _isActive ? l10n.kickInstruction : l10n.kickBtnStart,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70, fontSize: 16)
                      ),
                    ],
                  ),
                ),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
                .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.05, 1.05), duration: 2000.ms),

            const Spacer(),

            // СЧЕТЧИК
            if (_isActive) ...[
              Text(
                  l10n.kickCount(_kicks),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: (_kicks / 10).clamp(0.0, 1.0),
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
              ),
              const SizedBox(height: 8),
              if (_kicks < 10)
                Text(l10n.kickGoal, style: const TextStyle(color: Colors.white38)),
            ] else ...[
              // Кнопка сброса, если таймер остановлен
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _kicks = 0;
                      _elapsedTime = "00:00";
                      _stopwatch.reset();
                      _startTimer();
                      _isActive = true;
                    });
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white54),
                  label: Text(l10n.nameReset, style: const TextStyle(color: Colors.white54))
              )
            ],

            const Spacer(),

            // Кнопка ручного завершения
            if (_isActive && _kicks > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: TextButton(
                  onPressed: () => _finishSession(success: false),
                  child: Text(
                      "Finish Session", // Можно вынести в l10n
                      style: TextStyle(color: primaryColor)
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab(BuildContext context, Color primaryColor, AppLocalizations l10n) {
    // Получаем историю из репозитория
    final historyAsync = ref.watch(pregnancyRepositoryProvider).watchKickHistory();

    return StreamBuilder<List<HealthRecord>>(
      stream: historyAsync,
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
                Icon(Icons.history, size: 64, color: Colors.white.withOpacity(0.1)),
                const SizedBox(height: 16),
                Text(
                  l10n.kickHistoryEmpty,
                  style: TextStyle(color: Colors.white.withOpacity(0.3)),
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
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  // Дата
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle
                    ),
                    child: Text(
                      DateFormat('dd').format(record.date),
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Информация
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(record.date),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$sessions sessions",
                          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  // Кол-во пинков
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "$kicks",
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(
                        "kicks",
                        style: TextStyle(color: primaryColor.withOpacity(0.7), fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}