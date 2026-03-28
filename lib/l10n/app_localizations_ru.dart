// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Aura';

  @override
  String weekLabel(int week) {
    return 'НЕДЕЛЯ $week';
  }

  @override
  String get menuHealth => 'Здоровье и тело';

  @override
  String get menuFamily => 'Семья и память';

  @override
  String get menuPrep => 'Подготовка';

  @override
  String get tabConnection => 'Связь';

  @override
  String get tabDetails => 'Детали';

  @override
  String get connectionTitle => 'Письмо малышу';

  @override
  String connectionTitleNamed(String name) {
    return 'Письмо для $name';
  }

  @override
  String get connectionPlaceholder => 'Напишите что-то вечное...';

  @override
  String get connectionSaveAction => 'Сохранить мысль';

  @override
  String get connectionOpenDiary => 'Открыть дневник';

  @override
  String get onboardingTitle => 'Когда ожидается ваше чудо?';

  @override
  String get onboardingSubtitle => 'Мы персонализируем путь для вас';

  @override
  String get onboardingNameHint => 'Имя малыша (необязательно)';

  @override
  String get onboardingAction => 'Начать путь';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsNameLabel => 'КАК МЫ НАЗЫВАЕМ МАЛЫША?';

  @override
  String get settingsNameHint => 'Например, Оливер или Бусинка';

  @override
  String get settingsDateLabel => 'ПРЕДПОЛАГАЕМАЯ ДАТА РОДОВ';

  @override
  String get settingsSave => 'Сохранить';

  @override
  String get settingsDeleteData => 'Удалить все данные';

  @override
  String get settingsDeleteDataConfirm =>
      'Вы уверены? Это удалит все ваши фото, имена и историю. Приложение перезапустится.';

  @override
  String get settingsPrivacy => 'Политика конфиденциальности';

  @override
  String get loadingTitle => 'Загрузка...';

  @override
  String get loadingBody => 'Получаем данные за эту неделю.';

  @override
  String weekDefault(Object week) {
    return 'Неделя $week';
  }

  @override
  String get waterTitle => 'Гидратация';

  @override
  String get waterFact =>
      'Вода помогает обновлять околоплодные воды каждые 3 часа.';

  @override
  String waterProgress(int goal) {
    return 'из $goal';
  }

  @override
  String get visitNew => 'Новый визит';

  @override
  String get visitEdit => 'Редактировать визит';

  @override
  String get visitSectionMain => 'ОСНОВНОЕ';

  @override
  String get visitTitleHint => 'Название (например, УЗИ)';

  @override
  String get visitDoctor => 'Врач / Клиника';

  @override
  String get visitQuestions => 'ВАШИ ВОПРОСЫ';

  @override
  String get visitQuestionsPlaceholder =>
      'Что спросить у врача?\n- Можно ли летать?\n- Какие витамины принимать?';

  @override
  String get visitResults => 'РЕЗУЛЬТАТЫ';

  @override
  String get visitWeight => 'Вес (кг)';

  @override
  String get visitBpSys => 'Сист.';

  @override
  String get visitBpDia => 'Диаст.';

  @override
  String get visitNotesHint => 'Заметки врача и назначения...';

  @override
  String get visitCalendar => 'Календарь визитов';

  @override
  String get visitEmpty => 'Нет предстоящих визитов';

  @override
  String get visitFab => 'Визит';

  @override
  String get visitBadgeQuestions => 'Вопросы';

  @override
  String get visitBadgeResults => 'Результаты';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonMin => 'мин';

  @override
  String get commonSec => 'сек';

  @override
  String get toolsTitle => 'Центр заботы';

  @override
  String get toolSymptoms => 'Самочувствие';

  @override
  String get toolSymptomsSub => 'Журнал симптомов';

  @override
  String get toolKegel => 'Кегель';

  @override
  String get toolKegelSub => 'Тазовое дно';

  @override
  String get toolNames => 'Имена малыша';

  @override
  String get toolNamesSub => 'Выбирайте вместе';

  @override
  String get toolContractions => 'Схватки';

  @override
  String get toolContractionsSub => 'Таймер родов';

  @override
  String get toolWeight => 'Вес';

  @override
  String get toolWeightSub => 'Трекер';

  @override
  String get toolWater => 'Вода';

  @override
  String get toolWaterSub => 'Гидратация';

  @override
  String get toolKicks => 'Шевеления';

  @override
  String get toolKicksSub => 'Счётчик';

  @override
  String get toolBag => 'Сумка в роддом';

  @override
  String get toolBagSub => 'Чек-лист';

  @override
  String get toolVisits => 'Визиты';

  @override
  String get toolVisitsSub => 'План и заметки';

  @override
  String get toolGallery => 'Галерея живота';

  @override
  String get toolGallerySub => 'Таймлапс живота';

  @override
  String get symptomTitle => 'Как вы себя чувствуете?';

  @override
  String get symptomMoodLabel => 'НАСТРОЕНИЕ';

  @override
  String get symptomLabel => 'СИМПТОМЫ';

  @override
  String get symptomSave => 'Сохранить';

  @override
  String get symNausea => 'Тошнота';

  @override
  String get symFatigue => 'Усталость';

  @override
  String get symHeartburn => 'Изжога';

  @override
  String get symSwelling => 'Отеки';

  @override
  String get symHeadache => 'Головная боль';

  @override
  String get symInsomnia => 'Бессонница';

  @override
  String get symBackPain => 'Боль в спине';

  @override
  String get symHunger => 'Голод';

  @override
  String get symBabyActive => 'Малыш активный';

  @override
  String get symAnxiety => 'Тревожность';

  @override
  String get kickTitle => 'СЕАНС СВЯЗИ';

  @override
  String get kickInstruction => 'Нажимайте при\nшевелении';

  @override
  String kickCount(int count) {
    return 'Шевеления: $count';
  }

  @override
  String get kickGoal => 'Цель: 10 шевелений';

  @override
  String get kickSessionDone => 'Сеанс завершён';

  @override
  String get kickDialogTitle => 'Отлично!';

  @override
  String kickDialogBody(int count, String time) {
    return 'Вы отметили $count шевелений за $time.';
  }

  @override
  String get kegelTitle => 'Тренировка Кегеля';

  @override
  String get kegelSubtitle =>
      'Укрепление мышц тазового дна подготавливает тело к родам.';

  @override
  String get kegelPhaseSqueeze => 'НАПРЯЖЕНИЕ';

  @override
  String get kegelPhaseSqueezeInstr => 'Напрягите мышцы';

  @override
  String get kegelPhaseRelax => 'РАССЛАБЛЕНИЕ';

  @override
  String get kegelPhaseRelaxInstr => 'Выдохните и расслабьтесь';

  @override
  String get kegelPhaseDone => 'Отлично!';

  @override
  String get kegelPhaseDoneInstr => 'Тренировка завершена';

  @override
  String kegelRepCounter(int current, int total) {
    return 'Повтор $current из $total';
  }

  @override
  String get kegelStart => 'Начать';

  @override
  String get kegelFinish => 'Завершить';

  @override
  String get contractionTitle => 'Схватки';

  @override
  String get contractionInstruction => 'Нажмите кнопку в начале схватки';

  @override
  String get contractionRelax => 'Отдыхайте и глубоко дышите';

  @override
  String get contractionLabelActive => 'СХВАТКА';

  @override
  String get contractionLabelRest => 'ОТДЫХ';

  @override
  String get contractionBtnStart => 'Старт';

  @override
  String get contractionBtnStop => 'Стоп';

  @override
  String get contractionHistory => 'ИСТОРИЯ';

  @override
  String get contractionColStart => 'Начало';

  @override
  String get contractionColDuration => 'Длительность';

  @override
  String get contractionColInterval => 'Частота';

  @override
  String get contractionEmpty => 'Пока нет записей';

  @override
  String get checklistTitle => 'Сумка в роддом';

  @override
  String checklistProgress(int percent) {
    return 'Собрано $percent%';
  }

  @override
  String get checklistTabDocs => 'Документы';

  @override
  String get checklistTabMom => 'Для мамы';

  @override
  String get checklistTabBaby => 'Для малыша';

  @override
  String get checklistEmpty => 'Пусто';

  @override
  String get checkDocPassport => 'Паспорт / ID';

  @override
  String get checkDocRecords => 'Обменная карта / записи';

  @override
  String get checkDocInsurance => 'Страховка';

  @override
  String get checkDocContract => 'Договор с роддомом';

  @override
  String get checkDocTests => 'Свежие анализы';

  @override
  String get checkMomSlippers => 'Моющиеся тапочки';

  @override
  String get checkMomWater => 'Вода (2 бутылки)';

  @override
  String get checkMomSocks => 'Тёплые носки / компрессионные';

  @override
  String get checkMomLipBalm => 'Бальзам для губ';

  @override
  String get checkMomCharger => 'Телефон и длинный зарядный кабель';

  @override
  String get checkMomPads => 'Послеродовые прокладки';

  @override
  String get checkMomUnderwear => 'Одноразовое бельё';

  @override
  String get checkMomBra => 'Бюстгальтер для кормления';

  @override
  String get checkMomCream => 'Крем для сосков';

  @override
  String get checkMomHygiene => 'Гигиена (щётка, мыло)';

  @override
  String get checkBabyDiapers => 'Подгузники (Newborn)';

  @override
  String get checkBabyWipes => 'Влажные салфетки (0+)';

  @override
  String get checkBabyCream => 'Крем под подгузник';

  @override
  String get checkBabyClothes => 'Боди / слипы (3–4)';

  @override
  String get checkBabyHat => 'Шапочка и носочки';

  @override
  String get checkBabyOutfit => 'Комплект на выписку';

  @override
  String get weightTitle => 'Контроль веса';

  @override
  String weightWeek(int week) {
    return 'Неделя $week';
  }

  @override
  String get weightInputHint => 'Введите вес, чтобы получить анализ';

  @override
  String get weightNoParams =>
      'Укажите «Вес до беременности» в настройках для умного анализа';

  @override
  String get weightUnit => 'кг';

  @override
  String get weightSave => 'Сохранить вес';

  @override
  String get weightFeedbackLow =>
      'Набор веса немного ниже среднего. Помните о сбалансированном питании.';

  @override
  String get weightFeedbackHigh =>
      'Набор веса немного выше среднего. Сосредоточьтесь на полезной еде и воде.';

  @override
  String get weightFeedbackNormal => 'Отлично! Набор веса идёт идеально.';

  @override
  String get nameTitle => 'Настройки поиска';

  @override
  String get nameReset => 'Сбросить';

  @override
  String get nameGenderLabel => 'ПОЛ';

  @override
  String get nameGenderAny => 'Любой';

  @override
  String get nameGenderBoy => 'Мальчик';

  @override
  String get nameGenderGirl => 'Девочка';

  @override
  String get nameActionShow => 'Показать имена';

  @override
  String get nameTabSearch => 'Поиск';

  @override
  String get nameTabFavorites => 'Избранное';

  @override
  String get nameEmptyTitle => 'Имена не найдены';

  @override
  String get nameEmptyBody =>
      'Попробуйте изменить фильтры\nили выбрать другие страны';

  @override
  String get nameEmptyAction => 'Настроить фильтры';

  @override
  String get nameFavEmpty => 'Список избранного пуст';

  @override
  String get countryRU => '🇷🇺 Русские';

  @override
  String get countryUS => '🇺🇸 Американские';

  @override
  String get countryTR => '🇹🇷 Турецкие';

  @override
  String get countryKZ => '🇰🇿 Казахские';

  @override
  String get countryUA => '🇺🇦 Украинские';

  @override
  String get countryPL => '🇵🇱 Польские';

  @override
  String get countryDE => '🇩🇪 Немецкие';

  @override
  String get countryFR => '🇫🇷 Французские';

  @override
  String get countryIT => '🇮🇹 Итальянские';

  @override
  String get countryES => '🇪🇸 Испанские';

  @override
  String get countryGB => '🇬🇧 Британские';

  @override
  String get countryCA => '🇨🇦 Канадские';

  @override
  String get countryBR => '🇧🇷 Бразильские';

  @override
  String get countryAE => '🇦🇪 Арабские (ОАЭ)';

  @override
  String get countrySA => '🇸🇦 Арабские (Саудовская Аравия)';

  @override
  String get countryEG => '🇪🇬 Египетские';

  @override
  String get countryMA => '🇲🇦 Марокканские';

  @override
  String get countryNL => '🇳🇱 Нидерландские';

  @override
  String get countryCZ => '🇨🇿 Чешские';

  @override
  String get countryRO => '🇷🇴 Румынские';

  @override
  String get countryAR => '🇦🇷 Аргентинские';

  @override
  String get countryMX => '🇲🇽 Мексиканские';

  @override
  String get countryJP => '🇯🇵 Японские';

  @override
  String get countryCN => '🇨🇳 Китайские';

  @override
  String get countryKR => '🇰🇷 Корейские';

  @override
  String get countryIN => '🇮🇳 Индийские';

  @override
  String get countryIL => '🇮🇱 Еврейские';

  @override
  String get countryGR => '🇬🇷 Греческие';

  @override
  String get countryIE => '🇮🇪 Ирландские';

  @override
  String get countryPT => '🇵🇹 Португальские';

  @override
  String get countryAU => '🇦🇺 Австралийские';

  @override
  String get galleryTitle => 'Галерея живота';

  @override
  String get gallerySubtitle => 'Сохраняйте воспоминания каждую неделю';

  @override
  String galleryWeek(int week) {
    return 'Неделя $week';
  }

  @override
  String get galleryCamera => 'Сделать фото';

  @override
  String get galleryPick => 'Выбрать из галереи';

  @override
  String get galleryDeleteTitle => 'Удалить фото?';

  @override
  String get galleryDeleteBody => 'Это действие нельзя отменить.';

  @override
  String get onboardingModeLmp => 'Рассчитать по месячным';

  @override
  String get onboardingModeEdd => 'Я знаю дату родов';

  @override
  String get onboardingLmpLabel => 'Первый день последней менструации';

  @override
  String get onboardingEddLabel => 'Предполагаемая дата родов';

  @override
  String onboardingCalculatedDate(String date) {
    return 'Расчётная дата родов: $date';
  }

  @override
  String homeReturnToCurrent(int week) {
    return 'Вернуться к неделе $week';
  }

  @override
  String get babyNameLabel => 'Имя малыша';

  @override
  String get currentWeekLabel => 'Текущая неделя';

  @override
  String get languageLabel => 'Язык';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get weightLabel => 'ВЕС';

  @override
  String get lengthLabel => 'ДЛИНА';

  @override
  String get mode => 'Режим визуализации';

  @override
  String get fruit => 'Фрукты';

  @override
  String get realistic => 'Реалистичный';

  @override
  String get labelWeight => 'ВЕС';

  @override
  String get labelLength => 'ДЛИНА';

  @override
  String get errorNoImage => 'Нет изображения';

  @override
  String get valLessThanOneGram => '< 1 г';

  @override
  String get valLessThanOneMm => '< 1 мм';

  @override
  String valGram(Object value) {
    return '$value г';
  }

  @override
  String valKg(Object value) {
    return '$value кг';
  }

  @override
  String valMm(Object value) {
    return '$value мм';
  }

  @override
  String valCm(Object value) {
    return '$value см';
  }

  @override
  String get toolIsItNormal => 'Это нормально?';

  @override
  String get toolIsItNormalSub => 'Проверка симптомов';

  @override
  String get normalDisclaimer =>
      'Этот справочник носит ознакомительный характер. Всегда обращайтесь к врачу за профессиональным советом.';

  @override
  String get normalSearchHint => 'Поиск симптомов (например, Головная боль)';

  @override
  String get statusCommon => 'Часто';

  @override
  String get statusMonitor => 'Наблюдать';

  @override
  String get statusUrgent => 'Звонить врачу';

  @override
  String get actionContactDoctor => 'СВЯЗАТЬСЯ С ВРАЧОМ';

  @override
  String get toolReport => 'Отчёт для врача';

  @override
  String get toolReportSub => 'Экспорт в PDF';

  @override
  String get settingsExportPdf => 'Экспорт отчёта (PDF)';

  @override
  String get exporting => 'Создаём PDF...';

  @override
  String get kickTabTimer => 'Таймер';

  @override
  String get kickTabHistory => 'История';

  @override
  String get kickBtnStart => 'Начать сеанс';

  @override
  String get kickHistoryEmpty => 'Пока нет истории';

  @override
  String get weightChartTitle => 'График прогресса';

  @override
  String get weightHistoryTitle => 'Последние записи';

  @override
  String get weightChartEmpty =>
      'Добавьте минимум 2 записи, чтобы увидеть график';

  @override
  String get settingsThemeTitle => 'ТЕМА';

  @override
  String get settingsThemeSerenity => 'Спокойствие';

  @override
  String get settingsThemeNature => 'Природа';

  @override
  String get settingsThemeWarmth => 'Тепло';

  @override
  String get settingsModeTitle => 'Режим визуализации';

  @override
  String get settingsModeFruit => 'Фрукты';

  @override
  String get settingsModeRealistic => 'Реалистичный';

  @override
  String get contractionBreathIn => 'Вдох...';

  @override
  String get contractionBreathOut => 'Выдох...';

  @override
  String get contractionAlertTitle => 'Пора ехать в роддом?';

  @override
  String get contractionAlertMessage => 'Правило 5-1-1 выполнено!';

  @override
  String get contractionTapToStop => 'Нажмите на круг, чтобы остановить';

  @override
  String get kegelSettingsTitle => 'Настройки тренировки';

  @override
  String get kegelSettingWork => 'Напряжение (сек)';

  @override
  String get kegelSettingRest => 'Расслабление (сек)';

  @override
  String get kegelSettingReps => 'Повторения';

  @override
  String get kegelPaused => 'Пауза';

  @override
  String get pdfReportTitle => 'Отчёт Bloom Mama';

  @override
  String get generatedDate => 'Сформировано';

  @override
  String get dateLabel => 'Дата';

  @override
  String get weightUnitLabel => 'Вес (кг)';

  @override
  String get changeLabel => '+/-';

  @override
  String get durationLabel => 'Длительность';

  @override
  String get kickCountLabel => 'Шевеления';

  @override
  String get symptomsTitle => 'Недавние симптомы';

  @override
  String get pdfDisclaimer =>
      'Отказ от ответственности: этот отчёт предназначен только для отслеживания. Обратитесь к врачу.';

  @override
  String get diaryTitle => 'Дорогой малыш...';

  @override
  String get diarySubtitle => 'Ваши письма и мысли';

  @override
  String get diaryEmpty =>
      'Вы пока не написали ни одной заметки. Нажмите на карточку недели, чтобы написать письмо.';

  @override
  String get settingsLegalTitle => 'ЮРИДИЧЕСКОЕ И ИНФО';

  @override
  String get settingsDisclaimer => 'Медицинский дисклеймер';

  @override
  String get disclaimerTitle => 'Медицинский дисклеймер';

  @override
  String get disclaimerBody =>
      'Это приложение предназначено только для информационных целей и не заменяет профессиональную медицинскую консультацию, диагностику или лечение. \n\nВсегда обращайтесь за советом к врачу или другому квалифицированному специалисту по любым вопросам, связанным со здоровьем. \n\nНикогда не игнорируйте профессиональный медицинский совет и не откладывайте обращение к врачу из-за информации, прочитанной в этом приложении.';

  @override
  String get commonUnderstood => 'Понятно';

  @override
  String get defaultMomName => 'Будущая мама';

  @override
  String get errorGeneric => 'Что-то пошло не так';

  @override
  String get errorPdfGeneration => 'Не удалось создать PDF';

  @override
  String get errorDeleteData => 'Не удалось удалить данные';

  @override
  String get errorOpenBrowser => 'Не удалось открыть браузер';

  @override
  String get themeSerenity => 'Спокойствие';

  @override
  String get themeNature => 'Природа';

  @override
  String get themeWarmth => 'Тепло';

  @override
  String get settingsVisualMode => 'РЕЖИМ ВИЗУАЛИЗАЦИИ';

  @override
  String get visualModeFruit => 'Фрукты';

  @override
  String get visualModeRealistic => 'Реалистичный';

  @override
  String get exportingPdf => 'Экспорт...';

  @override
  String get laborModeTitle => 'РЕЖИМ РОДОВ';

  @override
  String get laborTriggerButton => 'У МЕНЯ СХВАТКИ';

  @override
  String get laborMotivationalQuote => 'Ты справишься, мама! 💪';

  @override
  String get laborConfirmTitle => 'Малыш уже идёт?';

  @override
  String get laborConfirmBody =>
      'Это включит Режим родов. Мы скроем всё, кроме главного: Таймера схваток и Чек-листа в роддом.';

  @override
  String get laborConfirmPartnerPhone => 'Номер партнёра';

  @override
  String get laborConfirmNotifySwitch =>
      'Уведомить партнёра через WhatsApp/SMS';

  @override
  String get laborConfirmStartBtn => 'ДА, ВКЛЮЧИТЬ РЕЖИМ РОДОВ';

  @override
  String get laborConfirmFalseAlarm => 'Ложная тревога';

  @override
  String get laborExitTitle => 'Завершить Режим родов?';

  @override
  String get laborExitBody =>
      'Поздравляем, если малыш уже здесь! Или это была ложная тревога?';

  @override
  String get laborExitEndBtn => 'ЗАВЕРШИТЬ';

  @override
  String get laborEmergencyPrepTitle => 'ЭКСТРЕННЫЕ ДАННЫЕ';

  @override
  String get laborEmergencyPrepSubtitle =>
      'Заполните сейчас, чтобы сэкономить время во время схваток.';

  @override
  String get laborPartnerName => 'Имя партнёра';

  @override
  String get laborPartnerPhone => 'Телефон партнёра';

  @override
  String get laborDoctorPhone => 'Телефон врача';

  @override
  String get laborHospitalAddress => 'Адрес роддома';

  @override
  String get laborHospitalBtn => 'РОДДОМ';

  @override
  String get laborDoctorBtn => 'ВРАЧ';

  @override
  String get laborTimerContraction => 'СХВАТКА';

  @override
  String get laborTimerResting => 'ОТДЫХ';

  @override
  String get laborTimerBreathe => 'ДЫШИТЕ';

  @override
  String get laborTimerStart => 'СТАРТ';

  @override
  String get laborTimerReady => 'Готовы к первой схватке';

  @override
  String get laborTimerMonitoring => 'Отслеживаем...';

  @override
  String get laborTimerLastDuration => 'ПОСЛЕДНЯЯ ДЛИТЕЛЬНОСТЬ';

  @override
  String get laborTimerFrequency => 'ЧАСТОТА';

  @override
  String laborHelpMessage(String name) {
    return '🚨 $name, ПОРА! \n\nСхватки начались. Я включаю Режим родов в приложении. Пожалуйста, приготовься! ❤️';
  }

  @override
  String get errorNoHospitalAddress => 'В настройках не указан адрес роддома';

  @override
  String get errorNoDoctorPhone => 'В настройках не указан телефон врача';

  @override
  String get commonMinutes => 'мин';

  @override
  String get commonSeconds => 'сек';

  @override
  String get commonNext => 'ДАЛЕЕ';

  @override
  String get onboardingNameTitle => 'Как к вам обращаться?';

  @override
  String get jumpToWeek => 'ПЕРЕЙТИ К НЕДЕЛЕ';
}
