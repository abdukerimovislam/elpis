import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../domain/doctor_visit.dart';

class VisitEditSheet extends ConsumerStatefulWidget {
  final DoctorVisit? existingVisit;

  const VisitEditSheet({super.key, this.existingVisit});

  @override
  ConsumerState<VisitEditSheet> createState() => _VisitEditSheetState();
}

class _VisitEditSheetState extends ConsumerState<VisitEditSheet> {
  final _titleController = TextEditingController();
  final _doctorController = TextEditingController();
  final _questionsController = TextEditingController();
  final _notesController = TextEditingController();
  final _weightController = TextEditingController();
  final _bpSysController = TextEditingController();
  final _bpDiaController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingVisit != null) {
      final visit = widget.existingVisit!;
      _titleController.text = visit.title;
      _doctorController.text = visit.doctorName ?? '';
      _questionsController.text = visit.questionsToAsk ?? '';
      _notesController.text = visit.doctorNotes ?? '';
      if (visit.weightKg != null) {
        _weightController.text = visit.weightKg.toString();
      }
      if (visit.bpSystolic != null) {
        _bpSysController.text = visit.bpSystolic.toString();
      }
      if (visit.bpDiastolic != null) {
        _bpDiaController.text = visit.bpDiastolic.toString();
      }
      _selectedDate = visit.date;
      _selectedTime = TimeOfDay.fromDateTime(visit.date);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _doctorController.dispose();
    _questionsController.dispose();
    _notesController.dispose();
    _weightController.dispose();
    _bpSysController.dispose();
    _bpDiaController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final theme = Theme.of(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  Future<void> _save() async {
    if (_titleController.text.isEmpty || _isSaving) {
      return;
    }

    setState(() => _isSaving = true);

    final dateToSave = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
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
      isCompleted: (widget.existingVisit?.isCompleted ?? false) ||
          _notesController.text.trim().isNotEmpty ||
          _weightController.text.trim().isNotEmpty ||
          _bpSysController.text.trim().isNotEmpty ||
          _bpDiaController.text.trim().isNotEmpty,
    );

    try {
      await ref.read(pregnancyRepositoryProvider).saveVisit(visit);
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
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final bgColor = theme.scaffoldBackgroundColor;
    final inputBgColor = theme.colorScheme.surfaceContainerHighest;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _isSaving ? null : () => Navigator.pop(context),
                child: Text(
                  l10n.commonCancel,
                  style: TextStyle(color: mutedColor),
                ),
              ),
              Text(
                widget.existingVisit == null ? l10n.visitNew : l10n.visitEdit,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
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
          const Divider(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildSectionHeader(l10n.visitSectionMain, theme),
                _buildTextField(l10n.visitTitleHint, _titleController, theme),
                const SizedBox(height: 12),
                _buildTextField(l10n.visitDoctor, _doctorController, theme),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _isSaving ? null : _pickDate,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: inputBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: mutedColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: _isSaving ? null : _pickTime,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: inputBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: mutedColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedTime.format(context),
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildSectionHeader(l10n.visitQuestions, theme),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFDE7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.2),
                    ),
                  ),
                  child: TextField(
                    controller: _questionsController,
                    maxLines: 4,
                    enabled: !_isSaving,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: l10n.visitQuestionsPlaceholder,
                      hintStyle:
                          TextStyle(color: mutedColor.withValues(alpha: 0.5)),
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 32),
                _buildSectionHeader(l10n.visitResults, theme),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        l10n.visitWeight,
                        _weightController,
                        theme,
                        isNumber: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              l10n.visitBpSys,
                              _bpSysController,
                              theme,
                              isNumber: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '/',
                            style: TextStyle(fontSize: 20, color: mutedColor),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildTextField(
                              l10n.visitBpDia,
                              _bpDiaController,
                              theme,
                              isNumber: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _notesController,
                    maxLines: 4,
                    enabled: !_isSaving,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: l10n.visitNotesHint,
                      hintStyle:
                          TextStyle(color: mutedColor.withValues(alpha: 0.5)),
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
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller,
    ThemeData theme, {
    bool isNumber = false,
  }) {
    final inputBgColor = theme.colorScheme.surfaceContainerHighest;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        enabled: !_isSaving,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: mutedColor.withValues(alpha: 0.5)),
        ),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
