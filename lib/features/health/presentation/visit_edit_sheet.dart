import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import '../../../l10n/app_localizations.dart';

// Убрали старые импорты стилей
// import '../../../core/theme/app_theme.dart';

import '../domain/doctor_visit.dart';
// import '../data/doctor_visit_repository.dart'; // Заменили на общий
import '../../pregnancy/data/pregnancy_repository.dart';

class VisitEditSheet extends ConsumerStatefulWidget {
  final DoctorVisit? existingVisit; // Если null - создаем новый

  const VisitEditSheet({super.key, this.existingVisit});

  @override
  ConsumerState<VisitEditSheet> createState() => _VisitEditSheetState();
}

class _VisitEditSheetState extends ConsumerState<VisitEditSheet> {
  final _titleController = TextEditingController();
  final _doctorController = TextEditingController();
  final _questionsController = TextEditingController();
  final _notesController = TextEditingController();

  // Здоровье
  final _weightController = TextEditingController();
  final _bpSysController = TextEditingController();
  final _bpDiaController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    if (widget.existingVisit != null) {
      final v = widget.existingVisit!;
      _titleController.text = v.title;
      _doctorController.text = v.doctorName ?? "";
      _questionsController.text = v.questionsToAsk ?? "";
      _notesController.text = v.doctorNotes ?? "";
      if (v.weightKg != null) _weightController.text = v.weightKg.toString();
      if (v.bpSystolic != null) _bpSysController.text = v.bpSystolic.toString();
      if (v.bpDiastolic != null) _bpDiaController.text = v.bpDiastolic.toString();
      _selectedDate = v.date;
      _selectedTime = TimeOfDay.fromDateTime(v.date);
    }
  }

  Future<void> _pickDate() async {
    final theme = Theme.of(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (context, child) {
        // Кастомизируем календарь под нашу тему
        return Theme(
            data: theme.copyWith(
              colorScheme: theme.colorScheme.copyWith(
                primary: theme.primaryColor,
                onPrimary: Colors.white,
              ),
            ),
            child: child!
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _save() {
    if (_titleController.text.isEmpty) return;

    final dateToSave = DateTime(
        _selectedDate.year, _selectedDate.month, _selectedDate.day,
        _selectedTime.hour, _selectedTime.minute
    );

    final visit = DoctorVisit(
      id: widget.existingVisit?.id ?? Isar.autoIncrement,
      date: dateToSave,
      title: _titleController.text,
      doctorName: _doctorController.text,
      questionsToAsk: _questionsController.text,
      doctorNotes: _notesController.text,
      weightKg: double.tryParse(_weightController.text),
      bpSystolic: int.tryParse(_bpSysController.text),
      bpDiastolic: int.tryParse(_bpDiaController.text),
      isCompleted: widget.existingVisit?.isCompleted ?? false,
    );

    // Используем общий репозиторий
    ref.read(pregnancyRepositoryProvider).saveVisit(visit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- ТЕМИЗАЦИЯ ---
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final bgColor = theme.scaffoldBackgroundColor;
    final inputBgColor = theme.colorScheme.surfaceContainerHighest ?? Colors.grey.withOpacity(0.1);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: bgColor, // Динамический фон
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: mutedColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2)
              )
          ),
          const SizedBox(height: 16),

          // Шапка модалки
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.commonCancel, style: TextStyle(color: mutedColor))
              ),
              Text(
                  widget.existingVisit == null ? l10n.visitNew : l10n.visitEdit,
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
              ),
              TextButton(
                  onPressed: _save,
                  child: Text(l10n.commonSave, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold))
              ),
            ],
          ),
          const Divider(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // 1. ЧТО И КОГДА
                _buildSectionHeader(l10n.visitSectionMain, theme),
                _buildTextField(l10n.visitTitleHint, _titleController, theme),
                const SizedBox(height: 12),
                _buildTextField(l10n.visitDoctor, _doctorController, theme),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _pickDate,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: inputBgColor, borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Icon(Icons.calendar_today, size: 16, color: mutedColor),
                            const SizedBox(width: 8),
                            Text(DateFormat.yMMMd().format(_selectedDate), style: theme.textTheme.bodyMedium)
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: _pickTime,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: inputBgColor, borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Icon(Icons.access_time, size: 16, color: mutedColor),
                            const SizedBox(width: 8),
                            Text(_selectedTime.format(context), style: theme.textTheme.bodyMedium)
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // 2. ПОДГОТОВКА (ВОПРОСЫ)
                _buildSectionHeader(l10n.visitQuestions, theme),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    // Желтоватый цвет для заметок можно оставить или сделать адаптивным
                      color: const Color(0xFFFFFDE7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.withOpacity(0.2))
                  ),
                  child: TextField(
                    controller: _questionsController,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: l10n.visitQuestionsPlaceholder,
                        hintStyle: TextStyle(color: mutedColor.withOpacity(0.5))
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),

                const SizedBox(height: 32),

                // 3. РЕЗУЛЬТАТЫ (МЕДИЦИНА)
                _buildSectionHeader(l10n.visitResults, theme),
                Row(
                  children: [
                    Expanded(child: _buildTextField(l10n.visitWeight, _weightController, theme, isNumber: true)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _buildTextField(l10n.visitBpSys, _bpSysController, theme, isNumber: true)),
                          const SizedBox(width: 8),
                          Text("/", style: TextStyle(fontSize: 20, color: mutedColor)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildTextField(l10n.visitBpDia, _bpDiaController, theme, isNumber: true)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: inputBgColor, borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _notesController,
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: l10n.visitNotesHint,
                        hintStyle: TextStyle(color: mutedColor.withOpacity(0.5))
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
          title.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, ThemeData theme, {bool isNumber = false}) {
    final inputBgColor = theme.colorScheme.surfaceContainerHighest ?? Colors.grey.withOpacity(0.1);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: inputBgColor, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: mutedColor.withOpacity(0.5))
        ),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}