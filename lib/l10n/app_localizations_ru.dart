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
    return '$week НЕДЕЛЯ';
  }

  @override
  String get menuHealth => 'Здоровье и Тело';

  @override
  String get menuFamily => 'Семья и Воспоминания';

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
  String get connectionPlaceholder => 'Напишите что-нибудь сокровенное...';

  @override
  String get connectionSaveAction => 'Сохранить мысль';

  @override
  String get connectionOpenDiary => 'Открыть дневник';

  @override
  String get onboardingTitle => 'Когда ждем чудо?';

  @override
  String get onboardingSubtitle => 'Мы персонализируем ваш путь';

  @override
  String get onboardingNameHint => 'Имя малыша (необязательно)';

  @override
  String get onboardingAction => 'Начать';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsNameLabel => 'КАК МЫ НАЗОВЕМ МАЛЫША?';

  @override
  String get settingsNameHint => 'Например, Мия или Лев';

  @override
  String get settingsDateLabel => 'ДАТА РОДОВ';

  @override
  String get settingsSave => 'Сохранить';

  @override
  String get settingsDeleteData => 'Удалить все данные';

  @override
  String get settingsDeleteDataConfirm => 'Вы уверены? Это удалит все ваши фото, имена и историю. Приложение будет перезапущено.';

  @override
  String get settingsPrivacy => 'Политика конфиденциальности';

  @override
  String get loadingTitle => 'Загрузка...';

  @override
  String get loadingBody => 'Получаем данные для этой недели.';

  @override
  String weekDefault(Object week) {
    return 'Неделя $week';
  }

  @override
  String get waterTitle => 'Водный баланс';

  @override
  String get waterFact => 'Вода помогает обновлять околоплодные воды каждые 3 часа.';

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
  String get visitTitleHint => 'Название (напр. УЗИ)';

  @override
  String get visitDoctor => 'Врач / Клиника';

  @override
  String get visitQuestions => 'ВАШИ ВОПРОСЫ';

  @override
  String get visitQuestionsPlaceholder => 'Что спросить у врача?\n- Можно ли мне летать?\n- Какие витамины пить?';

  @override
  String get visitResults => 'РЕЗУЛЬТАТЫ';

  @override
  String get visitWeight => 'Вес (кг)';

  @override
  String get visitBpSys => 'Вверх';

  @override
  String get visitBpDia => 'Вниз';

  @override
  String get visitNotesHint => 'Заметки и рецепты врача...';

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
  String get toolSymptomsSub => 'Дневник симптомов';

  @override
  String get toolKegel => 'Кегель';

  @override
  String get toolKegelSub => 'Мышцы таза';

  @override
  String get toolNames => 'Имена';

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
  String get toolWaterSub => 'Баланс';

  @override
  String get toolKicks => 'Шевеления';

  @override
  String get toolKicksSub => 'Счетчик';

  @override
  String get toolBag => 'Сумка в роддом';

  @override
  String get toolBagSub => 'Список вещей';

  @override
  String get toolVisits => 'Визиты';

  @override
  String get toolVisitsSub => 'План и заметки';

  @override
  String get toolGallery => 'Животик';

  @override
  String get toolGallerySub => 'История роста';

  @override
  String get symptomTitle => 'Как вы себя чувствуете?';

  @override
  String get symptomMoodLabel => 'НАСТРОЕНИЕ';

  @override
  String get symptomLabel => 'СИМПТОМЫ';

  @override
  String get symptomSave => 'Сохранить запись';

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
  String get symBabyActive => 'Малыш активен';

  @override
  String get symAnxiety => 'Тревожность';

  @override
  String get kickTitle => 'СЕАНС СВЯЗИ';

  @override
  String get kickInstruction => 'Нажмите при\nдвижении';

  @override
  String kickCount(int count) {
    return 'Движений: $count';
  }

  @override
  String get kickGoal => 'Цель: 10 шевелений';

  @override
  String get kickSessionDone => 'Сеанс завершен';

  @override
  String get kickDialogTitle => 'Отличная работа!';

  @override
  String kickDialogBody(int count, String time) {
    return 'Вы насчитали $count шевелений за $time.';
  }

  @override
  String get kegelTitle => 'Упражнения Кегеля';

  @override
  String get kegelSubtitle => 'Укрепление мышц тазового дна подготавливает тело к родам.';

  @override
  String get kegelPhaseSqueeze => 'СЖАТИЕ';

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
  String get contractionInstruction => 'Нажмите кнопку, когда начнется схватка';

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
    return 'Собрано на $percent%';
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
  String get checkDocRecords => 'Обменная карта';

  @override
  String get checkDocInsurance => 'Полис ОМС / СНИЛС';

  @override
  String get checkDocContract => 'Контракт на роды (если есть)';

  @override
  String get checkDocTests => 'Свежие анализы';

  @override
  String get checkMomSlippers => 'Моющиеся тапочки';

  @override
  String get checkMomWater => 'Вода без газа (2-3 бутылки)';

  @override
  String get checkMomSocks => 'Теплые носки / Компрессионные';

  @override
  String get checkMomLipBalm => 'Бальзам для губ';

  @override
  String get checkMomCharger => 'Телефон и длинная зарядка';

  @override
  String get checkMomPads => 'Послеродовые прокладки';

  @override
  String get checkMomUnderwear => 'Одноразовые трусики';

  @override
  String get checkMomBra => 'Бюстгальтер для кормления';

  @override
  String get checkMomCream => 'Крем для сосков';

  @override
  String get checkMomHygiene => 'Средства гигиены (зуб. паста, мыло)';

  @override
  String get checkBabyDiapers => 'Подгузники (Newborn)';

  @override
  String get checkBabyWipes => 'Влажные салфетки (0+)';

  @override
  String get checkBabyCream => 'Крем под подгузник';

  @override
  String get checkBabyClothes => 'Слипы / Боди (3-4 шт)';

  @override
  String get checkBabyHat => 'Шапочка и носочки';

  @override
  String get checkBabyOutfit => 'Одежда на выписку';

  @override
  String get weightTitle => 'Контроль веса';

  @override
  String weightWeek(int week) {
    return 'Неделя $week';
  }

  @override
  String get weightInputHint => 'Введите вес для анализа';

  @override
  String get weightNoParams => 'Укажите \'Вес до беременности\' в настройках для умного анализа';

  @override
  String get weightUnit => 'кг';

  @override
  String get weightSave => 'Сохранить вес';

  @override
  String get weightFeedbackLow => 'Набор веса чуть ниже нормы. Не забывайте про сложные углеводы.';

  @override
  String get weightFeedbackHigh => 'Набор веса чуть выше нормы. Постарайтесь пить больше воды.';

  @override
  String get weightFeedbackNormal => 'Идеальный темп! Ваше тело работает как часы.';

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
  String get nameEmptyBody => 'Попробуйте изменить фильтры\nили выбрать другие страны';

  @override
  String get nameEmptyAction => 'Изменить фильтры';

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
  String get countryNL => '🇳🇱 Голландские';

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
  String get galleryTitle => 'Фото животика';

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
  String get onboardingModeLmp => 'По дате последней менструации';

  @override
  String get onboardingModeEdd => 'Я знаю дату родов';

  @override
  String get onboardingLmpLabel => 'Первый день последней менструации';

  @override
  String get onboardingEddLabel => 'Предполагаемая дата родов';

  @override
  String onboardingCalculatedDate(String date) {
    return 'Примерная дата: $date';
  }

  @override
  String homeReturnToCurrent(int week) {
    return 'Вернуться к $week неделе';
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
  String get lengthLabel => 'РОСТ';

  @override
  String get mode => 'Визуальный режим';

  @override
  String get fruit => 'Фрукты';

  @override
  String get realistic => 'Реализм';

  @override
  String get labelWeight => 'ВЕС';

  @override
  String get labelLength => 'РОСТ';

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
  String get normalDisclaimer => 'Это руководство носит исключительно справочный характер. Всегда консультируйтесь с вашим врачом.';

  @override
  String get normalSearchHint => 'Поиск симптомов (напр. Головная боль)';

  @override
  String get statusCommon => 'Норма';

  @override
  String get statusMonitor => 'Наблюдать';

  @override
  String get statusUrgent => 'К врачу';

  @override
  String get actionContactDoctor => 'СВЯЗАТЬСЯ С ВРАЧОМ';

  @override
  String get toolReport => 'Отчет врачу';

  @override
  String get toolReportSub => 'Экспорт в PDF';

  @override
  String get settingsExportPdf => 'Экспорт отчета (PDF)';

  @override
  String get exporting => 'Создание PDF...';

  @override
  String get kickTabTimer => 'Таймер';

  @override
  String get kickTabHistory => 'История';

  @override
  String get kickBtnStart => 'Начать сеанс';

  @override
  String get kickHistoryEmpty => 'История пока пуста';

  @override
  String get weightChartTitle => 'График прогресса';

  @override
  String get weightHistoryTitle => 'Недавняя история';

  @override
  String get weightChartEmpty => 'Добавьте минимум 2 записи, чтобы увидеть график';

  @override
  String get settingsThemeTitle => 'ТЕМА';

  @override
  String get settingsThemeSerenity => 'Спокойствие';

  @override
  String get settingsThemeNature => 'Природа';

  @override
  String get settingsThemeWarmth => 'Тепло';

  @override
  String get settingsModeTitle => 'ВИЗУАЛЬНЫЙ РЕЖИМ';

  @override
  String get settingsModeFruit => 'Фрукты';

  @override
  String get settingsModeRealistic => 'Реализм';

  @override
  String get contractionBreathIn => 'Вдох...';

  @override
  String get contractionBreathOut => 'Выдох...';

  @override
  String get contractionAlertTitle => 'Пора в роддом?';

  @override
  String get contractionAlertMessage => 'Сработало правило (5-1-1)! Время собираться.';

  @override
  String get contractionTapToStop => 'Нажмите на круг, чтобы остановить';

  @override
  String get kegelSettingsTitle => 'Настройки тренировки';

  @override
  String get kegelSettingWork => 'Сжатие (сек)';

  @override
  String get kegelSettingRest => 'Отдых (сек)';

  @override
  String get kegelSettingReps => 'Повторения';

  @override
  String get kegelPaused => 'Пауза';

  @override
  String get pdfReportTitle => 'Отчет Bloom Mama';

  @override
  String get generatedDate => 'Сформирован';

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
  String get pdfDisclaimer => 'Отказ от ответственности: Этот отчет предназначен только для отслеживания. Проконсультируйтесь с врачом.';

  @override
  String get diaryTitle => 'Дорогой малыш...';

  @override
  String get diarySubtitle => 'Ваши мысли и письма';

  @override
  String get diaryEmpty => 'Вы еще ничего не написали. Нажмите на карточку недели, чтобы написать письмо.';

  @override
  String get settingsLegalTitle => 'ИНФОРМАЦИЯ И ПРАВА';

  @override
  String get settingsDisclaimer => 'Медицинский отказ';

  @override
  String get disclaimerTitle => 'Медицинский отказ';

  @override
  String get disclaimerBody => 'Это приложение предназначено исключительно для информационных целей и не заменяет профессиональную медицинскую консультацию, диагностику или лечение. \n\nВсегда обращайтесь за советом к своему врачу по любым вопросам, касающимся вашего здоровья. \n\nНикогда не пренебрегайте медицинскими советами и не откладывайте обращение к врачу из-за информации, прочитанной в этом приложении.';

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
  String get settingsVisualMode => 'ВИЗУАЛЬНЫЙ РЕЖИМ';

  @override
  String get visualModeFruit => 'Фрукты';

  @override
  String get visualModeRealistic => 'Реализм';

  @override
  String get exportingPdf => 'Экспорт...';

  @override
  String get laborModeTitle => 'РЕЖИМ РОДОВ';

  @override
  String get laborTriggerButton => 'РОДЫ НАЧАЛИСЬ';

  @override
  String get laborMotivationalQuote => 'У тебя все получится, Мама! 💪';

  @override
  String get laborConfirmTitle => 'Малыш уже в пути?';

  @override
  String get laborConfirmBody => 'Приложение перейдет в Режим родов. Мы скроем все лишнее и оставим только самое необходимое: Таймер схваток и Список в роддом.';

  @override
  String get laborConfirmPartnerPhone => 'Номер телефона партнера';

  @override
  String get laborConfirmNotifySwitch => 'Сообщить партнеру по WhatsApp/SMS';

  @override
  String get laborConfirmStartBtn => 'ДА, ВКЛЮЧИТЬ РЕЖИМ РОДОВ';

  @override
  String get laborConfirmFalseAlarm => 'Ложная тревога';

  @override
  String get laborExitTitle => 'Завершить Режим родов?';

  @override
  String get laborExitBody => 'Поздравляем, если малыш уже здесь! Или это была ложная тревога?';

  @override
  String get laborExitEndBtn => 'ЗАВЕРШИТЬ РЕЖИМ';

  @override
  String get laborEmergencyPrepTitle => 'ПОДГОТОВКА';

  @override
  String get laborEmergencyPrepSubtitle => 'Заполните это сейчас, чтобы сэкономить время во время схваток.';

  @override
  String get laborPartnerName => 'Имя партнера';

  @override
  String get laborPartnerPhone => 'Телефон партнера';

  @override
  String get laborDoctorPhone => 'Телефон врача';

  @override
  String get laborHospitalAddress => 'Адрес роддома';

  @override
  String get laborHospitalBtn => 'В РОДДОМ';

  @override
  String get laborDoctorBtn => 'ВРАЧУ';

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
  String get laborTimerMonitoring => 'Отслеживание...';

  @override
  String get laborTimerLastDuration => 'ПОСЛЕДНЯЯ ДЛИТЕЛЬНОСТЬ';

  @override
  String get laborTimerFrequency => 'ЧАСТОТА';

  @override
  String laborHelpMessage(String name) {
    return '🚨 $name, ПОРА! \n\nНачались схватки. Я включаю Режим родов в приложении. Пожалуйста, будь готов! ❤️';
  }

  @override
  String get errorNoHospitalAddress => 'Адрес роддома не указан в настройках';

  @override
  String get errorNoDoctorPhone => 'Телефон врача не указан в настройках';

  @override
  String get commonMinutes => 'min';

  @override
  String get commonSeconds => 'sec';

  @override
  String get commonNext => 'ДАЛЕЕ';

  @override
  String get onboardingNameTitle => 'Как к вам обращаться?';

  @override
  String get jumpToWeek => 'ПЕРЕЙТИ К НЕДЕЛЕ';

  @override
  String get growthSectionTitle => 'Как развивается малыш';

  @override
  String get growthSectionSubtitle => 'Плавный рост по неделям беременности';

  @override
  String growthStage(int stage) {
    return 'Этап $stage';
  }
}
