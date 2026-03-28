import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../l10n/app_localizations.dart'; // <--- ИМПОРТ L10N

import '../data/checklist_item.dart';
import '../../../main.dart';

part 'checklist_repository.g.dart';

@Riverpod(keepAlive: true)
ChecklistRepository checklistRepository(ChecklistRepositoryRef ref) {
  return ChecklistRepository(isarInstance);
}

class ChecklistRepository {
  final Isar _isar;

  ChecklistRepository(this._isar);

  // Получить все элементы
  Stream<List<ChecklistItem>> watchItems() {
    return _isar.checklistItems.where().watch(fireImmediately: true);
  }

  // Переключить галочку
  Future<void> toggleItem(int id) async {
    await _isar.writeTxn(() async {
      final item = await _isar.checklistItems.get(id);
      if (item != null) {
        item.isCompleted = !item.isCompleted;
        await _isar.checklistItems.put(item);
      }
    });
  }

  // Инициализация (Заполняем базу, если пусто)
  // ТЕПЕРЬ ПРИНИМАЕМ l10n
  Future<void> ensureInitialized(AppLocalizations l10n) async {
    final count = await _isar.checklistItems.count();
    if (count == 0) {
      // Генерируем список на основе текущего языка
      final List<ChecklistItem> defaultItems = [
        // ДОКУМЕНТЫ
        ChecklistItem(title: l10n.checkDocPassport, category: "docs"),
        ChecklistItem(title: l10n.checkDocRecords, category: "docs"),
        ChecklistItem(title: l10n.checkDocInsurance, category: "docs"),
        ChecklistItem(title: l10n.checkDocContract, category: "docs"),
        ChecklistItem(title: l10n.checkDocTests, category: "docs"),

        // МАМЕ (В РОДЗАЛ)
        ChecklistItem(title: l10n.checkMomSlippers, category: "mom"),
        ChecklistItem(title: l10n.checkMomWater, category: "mom"),
        ChecklistItem(title: l10n.checkMomSocks, category: "mom"),
        ChecklistItem(title: l10n.checkMomLipBalm, category: "mom"),
        ChecklistItem(title: l10n.checkMomCharger, category: "mom"),

        // МАМЕ (ПОСЛЕ РОДОВ)
        ChecklistItem(title: l10n.checkMomPads, category: "mom"),
        ChecklistItem(title: l10n.checkMomUnderwear, category: "mom"),
        ChecklistItem(title: l10n.checkMomBra, category: "mom"),
        ChecklistItem(title: l10n.checkMomCream, category: "mom"),
        ChecklistItem(title: l10n.checkMomHygiene, category: "mom"),

        // МАЛЫШУ
        ChecklistItem(title: l10n.checkBabyDiapers, category: "baby"),
        ChecklistItem(title: l10n.checkBabyWipes, category: "baby"),
        ChecklistItem(title: l10n.checkBabyCream, category: "baby"),
        ChecklistItem(title: l10n.checkBabyClothes, category: "baby"),
        ChecklistItem(title: l10n.checkBabyHat, category: "baby"),
        ChecklistItem(title: l10n.checkBabyOutfit, category: "baby"),
      ];

      await _isar.writeTxn(() async {
        await _isar.checklistItems.putAll(defaultItems);
      });
    }
  }
}
