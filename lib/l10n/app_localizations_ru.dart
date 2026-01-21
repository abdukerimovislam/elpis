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
  String get settingsNameHint => 'Например: Оливер или Бусинка';

  @override
  String get settingsDateLabel => 'ПРЕДПОЛАГАЕМАЯ ДАТА РОДОВ';

  @override
  String get settingsSave => 'Сохранить';

  @override
  String get settingsDeleteData => 'Удалить все данные';

  @override
  String get settingsDeleteDataConfirm => 'Вы уверены? Все фото, имена и история будут удалены. Приложение перезапустится.';

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
  String get waterTitle => 'Гидратация';

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
  String get visitTitleHint => 'Название (например: УЗИ)';

  @override
  String get visitDoctor => 'Врач / Клиника';

  @override
  String get visitQuestions => 'ВАШИ ВОПРОСЫ';

  @override
  String get visitQuestionsPlaceholder => 'Что спросить у врача?\n– Можно ли летать?\n– Какие витамины принимать?';

  @override
  String get visitResults => 'РЕЗУЛЬТАТЫ';

  @override
  String get visitWeight => 'Вес (кг)';

  @override
  String get visitBpSys => 'Сист';

  @override
  String get visitBpDia => 'Диаст';

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
  String get toolKegelSub => 'Мышцы таза';

  @override
  String get toolNames => 'Имена';

  @override
  String get toolNamesSub => 'Выбор вместе';

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
  String get toolGallerySub => 'Таймлапс роста';

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
  String get symSwelling => 'Отёки';

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
  String get kickInstruction => 'Нажимайте при\nдвижении';

  @override
  String kickCount(int count) {
    return 'Движений: $count';
  }

  @override
  String get kickGoal => 'Цель: 10 движений';

  @override
  String get kickSessionDone => 'Сеанс завершён';

  @override
  String get kickDialogTitle => 'Отличная работа!';

  @override
  String kickDialogBody(int count, String time) {
    return 'Вы насчитали $count движений за $time.';
  }

  @override
  String get kegelTitle => 'Тренировка Кегеля';

  @override
  String get kegelSubtitle => 'Укрепление мышц таза готовит тело к родам.';

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
  String get kegelStart => 'Начать тренировку';

  @override
  String get kegelFinish => 'Завершить';

  @override
  String get contractionTitle => 'Схватки';

  @override
  String get contractionInstruction => 'Нажмите кнопку при начале схватки';

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
  String get contractionColInterval => 'Интервал';

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
  String get checkDocPassport => 'Паспорт / Удостоверение';

  @override
  String get checkDocRecords => 'Обменная карта';

  @override
  String get checkDocInsurance => 'Страховка';

  @override
  String get checkDocContract => 'Контракт с роддомом';

  @override
  String get checkDocTests => 'Последние анализы';

  @override
  String get checkMomSlippers => 'Моющиеся тапочки';

  @override
  String get checkMomWater => 'Вода (2 бутылки)';

  @override
  String get checkMomSocks => 'Тёплые носки / компрессионные';

  @override
  String get checkMomLipBalm => 'Бальзам для губ';

  @override
  String get checkMomCharger => 'Телефон и длинный кабель';

  @override
  String get checkMomPads => 'Послеродовые прокладки';

  @override
  String get checkMomUnderwear => 'Одноразовое бельё';

  @override
  String get checkMomBra => 'Бюстгальтер для кормления';

  @override
  String get checkMomCream => 'Крем для сосков';

  @override
  String get checkMomHygiene => 'Средства гигиены';

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
  String get weightNoParams => 'Укажите добеременный вес в настройках для умного анализа';

  @override
  String get weightUnit => 'кг';

  @override
  String get weightSave => 'Сохранить вес';

  @override
  String get weightFeedbackLow => 'Набор веса немного ниже нормы. Не забывайте о сбалансированном питании.';

  @override
  String get weightFeedbackHigh => 'Набор веса немного выше нормы. Сосредоточьтесь на полезных продуктах и воде.';

  @override
  String get weightFeedbackNormal => 'Отличная работа! Ваш вес меняется в пределах нормы.';

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
  String get countryIL => '🇮🇱 Иврит';

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
  String get onboardingModeLmp => 'Рассчитать по циклу';

  @override
  String get onboardingModeEdd => 'Я знаю дату родов';

  @override
  String get onboardingLmpLabel => 'Первый день последней менструации';

  @override
  String get onboardingEddLabel => 'Предполагаемая дата родов';

  @override
  String onboardingCalculatedDate(String date) {
    return 'Ожидаемая дата родов: $date';
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
  String get mode => 'Режим отображения';

  @override
  String get fruit => 'Фрукт';

  @override
  String get realistic => 'Реалистичный';

  @override
  String get labelWeight => 'ВЕС';

  @override
  String get labelLength => 'РОСТ';

  @override
  String get errorNoImage => 'Нет фото';

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
  String get normalDisclaimer => 'Справочная информация. Всегда консультируйтесь с врачом для профессионального совета.';

  @override
  String get normalSearchHint => 'Поиск симптомов (например, Головная боль)';

  @override
  String get statusCommon => 'Часто';

  @override
  String get statusMonitor => 'Следить';

  @override
  String get statusUrgent => 'К врачу';

  @override
  String get actionContactDoctor => 'ПОЗВОНИТЬ ВРАЧУ';

  @override
  String get toolReport => 'Отчет для врача';

  @override
  String get toolReportSub => 'PDF Экспорт';

  @override
  String get settingsExportPdf => 'Скачать PDF-отчет';

  @override
  String get exporting => 'Генерация PDF...';

  @override
  String get kickTabTimer => 'Таймер';

  @override
  String get kickTabHistory => 'История';

  @override
  String get kickBtnStart => 'Начать сессию';

  @override
  String get kickHistoryEmpty => 'История пока пуста';

  @override
  String get weightChartTitle => 'График прогресса';

  @override
  String get weightHistoryTitle => 'История записей';

  @override
  String get weightChartEmpty => 'Добавьте 2 записи, чтобы увидеть график';

  @override
  String get settingsThemeTitle => 'ТЕМА ОФОРМЛЕНИЯ';

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
  String get contractionAlertTitle => 'Пора в роддом?';

  @override
  String get contractionAlertMessage => 'Правило 5-1-1 выполнено!';

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
  String get generatedDate => 'Создано';

  @override
  String get dateLabel => 'Дата';

  @override
  String get weightUnitLabel => 'Вес (кг)';

  @override
  String get changeLabel => '+/-';

  @override
  String get durationLabel => 'Длительность';

  @override
  String get kickCountLabel => 'Движения';

  @override
  String get symptomsTitle => 'Недавние симптомы';

  @override
  String get pdfDisclaimer => 'Дисклеймер: Этот отчет только для отслеживания динамики. Проконсультируйтесь с врачом.';

  @override
  String get diaryTitle => 'Дорогой малыш...';

  @override
  String get diarySubtitle => 'Твои письма и мысли';

  @override
  String get diaryEmpty => 'Ты еще не написала ни одной заметки. Нажми на карточку недели, чтобы написать письмо.';

  @override
  String get settingsLegalTitle => 'ЮРИДИЧЕСКАЯ ИНФОРМАЦИЯ';

  @override
  String get settingsDisclaimer => 'Медицинский отказ';

  @override
  String get disclaimerTitle => 'Медицинский отказ от ответственности';

  @override
  String get disclaimerBody => 'Это приложение предназначено только для информационных целей и не является заменой профессиональной медицинской консультации, диагностики или лечения. \n\nВсегда обращайтесь за советом к своему врачу или другому квалифицированному специалисту с любыми вопросами относительно вашего здоровья. \n\nНикогда не пренебрегайте профессиональным медицинским советом и не откладывайте визит к врачу из-за информации, полученной в этом приложении.';

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
  String get laborTriggerButton => 'РОДЫ НАЧАЛИСЬ';

  @override
  String get laborMotivationalQuote => 'Ты справишься, Мама! 💪';

  @override
  String get laborConfirmTitle => 'Уже началось?';

  @override
  String get laborConfirmBody => 'Приложение перейдет в Режим Родов. Мы скроем всё лишнее, оставив только таймер схваток и кнопку связи.';

  @override
  String get laborConfirmPartnerPhone => 'Номер телефона партнера';

  @override
  String get laborConfirmNotifySwitch => 'Уведомить партнера (WhatsApp/SMS)';

  @override
  String get laborConfirmStartBtn => 'ДА, ВКЛЮЧИТЬ РЕЖИМ';

  @override
  String get laborConfirmFalseAlarm => 'Ложная тревога';

  @override
  String get laborExitTitle => 'Выключить режим?';

  @override
  String get laborExitBody => 'Поздравляем, если малыш уже здесь! Или это была ложная тревога?';

  @override
  String get laborExitEndBtn => 'ВЫКЛЮЧИТЬ';

  @override
  String get laborEmergencyPrepTitle => 'ПОДГОТОВКА К РОДАМ';

  @override
  String get laborEmergencyPrepSubtitle => 'Заполни сейчас, чтобы не тратить время на схватках.';

  @override
  String get laborPartnerName => 'Имя партнера';

  @override
  String get laborPartnerPhone => 'Телефон партнера';

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
  String get laborTimerBreathe => 'ДЫШИ';

  @override
  String get laborTimerStart => 'СТАРТ';

  @override
  String get laborTimerReady => 'Готовы к первой схватке';

  @override
  String get laborTimerMonitoring => 'Наблюдаем...';

  @override
  String get laborTimerLastDuration => 'ДЛИТЕЛЬНОСТЬ';

  @override
  String get laborTimerFrequency => 'ЧАСТОТА';

  @override
  String laborHelpMessage(String name) {
    return '🚨 $name, НАЧАЛОСЬ! \n\nПошли схватки. Я включаю трекер. Будь готов! ❤️';
  }

  @override
  String get errorNoHospitalAddress => 'Адрес роддома не указан в настройках';

  @override
  String get errorNoDoctorPhone => 'Телефон врача не указан в настройках';

  @override
  String get commonMinutes => 'мин';

  @override
  String get commonSeconds => 'сек';

  @override
  String get commonNext => 'ДАЛЕЕ';

  @override
  String get onboardingNameTitle => 'Как к тебе обращаться?';
}
