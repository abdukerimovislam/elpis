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
  String get onboardingStep1Title => 'Рады вас видеть!';

  @override
  String get onboardingStep1Sub => 'Elpis — ваш нежный помощник на протяжении всей беременности';

  @override
  String get onboardingMomNameLabel => 'КАК ВАС ЗОВУТ?';

  @override
  String get onboardingMomNameHint => 'Например, Алина или Мария';

  @override
  String get onboardingBabyNameLabel => 'ИМЯ МАЛЫША (НЕОБЯЗАТЕЛЬНО)';

  @override
  String get onboardingBabyNameHint => 'Пуговка, Солнышко...';

  @override
  String get onboardingStep2Title => 'Когда ожидается малыш?';

  @override
  String get onboardingByLmp => 'По ПМ';

  @override
  String get onboardingByEdd => 'Знаю ПДД';

  @override
  String onboardingDueResult(String date) {
    return 'Ожидаемая дата: $date';
  }

  @override
  String get onboardingStep3Title => 'Почти готово!';

  @override
  String get onboardingStep3Sub => 'Elpis — ваш личный дневник беременности. Мы рядом каждую неделю.';

  @override
  String get onboardingDisclaimerTitle => 'Медицинский дисклеймер';

  @override
  String get onboardingDisclaimerBody => 'Приложение предоставляет информацию справочного характера и не заменяет консультацию врача. При любых вопросах обращайтесь к специалисту.';

  @override
  String get onboardingContinue => 'Продолжить';

  @override
  String get onboardingBegin => 'Начать путь 🌸';

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
  String get toolsSectionDaily => 'Ежедневное';

  @override
  String get toolsSectionHealth => 'Здоровье и роды';

  @override
  String get toolsSectionFamily => 'Семья и воспоминания';

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
  String get paywallTitle => 'Bloom Premium';

  @override
  String get paywallSubtitleAndroid => 'Премиум-функции для Android пока готовятся.';

  @override
  String get paywallSubtitleDefault => 'Поддержите разработку и откройте все возможности.';

  @override
  String get paywallFeatureBackup => 'Полный облачный бэкап скоро появится';

  @override
  String get paywallFeatureInsights => 'Расширенные health insights';

  @override
  String get paywallFeatureNoAds => 'Без рекламы';

  @override
  String get paywallStatusTitleAndroid => 'Покупки для Android скоро появятся';

  @override
  String get paywallStatusTitleDefault => 'Скоро появится';

  @override
  String get paywallStatusBody => 'Мы работаем над запуском Premium для всех пользователей.';

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
  String get todayForYouTitle => 'Сегодня для вас';

  @override
  String get todayForYouWeeklyNote => 'Подсказка недели';

  @override
  String get diaryLoadError => 'Не удалось загрузить дневник';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get startupErrorTitle => 'Bloom Mama не смогло корректно запуститься.';

  @override
  String get todayFocusMorningEarlyTitle => 'Нежное начало дня';

  @override
  String get todayFocusMorningEarlyBody => 'Начните утро спокойно: вода, медленный завтрак и немного мягкого внимания к себе.';

  @override
  String get todayFocusMorningMidTitle => 'Ритм и опора';

  @override
  String get todayFocusMorningMidBody => 'Сегодня особенно полезно держать ровный ритм: небольшие паузы, движение и спокойное дыхание.';

  @override
  String get todayFocusMorningLateTitle => 'Спокойное утро перед встречей';

  @override
  String get todayFocusMorningLateBody => 'Чем ближе встреча, тем важнее мягкий темп. Делайте меньше рывков и больше коротких пауз.';

  @override
  String get todayFocusDayEarlyTitle => 'Поддержите тело днём';

  @override
  String get todayFocusDayEarlyBody => 'Выберите одну маленькую заботу для себя: перекус, стакан воды или пять минут без спешки.';

  @override
  String get todayFocusDayMidTitle => 'Мягкая пауза посреди дня';

  @override
  String get todayFocusDayMidBody => 'Сделайте короткую передышку и проверьте, как вы себя чувствуете. Даже одна пауза меняет тон всего дня.';

  @override
  String get todayFocusDayLateTitle => 'Берегите энергию';

  @override
  String get todayFocusDayLateBody => 'Сейчас лучше распределять силы аккуратно: меньше перегруза, больше опоры и предсказуемого ритма.';

  @override
  String get todayFocusEveningEarlyTitle => 'Тихий вечер';

  @override
  String get todayFocusEveningEarlyBody => 'Завершите день мягко: убавьте шум, выдохните и побудьте немного в спокойствии.';

  @override
  String get todayFocusEveningMidTitle => 'Вечер для восстановления';

  @override
  String get todayFocusEveningMidBody => 'Тёплый душ, удобная поза и спокойный ритуал перед сном помогут телу отпустить накопленное напряжение.';

  @override
  String get todayFocusEveningLateTitle => 'Сбавить темп к ночи';

  @override
  String get todayFocusEveningLateBody => 'Вечером сейчас особенно важно замедляться. Пусть всё вокруг подсказывает телу: можно расслабиться.';

  @override
  String get habitTrackerTitle => 'Ежедневный компаньон';

  @override
  String get habitTrackerQuestion => 'Как вы себя чувствуете?';

  @override
  String get habitMoodTired => 'Устала';

  @override
  String get habitMoodGood => 'Хорошо';

  @override
  String get habitMoodGreat => 'Супер';

  @override
  String get habitWater => 'Вода';

  @override
  String get habitWalk => 'Ходьба';

  @override
  String get habitVitamins => 'Витамины';

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
  String get pdfReportTitle => 'Общая медицинская сводка';

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
  String get commonMinutes => 'мин';

  @override
  String get commonSeconds => 'сек';

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

  @override
  String get weightPersonalizeTitle => 'Персонализация';

  @override
  String get weightPersonalizeDesc => 'Нажмите, чтобы указать свой рост и вес до беременности для точных расчетов.';

  @override
  String get weightHeightLabel => 'Рост (см)';

  @override
  String get weightPrePregnancyLabel => 'Вес до беременности (кг)';

  @override
  String get weightTotalGain => 'Общий набор';

  @override
  String get weightRecommended => 'Рекомендовано';

  @override
  String get pdfPatient => 'Пациент: ';

  @override
  String get pdfDueDate => 'ПДР: ';

  @override
  String get pdfDueDateNotSet => 'ПДР: Не указана';

  @override
  String get pdfReportDate => 'Дата отчета:';

  @override
  String get pdfHealthSummaryTitle => 'Сводка здоровья за 30 дней';

  @override
  String get pdfNoHealthData => 'За последние 30 дней нет данных.';

  @override
  String get pdfColDate => 'Дата';

  @override
  String get pdfColWeight => 'Вес';

  @override
  String get pdfColSymptoms => 'Симптомы';

  @override
  String get pdfColKicks => 'Толчки';

  @override
  String get pdfColWater => 'Вода';

  @override
  String get pdfNone => 'Нет';

  @override
  String get pdfContractionsHistory => 'История схваток';

  @override
  String get pdfNoContractions => 'Нет записей о схватках.';

  @override
  String get pdfFooter => 'Медицинский отчет - Создан Elpis Premium';

  @override
  String get paywallProTitle => 'Открой Elpis PRO';

  @override
  String get paywallProSubtitle => 'Подари себе уверенность. Раскрой все возможности приложения для здоровой и спокойной беременности.';

  @override
  String get paywallFeatBabyTitle => '3D Реалистичный Малыш';

  @override
  String get paywallFeatBabyDesc => 'Наблюдай за развитием в реальном времени';

  @override
  String get paywallFeatReportTitle => 'Отчеты для врача';

  @override
  String get paywallFeatReportDesc => 'Экспорт схваток и шевелений в PDF';

  @override
  String get paywallFeatAnalyticsTitle => 'Глубокая аналитика';

  @override
  String get paywallFeatAnalyticsDesc => 'Умный анализ веса и симптомов';

  @override
  String get paywallFeatGalleryTitle => 'Галерея животика';

  @override
  String get paywallFeatGalleryDesc => 'Сохрани каждую неделю на память';

  @override
  String get paywallMonth => '1 МЕСЯЦ';

  @override
  String get paywallYear => '1 ГОД';

  @override
  String get paywallSaveBadge => 'ВЫГОДНО';

  @override
  String get paywallContinue => 'ПРОДОЛЖИТЬ';

  @override
  String get paywallTerms => 'Условия';

  @override
  String get paywallRestore => 'Восстановить';

  @override
  String get paywallError => 'Не удалось разблокировать. Попробуйте еще раз.';

  @override
  String get paywallTrialBadge => '3 ДНЯ БЕСПЛАТНО';

  @override
  String get paywallStartTrial => 'НАЧАТЬ 3 ДНЯ БЕСПЛАТНО';

  @override
  String get paywallCancelAnytime => 'Отмените в любой момент. Без обязательств.';

  @override
  String get greetingNight => 'Доброй ночи 🌙';

  @override
  String get greetingMorning => 'Доброе утро ☀️';

  @override
  String get greetingAfternoon => 'Добрый день 🌸';

  @override
  String get greetingEvening => 'Добрый вечер 🌷';

  @override
  String get trimesterFirst => 'I триместр';

  @override
  String get trimesterSecond => 'II триместр';

  @override
  String get trimesterThird => 'III триместр';

  @override
  String get letterStateDraft => 'Черновик';

  @override
  String get letterStateSaving => 'Сохраняем...';

  @override
  String get letterStateSaved => 'Сохранено';

  @override
  String get letterStateError => 'Не сохранено';

  @override
  String get insightBabyDevTitle => 'Развитие малыша';

  @override
  String get insightYourBodyTitle => 'Ваше тело';

  @override
  String get navHome => 'Главная';

  @override
  String get navCare => 'Забота';

  @override
  String get navDiary => 'Дневник';

  @override
  String get phaseBeginning => 'Нежное начало';

  @override
  String get phaseGrowing => 'Время роста';

  @override
  String get phaseAlmostTime => 'Скоро встреча';

  @override
  String get insightTagForYou => 'О вас';

  @override
  String get insightTagFeelings => 'Настроение';

  @override
  String get insightTagTip => 'Подсказка';

  @override
  String get insightTagBaby => 'О малыше';

  @override
  String get weekNavLabel => 'Недели беременности';

  @override
  String get weekNavLaborMode => 'Режим родов';

  @override
  String get weekNavGrowth => 'Развитие';

  @override
  String get weekNavNow => 'сейчас';

  @override
  String get snapshotStage => 'Этап';

  @override
  String get snapshotNow => 'Сейчас';

  @override
  String get quickDiary => 'Дневник';

  @override
  String get quickCare => 'Забота';

  @override
  String get settingsNotificationsTitle => 'УВЕДОМЛЕНИЯ';

  @override
  String get settingsNotifyWeekly => 'Еженедельное развитие';

  @override
  String get settingsNotifyVitamins => 'Привычка: Витамины (09:00)';

  @override
  String get settingsNotifyWater => 'Привычка: Вода (18:00)';

  @override
  String get onboardingStep1Title2 => 'Рады вас видеть!';

  @override
  String get onboardingEddTitle => 'Предполагаемая дата родов';

  @override
  String get onboardingLmpTitle => 'Первый день\nпоследней менструации';

  @override
  String get onboardingEddSubtitle => 'Врач уже сказал вам ПДР?';

  @override
  String get onboardingLmpSubtitle => 'Мы рассчитаем срок автоматически';

  @override
  String get onboardingLanguagePrompt => 'Выберите язык';

  @override
  String get privacyUnavailable => 'Политика конфиденциальности пока не добавлена в приложение.';

  @override
  String get paywallOffersLoadError => 'Сейчас не удалось загрузить предложения.';

  @override
  String get paywallProBadge => 'PRO';

  @override
  String reportGenerationError(Object error) {
    return 'Ошибка при создании отчета:\n$error';
  }

  @override
  String get pdfFilePrefix => 'Bloom_Report';

  @override
  String get pdfHealthFilePrefix => 'elpis_health_report';

  @override
  String get pdfFallbackPatientName => 'Пациент';

  @override
  String pdfBmiValue(Object value) {
    return ' | ИМТ: $value';
  }

  @override
  String get laborHelpFallbackName => 'Любимый';

  @override
  String get laborPartnerNameHint => 'например, Алекс';

  @override
  String get laborPartnerPhoneHint => '+996 555 ...';

  @override
  String get laborDoctorPhoneHint => 'Экстренный контакт';

  @override
  String get laborHospitalAddressHint => 'Улица, дом...';

  @override
  String get todayForYouFootnote => 'Вы можете спокойно возвращаться к этому блоку в течение дня.';

  @override
  String get earlyWeek1Title => 'Начало цикла';

  @override
  String get earlyWeek1Description => 'Ваш организм готовится к возможному чуду.';

  @override
  String get earlyWeek2Title => 'Овуляция';

  @override
  String get earlyWeek2Description => 'Самый важный момент для зарождения новой жизни.';

  @override
  String get earlyWeek3Title => 'Зачатие';

  @override
  String get earlyWeek3Description => 'Маленькая клетка начинает свое большое путешествие.';

  @override
  String get updatingData => 'Данные обновляются';

  @override
  String get updatingDataSentence => 'Данные обновляются.';

  @override
  String get weekDetailTakeCare => 'Заботьтесь о себе.';

  @override
  String get weekDetailBabyActive => 'Малыш активно развивается.';

  @override
  String get weekDetailBodyChanging => 'Тело продолжает меняться.';

  @override
  String get weekDetailRest => 'Отдыхайте и слушайте себя.';

  @override
  String get notificationBabyFallback => 'малыш';

  @override
  String notificationWeeklyTitleNamed(Object name) {
    return '$name, с новой неделей! 🎉';
  }

  @override
  String get notificationWeeklyTitle => 'С новой неделей! 🎉';

  @override
  String notificationWeeklyBody(Object week, Object baby) {
    return 'У вас $week неделя. Загляните посмотреть, как растет $baby.';
  }

  @override
  String notificationVitaminsTitleNamed(Object name) {
    return 'Доброе утро, $name! 💊';
  }

  @override
  String get notificationVitaminsTitle => 'Время витаминов ☀️';

  @override
  String get notificationVitaminsBody => 'Не забудьте принять витамины.';

  @override
  String notificationWaterTitleNamed(Object name) {
    return '$name, водный баланс! 💧';
  }

  @override
  String get notificationWaterTitle => 'Водный баланс 💧';

  @override
  String get notificationWaterBody => 'Время выпить стакан воды!';

  @override
  String get insightWeek1FruitTitle => 'Невидимая пыльца';

  @override
  String get insightWeek1FruitDescription => 'Организм только готовится к созданию чуда.';

  @override
  String get insightWeek1RealisticTitle => 'Чистый лист';

  @override
  String get insightWeek1RealisticDescription => 'Начало новой удивительной истории.';

  @override
  String get insightWeek1BabyDev => 'На этом этапе физически малыша еще нет. Это начало вашего менструального цикла, во время которого созревает яйцеклетка.';

  @override
  String get insightWeek1MomBody => 'Организм обновляет слизистую матки, создавая идеальную «почву» для будущего прикрепления эмбриона.';

  @override
  String get insightWeek1Tip => 'Начните принимать фолиевую кислоту (400 мкг в день) и откажитесь от вредных привычек.';

  @override
  String get insightWeek1Milestone => 'Начало акушерского отсчета';

  @override
  String get insightWeek1Insight1Title => 'Подготовка';

  @override
  String get insightWeek1Insight1Content => 'Ваше тело начинает новый цикл. Гормоны работают над созреванием идеальной яйцеклетки.';

  @override
  String get insightWeek1Insight2Title => 'Витамины';

  @override
  String get insightWeek1Insight2Content => 'Витамин B9 (фолиевая кислота) критически важен сейчас для предотвращения дефектов нервной трубки.';

  @override
  String get insightWeek1Insight3Title => 'Настрой';

  @override
  String get insightWeek1Insight3Content => 'Меньше стресса. Самое время для позитивных мыслей и планирования.';

  @override
  String get insightWeek2FruitTitle => 'Крошечная спора';

  @override
  String get insightWeek2FruitDescription => 'Скрытый потенциал для зарождения новой жизни.';

  @override
  String get insightWeek2RealisticTitle => 'Искра';

  @override
  String get insightWeek2RealisticDescription => 'Момент, когда все звезды сходятся воедино.';

  @override
  String get insightWeek2BabyDev => 'В конце этой недели произойдет овуляция. Самая сильная яйцеклетка встретится со сперматозоидом.';

  @override
  String get insightWeek2MomBody => 'Уровень эстрогена растет. Вы можете почувствовать легкое покалывание внизу живота — это признак овуляции.';

  @override
  String get insightWeek2Tip => 'Идеальное время для романтики и зачатия. Наслаждайтесь процессом!';

  @override
  String get insightWeek2Milestone => 'Овуляция и оплодотворение';

  @override
  String get insightWeek2Insight1Title => 'Овуляция';

  @override
  String get insightWeek2Insight1Content => 'Яйцеклетка покидает яичник и отправляется в маточную трубу навстречу судьбе.';

  @override
  String get insightWeek2Insight2Title => 'Любовь';

  @override
  String get insightWeek2Insight2Content => 'Сперматозоиды могут жить в организме женщины до 5 дней. Время действовать!';

  @override
  String get insightWeek2Insight3Title => 'Интуиция';

  @override
  String get insightWeek2Insight3Content => 'Многие женщины утверждают, что интуитивно чувствуют момент зачатия.';

  @override
  String get insightWeek3FruitTitle => 'Ванильное семечко';

  @override
  String get insightWeek3FruitDescription => 'Меньше миллиметра, но уже невероятно сложное создание.';

  @override
  String get insightWeek3RealisticTitle => 'Песчинка';

  @override
  String get insightWeek3RealisticDescription => 'Золотая крупица, которая нашла свое идеальное место.';

  @override
  String get insightWeek3BabyDev => 'Оплодотворенная клетка (зигота) активно делится и превращается в бластоцисту, путешествуя к матке.';

  @override
  String get insightWeek3MomBody => 'Бластоциста внедряется в стенку матки (имплантация). Может появиться легкое мажущее кровотечение.';

  @override
  String get insightWeek3Tip => 'Избегайте тяжелых физических нагрузок, горячих ванн и рентгеновского излучения.';

  @override
  String get insightWeek3Milestone => 'Имплантация эмбриона';

  @override
  String get insightWeek3Insight1Title => 'Путешествие';

  @override
  String get insightWeek3Insight1Content => 'Малыш совершает 7-дневное путешествие по маточной трубе в матку.';

  @override
  String get insightWeek3Insight2Title => 'Имплантация';

  @override
  String get insightWeek3Insight2Content => 'Легкие спазмы и пара капель крови — частый признак успешного прикрепления.';

  @override
  String get insightWeek3Insight3Title => 'Берегите себя';

  @override
  String get insightWeek3Insight3Content => 'Организм бросает все силы на поддержку новой жизни. Отдыхайте.';

  @override
  String get insightWeek4FruitTitle => 'Маковое зернышко';

  @override
  String get insightWeek4FruitDescription => 'Крошечная точка, в которой уже заложена вся вселенная вашего будущего ребенка.';

  @override
  String get insightWeek4RealisticTitle => 'Бисеринка';

  @override
  String get insightWeek4RealisticDescription => 'Маленькая, но драгоценная деталь огромной картины, которую вы начинаете рисовать.';

  @override
  String get insightWeek4GrowthTitle => 'Рост 1–2 мм, Вес <1 г';

  @override
  String get insightWeek4GrowthDescription => 'Размером с маковое зернышко. Эмбрион только формируется.';

  @override
  String get insightWeek4BabyDev => 'Эмбрион состоит из двух слоев (эпибласт и гипобласт), из которых разовьются все его органы и ткани.';

  @override
  String get insightWeek4MomBody => 'Уровень гормона ХГЧ достаточно высок, чтобы тест на беременность показал заветные две полоски.';

  @override
  String get insightWeek4Tip => 'Запишитесь на первый прием к гинекологу на 7-8 неделю.';

  @override
  String get insightWeek4Milestone => 'Положительный тест на беременность!';

  @override
  String get insightWeek4Insight1Title => 'Тихое чудо';

  @override
  String get insightWeek4Insight1Content => 'Внутри происходит революция деления клеток, хотя внешне все спокойно.';

  @override
  String get insightWeek4Insight2Title => 'Витамины';

  @override
  String get insightWeek4Insight2Content => 'Фолиевая кислота — главный строительный материал прямо сейчас.';

  @override
  String get insightWeek4Insight3Title => 'Осторожность';

  @override
  String get insightWeek4Insight3Content => 'Избегайте перегрева. Сауны и горячие ванны лучше отложить.';

  @override
  String get insightWeek5FruitTitle => 'Кунжутное семечко';

  @override
  String get insightWeek5FruitDescription => 'Маленькое чудо, открывающее двери в огромный мир.';

  @override
  String get insightWeek5RealisticTitle => 'Булавочная головка';

  @override
  String get insightWeek5RealisticDescription => 'В этой косточке скрыта сила целого сада, который обязательно расцветет.';

  @override
  String get insightWeek5GrowthTitle => 'Рост 2–3 мм, Вес <1 г';

  @override
  String get insightWeek5GrowthDescription => 'Размером с кунжутное семя. Крошечная жизнь внутри вас.';

  @override
  String get insightWeek5BabyDev => 'Начинает формироваться нервная трубка (будущий мозг и спинной мозг) и крошечное сердце.';

  @override
  String get insightWeek5MomBody => 'Грудь может стать чувствительной. Появляется ранняя утомляемость и учащенное мочеиспускание.';

  @override
  String get insightWeek5Tip => 'Исключите из рациону сырую рыбу (суши), мясо с кровью и непастеризованные сыры.';

  @override
  String get insightWeek5Milestone => 'Начинает биться сердце';

  @override
  String get insightWeek5Insight1Title => 'Сердцебиение';

  @override
  String get insightWeek5Insight1Content => 'Маленький моторчик начинает работу. Он бьется в два раза быстрее вашего.';

  @override
  String get insightWeek5Insight2Title => 'Эмоции';

  @override
  String get insightWeek5Insight2Content => 'Слезы без причины? Гормоны перестраивают ваш мир. Плачьте, если нужно.';

  @override
  String get insightWeek5Insight3Title => 'Диета';

  @override
  String get insightWeek5Insight3Content => 'Исключите сырую рыбу, мягкие сыры и алкоголь.';

  @override
  String get insightWeek6FruitTitle => 'Душистый горошек';

  @override
  String get insightWeek6FruitDescription => 'Нежный и сладкий. Малыш свернулся калачиком.';

  @override
  String get insightWeek6RealisticTitle => 'Яркая бусина';

  @override
  String get insightWeek6RealisticDescription => 'Однажды вы нанижете такие бусины на нитку, делая с малышом первые поделки.';

  @override
  String get insightWeek6GrowthTitle => 'Рост 4–6 мм, Вес <1 г';

  @override
  String get insightWeek6GrowthDescription => 'Размером с чечевицу. Малыш стремительно растет.';

  @override
  String get insightWeek6BabyDev => 'Формируются челюсти, щеки, подбородок, а также зачатки глаз и ушей.';

  @override
  String get insightWeek6MomBody => 'Возможно начало токсикоза. Утренняя тошнота — верный спутник многих мам на этом сроке.';

  @override
  String get insightWeek6Tip => 'Держите крекеры или сухарики у кровати. Съешьте пару штук перед тем, как встать утром.';

  @override
  String get insightWeek6Milestone => 'Появляются зачатки лица';

  @override
  String get insightWeek6Insight1Title => 'Супер-нюх';

  @override
  String get insightWeek6Insight1Content => 'Обоняние обостряется, работая как детектор вредных веществ.';

  @override
  String get insightWeek6Insight2Title => 'Усталость';

  @override
  String get insightWeek6Insight2Content => 'Тело тратит колоссальную энергию на плаценту. Дневной сон — это нормально.';

  @override
  String get insightWeek6Insight3Title => 'Вода';

  @override
  String get insightWeek6Insight3Content => 'Пейте воду маленькими глотками, это помогает от тошноты.';

  @override
  String get insightWeek7FruitTitle => 'Черника';

  @override
  String get insightWeek7FruitDescription => 'Темная лесная ягода. Активно формируется мозг.';

  @override
  String get insightWeek7RealisticTitle => 'Стеклянный шарик';

  @override
  String get insightWeek7RealisticDescription => 'Маленький и прозрачный. То, что позволит ему чувствовать этот мир, уже формируется.';

  @override
  String get insightWeek7GrowthTitle => 'Рост 10–13 мм, Вес <1 г';

  @override
  String get insightWeek7GrowthDescription => 'Размером с чернику. Почти сантиметр!';

  @override
  String get insightWeek7BabyDev => 'Каждую минуту в мозге генерируется около 100 новых нервных клеток! Появляются почки ручек и ножек.';

  @override
  String get insightWeek7MomBody => 'Матка увеличилась до размеров лимона. Вы можете чаще бегать в туалет.';

  @override
  String get insightWeek7Tip => 'Сделайте первое УЗИ для подтверждения сердцебиения и исключения внематочной беременности.';

  @override
  String get insightWeek7Milestone => 'Формирование пуповины';

  @override
  String get insightWeek7Insight1Title => 'Токсикоз';

  @override
  String get insightWeek7Insight1Content => 'Тошнота бывает и вечером. Съешьте крекер, не вставая с постели.';

  @override
  String get insightWeek7Insight2Title => 'Секрет';

  @override
  String get insightWeek7Insight2Content => 'Вы носите тайну, о которой знаете только вы. Наслаждайтесь этим.';

  @override
  String get insightWeek7Insight3Title => 'Туалет';

  @override
  String get insightWeek7Insight3Content => 'Матка растет и давит на мочевой пузырь. Это временно.';

  @override
  String get insightWeek8FruitTitle => 'Малина';

  @override
  String get insightWeek8FruitDescription => 'Сложная ягодка. Начинаются первые микро-движения.';

  @override
  String get insightWeek8RealisticTitle => 'Кубик LEGO';

  @override
  String get insightWeek8RealisticDescription => 'Первый кирпичик, с которого начнется строительство замков и целых миров.';

  @override
  String get insightWeek8GrowthTitle => 'Рост 14–20 мм, Вес ~1 г';

  @override
  String get insightWeek8GrowthDescription => 'Размером с малину. Вес перешел за 1 грамм.';

  @override
  String get insightWeek8BabyDev => 'У эмбриона исчезает «хвостик». Начинают вырисовываться пальчики на руках и ногах.';

  @override
  String get insightWeek8MomBody => 'Объем крови увеличивается на 40-50%. Ваше сердце работает за двоих.';

  @override
  String get insightWeek8Tip => 'Купите удобный бюстгальтер без косточек — грудь продолжит расти.';

  @override
  String get insightWeek8Milestone => 'Первые спонтанные движения';

  @override
  String get insightWeek8Insight1Title => 'Движение';

  @override
  String get insightWeek8Insight1Content => 'Он уже кувыркается и плавает, хотя вы этого пока не чувствуете.';

  @override
  String get insightWeek8Insight2Title => 'Спазмы';

  @override
  String get insightWeek8Insight2Content => 'Матка размером с грейпфрут. Возможны легкие потягивания.';

  @override
  String get insightWeek8Insight3Title => 'Прогулки';

  @override
  String get insightWeek8Insight3Content => 'Свежий воздух — лучшее лекарство от усталости. Гуляйте 20 минут.';

  @override
  String get insightWeek9FruitTitle => 'Зеленая оливка';

  @override
  String get insightWeek9FruitDescription => 'Плотная и крепкая. Мышцы становятся сильнее.';

  @override
  String get insightWeek9RealisticTitle => 'Батарейка AAA';

  @override
  String get insightWeek9RealisticDescription => 'Сочная и полная жизни. Хвостик исчез, теперь это маленький человечек.';

  @override
  String get insightWeek9GrowthTitle => 'Рост 2–3 см, Вес ~2 г';

  @override
  String get insightWeek9GrowthDescription => 'Размером с оливку. Пропорции быстро меняются.';

  @override
  String get insightWeek9BabyDev => 'Формируются крошечные мышцы. Малыш начинает сгибать ручки в локтях и запястьях.';

  @override
  String get insightWeek9MomBody => 'Внешне живот еще не виден, но талия может слегка раздаться. Возможны перепады настроения.';

  @override
  String get insightWeek9Tip => 'Не забывайте про кальций (молочные продукты, шпинат) — он нужен для костей малыша.';

  @override
  String get insightWeek9Milestone => 'Смена статуса: теперь это плод!';

  @override
  String get insightWeek9Insight1Title => 'Мышцы';

  @override
  String get insightWeek9Insight1Content => 'Развиваются крошечные мышцы, он учится сгибать ручки в локтях.';

  @override
  String get insightWeek9Insight2Title => 'Сны';

  @override
  String get insightWeek9Insight2Content => 'Сны могут стать яркими и странными. Подсознание прорабатывает страхи.';

  @override
  String get insightWeek9Insight3Title => 'Белье';

  @override
  String get insightWeek9Insight3Content => 'Грудь растет и становится чувствительной. Время подобрать удобный топ.';

  @override
  String get insightWeek10FruitTitle => 'Кумкват';

  @override
  String get insightWeek10FruitDescription => 'Золотой цитрус. Жизненно важные органы работают.';

  @override
  String get insightWeek10RealisticTitle => 'Крышечка от бутылки';

  @override
  String get insightWeek10RealisticDescription => 'Крепкий орешек. Его мозг развивается с невероятной скоростью.';

  @override
  String get insightWeek10GrowthTitle => 'Рост 3–4 см, Вес ~4 г';

  @override
  String get insightWeek10GrowthDescription => 'Размером со сливу. Плод активно набирает массу.';

  @override
  String get insightWeek10BabyDev => 'Почки начинают вырабатывать мочу. Печень производит желчь. Органы начинают функционировать.';

  @override
  String get insightWeek10MomBody => 'Вены на груди и животе могут стать более заметными из-за усиленного кровотока.';

  @override
  String get insightWeek10Tip => 'Запланируйте первый генетический скрининг (11-13 недель).';

  @override
  String get insightWeek10Milestone => 'Органы начинают работать';

  @override
  String get insightWeek10Insight1Title => 'Автономия';

  @override
  String get insightWeek10Insight1Content => 'Почки, печень и мозг уже функционируют самостоятельно.';

  @override
  String get insightWeek10Insight2Title => 'Одежда';

  @override
  String get insightWeek10Insight2Content => 'Любимые джинсы могут давить. Комфорт сейчас важнее моды.';

  @override
  String get insightWeek10Insight3Title => 'Настроение';

  @override
  String get insightWeek10Insight3Content => 'От эйфории до тревоги за минуту. Дышите глубже, это гормоны.';

  @override
  String get insightWeek11FruitTitle => 'Инжир';

  @override
  String get insightWeek11FruitDescription => 'Сладкий плод. Малыш учится открывать ротик.';

  @override
  String get insightWeek11RealisticTitle => 'Мяч для гольфа';

  @override
  String get insightWeek11RealisticDescription => 'Плотный и упругий. Скоро он начнет отталкиваться от стенок матки.';

  @override
  String get insightWeek11GrowthTitle => 'Рост 4–5 см, Вес ~7 г';

  @override
  String get insightWeek11GrowthDescription => 'Малыш достигает 5 сантиметров от темени до копчика.';

  @override
  String get insightWeek11BabyDev => 'Пальчики на руках и ногах полностью разделились. Появляются зачатки ногтей и зубов.';

  @override
  String get insightWeek11MomBody => 'Ногти и волосы могут начать расти быстрее и стать крепче (бонус беременности!).';

  @override
  String get insightWeek11Tip => 'Избегайте инфекций. Мойте руки чаще и старайтесь не посещать места скопления людей.';

  @override
  String get insightWeek11Milestone => 'Формирование зачатков зубов';

  @override
  String get insightWeek11Insight1Title => 'Первое УЗИ';

  @override
  String get insightWeek11Insight1Content => 'Волнительный момент. Вы услышите самый важный ритм — сердцебиение.';

  @override
  String get insightWeek11Insight2Title => 'Волосы и ногти';

  @override
  String get insightWeek11Insight2Content => 'Вы можете заметить, что они растут быстрее. Спасибо эстрогену.';

  @override
  String get insightWeek11Insight3Title => 'Перекус';

  @override
  String get insightWeek11Insight3Content => 'Носите с собой орехи или яблоко, чтобы голод не застал врасплох.';

  @override
  String get insightWeek12FruitTitle => 'Слива';

  @override
  String get insightWeek12FruitDescription => 'Гладкая и сочная. Скелет начинает твердеть.';

  @override
  String get insightWeek12RealisticTitle => 'Пустышка';

  @override
  String get insightWeek12RealisticDescription => 'Символ спокойствия. Однажды она поможет ему уснуть у вас на руках.';

  @override
  String get insightWeek12GrowthTitle => 'Рост 5–6 см, Вес ~14 г';

  @override
  String get insightWeek12GrowthDescription => 'Размером со средний абрикос. Первый триместр почти завершен!';

  @override
  String get insightWeek12BabyDev => 'Рефлексы совершенствуются: малыш может сжимать кулачки, морщиться и сосать палец.';

  @override
  String get insightWeek12MomBody => 'Дно матки поднимается над лобковой костью. Токсикоз у многих начинает отступать.';

  @override
  String get insightWeek12Tip => 'Самое время официально объявить о беременности семье и друзьям!';

  @override
  String get insightWeek12Milestone => 'Конец первого триместра';

  @override
  String get insightWeek12Insight1Title => 'Второе дыхание';

  @override
  String get insightWeek12Insight1Content => 'Плацента берет работу на себя. Токсикоз отступает, энергия возвращается.';

  @override
  String get insightWeek12Insight2Title => 'Осознание';

  @override
  String get insightWeek12Insight2Content => 'Риски резко снижаются. Можно выдохнуть и начать мечтать.';

  @override
  String get insightWeek12Insight3Title => 'Крем';

  @override
  String get insightWeek12Insight3Content => 'Начните увлажнять живот и бедра для профилактики растяжек.';

  @override
  String get insightWeek13FruitTitle => 'Лимон';

  @override
  String get insightWeek13FruitDescription => 'Яркий и солнечный. Появляются уникальные отпечатки пальцев.';

  @override
  String get insightWeek13RealisticTitle => 'Детское мыло';

  @override
  String get insightWeek13RealisticDescription => 'Запах чистоты и мягкое полотенце, в которое вы завернете его после ванны.';

  @override
  String get insightWeek13GrowthTitle => 'Рост 7–8 см, Вес ~23 г';

  @override
  String get insightWeek13GrowthDescription => 'Размером с персик. Малыш весит больше 20 граммов.';

  @override
  String get insightWeek13BabyDev => 'Голосовые связки формируются. Кишечник перемещается из пуповины в брюшную полость малыша.';

  @override
  String get insightWeek13MomBody => 'Вы вступаете в «золотой период» беременности. Самочувствие заметно улучшается.';

  @override
  String get insightWeek13Tip => 'Если вы занимались спортом до беременности, можете вернуться к легким тренировкам (йога, плавание).';

  @override
  String get insightWeek13Milestone => 'Формирование отпечатков пальцев';

  @override
  String get insightWeek13Insight1Title => 'Уникальность';

  @override
  String get insightWeek13Insight1Content => 'Узор на пальчиках уже сформирован. Такого больше нет ни у кого.';

  @override
  String get insightWeek13Insight2Title => 'Новости';

  @override
  String get insightWeek13Insight2Content => 'Многие выбирают это время, чтобы рассказать друзьям о беременности.';

  @override
  String get insightWeek13Insight3Title => 'Связки';

  @override
  String get insightWeek13Insight3Content => 'Боль по бокам живота — это растягиваются круглые связки матки.';

  @override
  String get insightWeek14FruitTitle => 'Нектарин';

  @override
  String get insightWeek14FruitDescription => 'Румяный фрукт. Малыш учится мимике.';

  @override
  String get insightWeek14RealisticTitle => 'Елочный шар';

  @override
  String get insightWeek14RealisticDescription => 'Хрупкое чудо, которое делает праздник особенным. Совсем как он.';

  @override
  String get insightWeek14GrowthTitle => 'Рост 8–9 см, Вес ~43 г';

  @override
  String get insightWeek14GrowthDescription => 'Размером с лимон. Второй триместр начался активно.';

  @override
  String get insightWeek14BabyDev => 'Малыш начинает тренировать мимику: хмурится, щурится и даже делает глотательные движения.';

  @override
  String get insightWeek14MomBody => 'Животик начинает округляться. Уровень энергии сейчас на максимуме.';

  @override
  String get insightWeek14Tip => 'Посетите стоматолога для планового осмотра. Десны сейчас особенно уязвимы.';

  @override
  String get insightWeek14Milestone => 'Начало второго триместра';

  @override
  String get insightWeek14Insight1Title => 'Гримасы';

  @override
  String get insightWeek14Insight1Content => 'Малыш учится хмуриться, щуриться и улыбаться. Тренировка эмоций.';

  @override
  String get insightWeek14Insight2Title => 'Золотое время';

  @override
  String get insightWeek14Insight2Content => 'Второй триместр — самый спокойный. Наслаждайтесь своим состоянием.';

  @override
  String get insightWeek14Insight3Title => 'Стоматолог';

  @override
  String get insightWeek14Insight3Content => 'Гормоны влияют на десны. Лучшее время посетить врача.';

  @override
  String get insightWeek15FruitTitle => 'Яблоко';

  @override
  String get insightWeek15FruitDescription => 'Наливное яблочко. Он реагирует на свет.';

  @override
  String get insightWeek15RealisticTitle => 'Чайная чашка';

  @override
  String get insightWeek15RealisticDescription => 'Для теплого какао. Он уже слышит ваше сердцебиение изнутри.';

  @override
  String get insightWeek15GrowthTitle => 'Рост 10–11 см, Вес ~70 г';

  @override
  String get insightWeek15GrowthDescription => 'Размером с яблоко. Рост уже превысил 10 см!';

  @override
  String get insightWeek15BabyDev => 'Кожа малыша очень тонкая, сквозь нее просвечивают кровеносные сосуды. Начинает развиваться слух.';

  @override
  String get insightWeek15MomBody => 'Может появиться заложенность носа («ринит беременных») из-за увеличения объема крови.';

  @override
  String get insightWeek15Tip => 'Начинайте спать на боку. Сон на спине может пережимать полую вену.';

  @override
  String get insightWeek15Milestone => 'Развитие слуха';

  @override
  String get insightWeek15Insight1Title => 'Слух';

  @override
  String get insightWeek15Insight1Content => 'Слуховые косточки затвердели. Он слышит ваш голос и урчание живота.';

  @override
  String get insightWeek15Insight2Title => 'Иммунитет';

  @override
  String get insightWeek15Insight2Content => 'Может появиться «ринит беременных» из-за отека слизистой.';

  @override
  String get insightWeek15Insight3Title => 'Общение';

  @override
  String get insightWeek15Insight3Content => 'Читайте вслух или пойте. Малыш запоминает ваши интонации.';

  @override
  String get insightWeek16FruitTitle => 'Авокадо';

  @override
  String get insightWeek16FruitDescription => 'Питательный и мягкий. Малыш держит голову прямо.';

  @override
  String get insightWeek16RealisticTitle => 'Резиновая уточка';

  @override
  String get insightWeek16RealisticDescription => 'Ваш будущий компаньон для веселых купаний и мыльных пузырей.';

  @override
  String get insightWeek16GrowthTitle => 'Рост 11–12 см, Вес ~100 г';

  @override
  String get insightWeek16GrowthDescription => 'Размером с авокадо. Малыш весит уже 100 граммов!';

  @override
  String get insightWeek16BabyDev => 'Пропорции выравниваются: ноги стали длиннее рук. Сердце перекачивает около 25 литров крови в сутки.';

  @override
  String get insightWeek16MomBody => 'Некоторые мамы на этом сроке уже чувствуют первые легкие трепетания малыша.';

  @override
  String get insightWeek16Tip => 'Купите подушку для беременных в форме буквы U или C — она спасет ваш сон.';

  @override
  String get insightWeek16Milestone => 'Пропорции становятся человеческими';

  @override
  String get insightWeek16Insight1Title => 'Пропорции';

  @override
  String get insightWeek16Insight1Content => 'Ноги стали длиннее рук. Он больше не похож на головастика.';

  @override
  String get insightWeek16Insight2Title => 'Беременный мозг';

  @override
  String get insightWeek16Insight2Content => 'Забывчивость? Ваш мозг фокусируется на главном, отсекая шум.';

  @override
  String get insightWeek16Insight3Title => 'Сон';

  @override
  String get insightWeek16Insight3Content => 'Учитесь спать на боку. Сон на спине может пережимать вены.';

  @override
  String get insightWeek17FruitTitle => 'Гранат';

  @override
  String get insightWeek17FruitDescription => 'Полон сокровищ. Хрящики превращаются в кости.';

  @override
  String get insightWeek17RealisticTitle => 'Геймпад';

  @override
  String get insightWeek17RealisticDescription => 'Первые игры и победы. Он учится управлять телом, как в сложной игре.';

  @override
  String get insightWeek17GrowthTitle => 'Рост 13–14 см, Вес ~140 г';

  @override
  String get insightWeek17GrowthDescription => 'Размером с крупную луковицу. Кости крепчают.';

  @override
  String get insightWeek17BabyDev => 'Подкожный жир начинает накапливаться. Формируются потовые железы.';

  @override
  String get insightWeek17MomBody => 'Животик меняет центр тяжести вашего тела. Возможны боли в пояснице.';

  @override
  String get insightWeek17Tip => 'Делайте легкую растяжку или запишитесь на йогу для беременных, чтобы снять спазмы в спине.';

  @override
  String get insightWeek17Milestone => 'Накопление подкожного жира';

  @override
  String get insightWeek17Insight1Title => 'Кости';

  @override
  String get insightWeek17Insight1Content => 'Мягкие хрящи твердеют. Ему нужен кальций.';

  @override
  String get insightWeek17Insight2Title => 'Пуповина';

  @override
  String get insightWeek17Insight2Content => 'Она становится толще и крепче, обеспечивая бесперебойное питание.';

  @override
  String get insightWeek17Insight3Title => 'Обувь';

  @override
  String get insightWeek17Insight3Content => 'Центр тяжести смещается. Смените каблуки на устойчивую обувь.';

  @override
  String get insightWeek18FruitTitle => 'Болгарский перец';

  @override
  String get insightWeek18FruitDescription => 'Объемный и легкий. Нервы получают защиту.';

  @override
  String get insightWeek18RealisticTitle => 'Бумажный самолетик';

  @override
  String get insightWeek18RealisticDescription => 'Мечты, запущенные в полет. Легкость и вера, что он взлетит высоко.';

  @override
  String get insightWeek18GrowthTitle => 'Рост ~14 см, Вес ~190 г';

  @override
  String get insightWeek18GrowthDescription => 'Размером со сладкий перец. Малыш быстро тяжелеет.';

  @override
  String get insightWeek18BabyDev => 'Нервы покрываются миелином (защитной оболочкой). Уши встают на свое окончательное место.';

  @override
  String get insightWeek18MomBody => 'Многие женщины на этой неделе начинают явно чувствовать толчки малыша.';

  @override
  String get insightWeek18Tip => 'Запланируйте второе плановое УЗИ (18-21 неделя), чтобы детально проверить органы.';

  @override
  String get insightWeek18Milestone => 'Первые отчетливые толчки';

  @override
  String get insightWeek18Insight1Title => 'Первые пинки';

  @override
  String get insightWeek18Insight1Content => 'Как рыбий хвост или крыло бабочки. Это первые приветы.';

  @override
  String get insightWeek18Insight2Title => 'Папа';

  @override
  String get insightWeek18Insight2Content => 'Привлекайте партнера. Пусть он тоже положит руку на живот.';

  @override
  String get insightWeek18Insight3Title => 'УЗИ';

  @override
  String get insightWeek18Insight3Content => 'Плановый скрининг. Возможно, вы узнаете пол малыша.';

  @override
  String get insightWeek19FruitTitle => 'Манго';

  @override
  String get insightWeek19FruitDescription => 'Сладкий и экзотический. Появляется смазка на коже.';

  @override
  String get insightWeek19RealisticTitle => 'Детские очки';

  @override
  String get insightWeek19RealisticDescription => 'Яркое лето, пляж и защита для самых любопытных глаз.';

  @override
  String get insightWeek19GrowthTitle => 'Рост ~15 см, Вес ~240 г';

  @override
  String get insightWeek19GrowthDescription => 'Размером с манго. Накопление жировой ткани идет полным ходом.';

  @override
  String get insightWeek19BabyDev => 'Кожа покрывается сыровидной смазкой (верниксом), чтобы не размокнуть в амниотической жидкости.';

  @override
  String get insightWeek19MomBody => 'Возможно появление пигментных пятен или темной линии на животе (linea nigra). Это временно.';

  @override
  String get insightWeek19Tip => 'Используйте солнцезащитный крем при выходе на улицу, кожа сейчас склонна к пигментации.';

  @override
  String get insightWeek19Milestone => 'Появление защитной смазки кожи';

  @override
  String get insightWeek19Insight1Title => 'Верникс';

  @override
  String get insightWeek19Insight1Content => 'Кожа покрывается сыровидной смазкой для защиты от воды.';

  @override
  String get insightWeek19Insight2Title => 'Волосы';

  @override
  String get insightWeek19Insight2Content => 'На голове появляются первые волосики, хотя цвет еще может измениться.';

  @override
  String get insightWeek19Insight3Title => 'Имя';

  @override
  String get insightWeek19Insight3Content => 'Начните составлять список имен. Произносите их вслух с фамилией.';

  @override
  String get insightWeek20FruitTitle => 'Банан';

  @override
  String get insightWeek20FruitDescription => 'Длинный и изогнутый. Экватор! Половина пути.';

  @override
  String get insightWeek20RealisticTitle => 'Детская бутылочка';

  @override
  String get insightWeek20RealisticDescription => 'Символ заботы. Время, когда вы нужны ему больше всего.';

  @override
  String get insightWeek20GrowthTitle => 'Рост ~25 см, Вес ~300 г';

  @override
  String get insightWeek20GrowthDescription => 'С этой недели рост измеряется от макушки до пяточек!';

  @override
  String get insightWeek20BabyDev => 'Малыш начинает проглатывать околоплодные воды, тренируя желудок и почки.';

  @override
  String get insightWeek20MomBody => 'Поздравляем с экватором! Матка поднялась до уровня пупка.';

  @override
  String get insightWeek20Tip => 'Проверьте уровень железа в крови. Если нужно, врач назначит добавки.';

  @override
  String get insightWeek20Milestone => 'Экватор беременности';

  @override
  String get insightWeek20Insight1Title => 'Экватор';

  @override
  String get insightWeek20Insight1Content => 'Полпути пройдено! Матка поднялась до уровня пупка.';

  @override
  String get insightWeek20Insight2Title => 'Мальчик или девочка?';

  @override
  String get insightWeek20Insight2Content => 'Если вы узнали пол, связь с малышом может стать крепче.';

  @override
  String get insightWeek20Insight3Title => 'Железо';

  @override
  String get insightWeek20Insight3Content => 'Объем крови вырос. Ешьте говядину или гречку для гемоглобина.';

  @override
  String get insightWeek21FruitTitle => 'Морковь';

  @override
  String get insightWeek21FruitDescription => 'Яркий корнеплод. Малыш тренирует пищеварение.';

  @override
  String get insightWeek21RealisticTitle => 'Пенал';

  @override
  String get insightWeek21RealisticDescription => 'Первые рисунки, каракули и семейные портреты на холодильнике.';

  @override
  String get insightWeek21GrowthTitle => 'Рост ~26 см, Вес ~360 г';

  @override
  String get insightWeek21GrowthDescription => 'Размером с морковь. Вес продолжает быстро расти.';

  @override
  String get insightWeek21BabyDev => 'Вкусовые рецепторы сформированы. Вкус вод меняется в зависимости от того, что ест мама.';

  @override
  String get insightWeek21MomBody => 'Из-за нагрузки на спину могут появляться боли и спазмы мышц. Возможны судороги ног по ночам.';

  @override
  String get insightWeek21Tip => 'Ешьте продукты, богатые магнием и калием (бананы, орехи), чтобы избежать судорог в ногах.';

  @override
  String get insightWeek21Milestone => 'Малыш чувствует вкус';

  @override
  String get insightWeek21Insight1Title => 'Вкусы';

  @override
  String get insightWeek21Insight1Content => 'Он глотает воды и чувствует вкус вашей еды. Ваше меню формирует его привычки.';

  @override
  String get insightWeek21Insight2Title => 'Танцы';

  @override
  String get insightWeek21Insight2Content => 'Пинки становятся сильными. Кажется, он танцует брейк-данс.';

  @override
  String get insightWeek21Insight3Title => 'Варикоз';

  @override
  String get insightWeek21Insight3Content => 'Отдыхайте, подняв ноги выше уровня сердца, чтобы разгрузить вены.';

  @override
  String get insightWeek22FruitTitle => 'Папайя';

  @override
  String get insightWeek22FruitDescription => 'Мягкий тропический фрукт. Малыш изучает себя.';

  @override
  String get insightWeek22RealisticTitle => 'Плюшевый мишка';

  @override
  String get insightWeek22RealisticDescription => 'Верный друг, с которым не страшно засыпать в темноте.';

  @override
  String get insightWeek22GrowthTitle => 'Рост ~27 см, Вес ~430 г';

  @override
  String get insightWeek22GrowthDescription => 'Малыш весит почти полкило! Размеры папайи.';

  @override
  String get insightWeek22BabyDev => 'Улучшается осязание. Малыш трогает свое лицо, дергает пуповину и сосет палец.';

  @override
  String get insightWeek22MomBody => 'Матка продолжает расти, растягивая кожу. Может появиться зуд на животе.';

  @override
  String get insightWeek22Tip => 'Если живот чешется — обильно смазывайте его маслом от растяжек или увлажняющим лосьоном.';

  @override
  String get insightWeek22Milestone => 'Развитие осязания';

  @override
  String get insightWeek22Insight1Title => 'Осязание';

  @override
  String get insightWeek22Insight1Content => 'Он трогает лицо, ножки, пуповину. Он изучает себя.';

  @override
  String get insightWeek22Insight2Title => 'Фотосессия';

  @override
  String get insightWeek22Insight2Content => 'Животик сейчас выглядит очень аккуратно. Идеальное время для фото на память.';

  @override
  String get insightWeek22Insight3Title => 'Эмоции';

  @override
  String get insightWeek22Insight3Content => 'Он чувствует ваше настроение. Радость мамы — радость малыша.';

  @override
  String get insightWeek23FruitTitle => 'Грейпфрут';

  @override
  String get insightWeek23FruitDescription => 'Крупный цитрус. Малыш слышит внешние звуки.';

  @override
  String get insightWeek23RealisticTitle => 'Первый кед';

  @override
  String get insightWeek23RealisticDescription => 'Для тех самых первых неуверенных шагов навстречу маме.';

  @override
  String get insightWeek23GrowthTitle => 'Рост ~28 см, Вес ~500 г';

  @override
  String get insightWeek23GrowthDescription => 'Важная отметка: малыш достиг веса в 500 граммов.';

  @override
  String get insightWeek23BabyDev => 'Легкие начинают вырабатывать сурфактант — вещество, которое не даст альвеолам слипаться после рождения.';

  @override
  String get insightWeek23MomBody => 'Могут появиться ложные схватки Брэкстона-Хикса (безболезненное напряжение живота).';

  @override
  String get insightWeek23Tip => 'Начинайте делать упражнения Кегеля. Это поможет избежать разрывов в родах и быстро восстановиться.';

  @override
  String get insightWeek23Milestone => 'Выработка сурфактанта в легких';

  @override
  String get insightWeek23Insight1Title => 'Тренировка';

  @override
  String get insightWeek23Insight1Content => 'Он «вдыхает» жидкость, тренируя легкие для первого крика.';

  @override
  String get insightWeek23Insight2Title => 'Ритм';

  @override
  String get insightWeek23Insight2Content => 'Малыш может двигаться в такт вашей музыке. Потанцуйте медленно.';

  @override
  String get insightWeek23Insight3Title => 'Вода';

  @override
  String get insightWeek23Insight3Content => 'К вечеру отеки могут усиливаться. Пейте чистую воду, избегайте соленого.';

  @override
  String get insightWeek24FruitTitle => 'Початок кукурузы';

  @override
  String get insightWeek24FruitDescription => 'Золотой и спелый. Личико полностью сформировано.';

  @override
  String get insightWeek24RealisticTitle => 'Школьная линейка';

  @override
  String get insightWeek24RealisticDescription => 'Он растет и наливается силой, как урожай под солнцем.';

  @override
  String get insightWeek24GrowthTitle => 'Рост ~30 см, Вес ~600 г';

  @override
  String get insightWeek24GrowthDescription => 'Длина достигла 30 см (размер кукурузного початка).';

  @override
  String get insightWeek24BabyDev => 'Лицо малыша сформировано: есть ресницы, брови, волосы. Тело пока очень худенькое.';

  @override
  String get insightWeek24MomBody => 'Пупок может начать выпячиваться наружу. Из-за давления матки может возникнуть изжога.';

  @override
  String get insightWeek24Tip => 'Между 24 и 28 неделями необходимо сдать глюкозотолерантный тест на гестационный диабет.';

  @override
  String get insightWeek24Milestone => 'Возраст жизнеспособности';

  @override
  String get insightWeek24Insight1Title => 'Жизнеспособность';

  @override
  String get insightWeek24Insight1Content => 'Важный рубеж. Медицина уже может помочь малышу выжить вне матки.';

  @override
  String get insightWeek24Insight2Title => 'Лицо';

  @override
  String get insightWeek24Insight2Content => 'Личико полностью готово. Ресницы, брови, носик — все на месте.';

  @override
  String get insightWeek24Insight3Title => 'Глюкозотолерантный тест';

  @override
  String get insightWeek24Insight3Content => 'Важно проверить сахар, чтобы исключить диабет беременных.';

  @override
  String get insightWeek25FruitTitle => 'Цветная капуста';

  @override
  String get insightWeek25FruitDescription => 'Пышное соцветие. Кожа разглаживается.';

  @override
  String get insightWeek25RealisticTitle => 'Бейсбольная ловушка';

  @override
  String get insightWeek25RealisticDescription => 'Умение ловить удачу. Быть частью команды с мамой и папой.';

  @override
  String get insightWeek25GrowthTitle => 'Рост ~34 см, Вес ~660 г';

  @override
  String get insightWeek25GrowthDescription => 'Малыш набирает массу, кожа постепенно разглаживается.';

  @override
  String get insightWeek25BabyDev => 'В легких формируются кровеносные сосуды. Малыш начинает накапливать жирок, кожа розовеет.';

  @override
  String get insightWeek25MomBody => 'Волосы выглядят шикарно! Они почти не выпадают благодаря высокому уровню эстрогена.';

  @override
  String get insightWeek25Tip => 'Если у вас появляется синдром беспокойных ног перед сном — сдайте кровь на железо (ферритин).';

  @override
  String get insightWeek25Milestone => 'Накопление жировой ткани';

  @override
  String get insightWeek25Insight1Title => 'Капилляры';

  @override
  String get insightWeek25Insight1Content => 'Кожа розовеет, наполняясь мелкими сосудами.';

  @override
  String get insightWeek25Insight2Title => 'Волосы';

  @override
  String get insightWeek25Insight2Content => 'Ваши волосы могут стать густыми и блестящими. Наслаждайтесь объемом.';

  @override
  String get insightWeek25Insight3Title => 'Спина';

  @override
  String get insightWeek25Insight3Content => 'Центр тяжести сместился. Йога или бассейн снимут напряжение.';

  @override
  String get insightWeek26FruitTitle => 'Кабачок';

  @override
  String get insightWeek26FruitDescription => 'Гладкий и растущий. Глазки открываются!';

  @override
  String get insightWeek26RealisticTitle => 'Складной зонтик';

  @override
  String get insightWeek26RealisticDescription => 'Защита от непогоды и веселые прыжки по лужам в резиновых сапогах.';

  @override
  String get insightWeek26GrowthTitle => 'Рост ~35 см, Вес ~760 г';

  @override
  String get insightWeek26GrowthDescription => 'Размером с цуккини. Малыш становится все круглее.';

  @override
  String get insightWeek26BabyDev => 'Малыш впервые открывает глаза! Цвет радужки пока голубой или синий, он изменится позже.';

  @override
  String get insightWeek26MomBody => 'Живот растет как на дрожжах. Возможна одышка даже при подъеме по небольшой лестнице.';

  @override
  String get insightWeek26Tip => 'Пора начать присматривать роддом и врача, если вы планируете контрактные роды.';

  @override
  String get insightWeek26Milestone => 'Малыш открывает глаза';

  @override
  String get insightWeek26Insight1Title => 'Глаза';

  @override
  String get insightWeek26Insight1Content => 'Веки открываются. Он впервые моргает и видит свет сквозь живот.';

  @override
  String get insightWeek26Insight2Title => 'Общение';

  @override
  String get insightWeek26Insight2Content => 'Он запоминает голоса. Пусть папа читает ему сказки на ночь.';

  @override
  String get insightWeek26Insight3Title => 'Кольца';

  @override
  String get insightWeek26Insight3Content => 'Пальцы могут отекать. Лучше снять кольца сейчас, пока они не застряли.';

  @override
  String get insightWeek27FruitTitle => 'Кочан капусты';

  @override
  String get insightWeek27FruitDescription => 'Много слоев. Мозг активно развивается.';

  @override
  String get insightWeek27RealisticTitle => 'Ланчбокс';

  @override
  String get insightWeek27RealisticDescription => 'Забота, которую вы положите ему с собой в школу. Записки с любовью.';

  @override
  String get insightWeek27GrowthTitle => 'Рост ~36 см, Вес ~870 г';

  @override
  String get insightWeek27GrowthDescription => 'Приближаемся к отметке в 1 килограмм!';

  @override
  String get insightWeek27BabyDev => 'Мозг становится извилистым. Малыш видит сны и может ритмично икать.';

  @override
  String get insightWeek27MomBody => 'Добро пожаловать в третий триместр! Матка подпирает грудную клетку, легким тесновато.';

  @override
  String get insightWeek27Tip => 'Начинайте изучать техники дыхания в родах — это ваше главное обезболивающее.';

  @override
  String get insightWeek27Milestone => 'Начало третьего триместра';

  @override
  String get insightWeek27Insight1Title => 'Финишная прямая';

  @override
  String get insightWeek27Insight1Content => 'Добро пожаловать в третий триместр! Осталось совсем немного.';

  @override
  String get insightWeek27Insight2Title => 'Сны';

  @override
  String get insightWeek27Insight2Content => 'Тревожные сны о родах нормальны. Мозг репетирует важный день.';

  @override
  String get insightWeek27Insight3Title => 'Икота';

  @override
  String get insightWeek27Insight3Content => 'Ритмичные вздрагивания? Это малыш икает, тренируя диафрагму.';

  @override
  String get insightWeek28FruitTitle => 'Баклажан';

  @override
  String get insightWeek28FruitDescription => 'Глянцевый и темный. Становится тесновато.';

  @override
  String get insightWeek28RealisticTitle => 'Планшет для рисования';

  @override
  String get insightWeek28RealisticDescription => 'Пространство для фантазии, где он нарисует свой собственный мир.';

  @override
  String get insightWeek28GrowthTitle => 'Рост ~37 см, Вес ~1000 г';

  @override
  String get insightWeek28GrowthDescription => 'Малыш достиг 1 килограмма! Значимая веха развития.';

  @override
  String get insightWeek28BabyDev => 'Вес перевалил за 1 килограмм. У малыша появляются реснички. Он начинает различать свет и тени.';

  @override
  String get insightWeek28MomBody => 'Кровяное давление может немного повыситься. Врач будет внимательно следить за наличием белка в моче.';

  @override
  String get insightWeek28Tip => 'Начинайте считать шевеления каждый день. Используйте наш Трекер шевелений в Центре Заботы.';

  @override
  String get insightWeek28Milestone => 'Вес превысил 1 килограмм';

  @override
  String get insightWeek28Insight1Title => 'Вес';

  @override
  String get insightWeek28Insight1Content => 'Малыш весит больше 1 кг. Ему становится тесно.';

  @override
  String get insightWeek28Insight2Title => 'Резус-фактор';

  @override
  String get insightWeek28Insight2Content => 'Если у вас отрицательный резус, врач может назначить иммуноглобулин.';

  @override
  String get insightWeek28Insight3Title => 'Счетчик шевелений';

  @override
  String get insightWeek28Insight3Content => 'Начните следить за активностью. 10 движений за 2 часа — норма.';

  @override
  String get insightWeek29FruitTitle => 'Мускатная тыква';

  @override
  String get insightWeek29FruitDescription => 'Плотная и сладкая. Начинается терморегуляция.';

  @override
  String get insightWeek29RealisticTitle => 'Укулеле';

  @override
  String get insightWeek29RealisticDescription => 'Маленький инструмент для больших песен и душевных вечеров.';

  @override
  String get insightWeek29GrowthTitle => 'Рост ~38 см, Вес ~1150 г';

  @override
  String get insightWeek29GrowthDescription => 'В матке остается все меньше свободного места.';

  @override
  String get insightWeek29BabyDev => 'У малыша начинает вырабатываться собственный иммунитет. Кости крепчают.';

  @override
  String get insightWeek29MomBody => 'Растущая матка может сдавливать вены, вызывая геморрой или варикоз. Включите в рацион больше клетчатки.';

  @override
  String get insightWeek29Tip => 'Подготовьте детскую аптечку и базовый набор для ухода за новорожденным.';

  @override
  String get insightWeek29Milestone => 'Начало терморегуляции';

  @override
  String get insightWeek29Insight1Title => 'Тепло';

  @override
  String get insightWeek29Insight1Content => 'Мозг учится регулировать температуру тела. Готовится к прохладному миру.';

  @override
  String get insightWeek29Insight2Title => 'Кальций';

  @override
  String get insightWeek29Insight2Content => 'Малыш активно забирает кальций для костей. Ешьте творог.';

  @override
  String get insightWeek29Insight3Title => 'Усталость';

  @override
  String get insightWeek29Insight3Content => 'Желание поспать вернулось? Слушайте свое тело.';

  @override
  String get insightWeek30FruitTitle => 'Дыня Канталупа';

  @override
  String get insightWeek30FruitDescription => 'Ароматная дыня. Пушок исчезает.';

  @override
  String get insightWeek30RealisticTitle => 'Зимняя шапка';

  @override
  String get insightWeek30RealisticDescription => 'Тепло для долгих прогулок за руку по хрустящему снегу.';

  @override
  String get insightWeek30GrowthTitle => 'Рост ~39 см, Вес ~1300 г';

  @override
  String get insightWeek30GrowthDescription => 'Размером с крупный кочан капусты.';

  @override
  String get insightWeek30BabyDev => 'Волосики (лануго) начинают выпадать. Кожа становится более гладкой и светлеет.';

  @override
  String get insightWeek30MomBody => 'Декрет не за горами! Усталость в спине и ногах к вечеру становится привычной.';

  @override
  String get insightWeek30Tip => 'Пришло время собирать сумку в роддом. Пройдитесь по чек-листу в нашем приложении.';

  @override
  String get insightWeek30Milestone => 'Исчезновение первичного пушка';

  @override
  String get insightWeek30Insight1Title => 'Кожа';

  @override
  String get insightWeek30Insight1Content => 'Пушок (лануго) сходит с тела. Кожа разглаживается.';

  @override
  String get insightWeek30Insight2Title => 'Гнездование';

  @override
  String get insightWeek30Insight2Content => 'Хочется мыть и убирать? Это инстинкт гнездования.';

  @override
  String get insightWeek30Insight3Title => 'Обувь';

  @override
  String get insightWeek30Insight3Content => 'Нога может вырасти на размер из-за отеков и расслабления связок.';

  @override
  String get insightWeek31FruitTitle => 'Ананас';

  @override
  String get insightWeek31FruitDescription => 'Мозг работает на полную мощность.';

  @override
  String get insightWeek31RealisticTitle => 'Футбольный мяч';

  @override
  String get insightWeek31RealisticDescription => 'Первый гол, разбитая коленка и гордость победителя.';

  @override
  String get insightWeek31GrowthTitle => 'Рост ~41 см, Вес ~1500 г';

  @override
  String get insightWeek31GrowthDescription => 'Полтора килограмма! Рост активно продолжается.';

  @override
  String get insightWeek31BabyDev => 'Мозг увеличивается в объеме, нервные связи формируются молниеносно. Малыш реагирует на свет и тьму.';

  @override
  String get insightWeek31MomBody => 'Молочные железы начинают вырабатывать молозиво (желтоватую жидкость). Дышать становится тяжелее.';

  @override
  String get insightWeek31Tip => 'Если вы чувствуете сильную одышку, спите полусидя на нескольких подушках.';

  @override
  String get insightWeek31Milestone => 'Скачок развития мозга';

  @override
  String get insightWeek31Insight1Title => 'Мозг';

  @override
  String get insightWeek31Insight1Content => 'Нейронные связи формируются с огромной скоростью. Он обрабатывает информацию.';

  @override
  String get insightWeek31Insight2Title => 'Дыхание';

  @override
  String get insightWeek31Insight2Content => 'Матка давит на легкие, вызывая одышку. Двигайтесь в медленном темпе.';

  @override
  String get insightWeek31Insight3Title => 'Молозиво';

  @override
  String get insightWeek31Insight3Content => 'Из груди может выделяться жидкость. Это первая еда малыша.';

  @override
  String get insightWeek32FruitTitle => 'Пекинская капуста';

  @override
  String get insightWeek32FruitDescription => 'Мягкие листья. Малыш перевернулся головой вниз.';

  @override
  String get insightWeek32RealisticTitle => 'Толстая книга';

  @override
  String get insightWeek32RealisticDescription => 'Сказки, которые научат его добру и смелости перед сном.';

  @override
  String get insightWeek32GrowthTitle => 'Рост ~42 см, Вес ~1700 г';

  @override
  String get insightWeek32GrowthDescription => 'Длина от макушки до пят уже около 42 см.';

  @override
  String get insightWeek32BabyDev => 'Большинство детей на этом сроке занимают стартовую позицию — головой вниз.';

  @override
  String get insightWeek32MomBody => 'Кровообращение замедлено. Отеки ступней к вечеру — ваша новая норма.';

  @override
  String get insightWeek32Tip => 'Если малыш еще в тазовом предлежании, врач может порекомендовать специальную гимнастику.';

  @override
  String get insightWeek32Milestone => 'Переворот вниз головой';

  @override
  String get insightWeek32Insight1Title => 'Положение';

  @override
  String get insightWeek32Insight1Content => 'Скорее всего, он уже перевернулся головой вниз, готовясь к выходу.';

  @override
  String get insightWeek32Insight2Title => 'Курсы';

  @override
  String get insightWeek32Insight2Content => 'Лучшее время изучить техники дыхания в родах.';

  @override
  String get insightWeek32Insight3Title => 'Визиты';

  @override
  String get insightWeek32Insight3Content => 'Встречи с врачом становятся чаще — каждые две недели.';

  @override
  String get insightWeek33FruitTitle => 'Дуриан';

  @override
  String get insightWeek33FruitDescription => 'Король фруктов. Иммунитет окреп.';

  @override
  String get insightWeek33RealisticTitle => 'Спальный мешок';

  @override
  String get insightWeek33RealisticDescription => 'Походы, звездное небо и самые честные разговоры у костра.';

  @override
  String get insightWeek33GrowthTitle => 'Рост ~43 см, Вес ~1900 г';

  @override
  String get insightWeek33GrowthDescription => 'Почти 2 килограмма. Размером с ананас.';

  @override
  String get insightWeek33BabyDev => 'Малыш получает ваши антитела через плаценту. Его кости полностью затвердели, кроме черепа.';

  @override
  String get insightWeek33MomBody => 'Бессонница может обостриться. Сложно найти удобную позу из-за огромного живота.';

  @override
  String get insightWeek33Tip => 'Завершите все крупные покупки. Постирайте и погладьте детские вещи.';

  @override
  String get insightWeek33Milestone => 'Иммунная система готова';

  @override
  String get insightWeek33Insight1Title => 'Иммунитет';

  @override
  String get insightWeek33Insight1Content => 'Вы передаете ему свои антитела. Его первая защита от вирусов.';

  @override
  String get insightWeek33Insight2Title => 'Сумка в роддом';

  @override
  String get insightWeek33Insight2Content => 'Начните собирать вещи. Спокойствие приходит с готовностью.';

  @override
  String get insightWeek33Insight3Title => 'Изжога';

  @override
  String get insightWeek33Insight3Content => 'Матка давит на желудок. Ешьте часто, но маленькими порциями.';

  @override
  String get insightWeek34FruitTitle => 'Тыква Мускат';

  @override
  String get insightWeek34FruitDescription => 'Ребристая тыква. Легкие готовы.';

  @override
  String get insightWeek34RealisticTitle => 'Скрипка';

  @override
  String get insightWeek34RealisticDescription => 'Тонкая душа, чувство прекрасного и упорство в обучении.';

  @override
  String get insightWeek34GrowthTitle => 'Рост ~45 см, Вес ~2100 г';

  @override
  String get insightWeek34GrowthDescription => 'Малыш весит больше двух килограммов!';

  @override
  String get insightWeek34BabyDev => 'Центральная нервная система созрела. Легкие накопили достаточно сурфактанта для дыхания.';

  @override
  String get insightWeek34MomBody => 'Глаза могут сохнуть или зрение слегка затуманиться. Это пройдет после родов.';

  @override
  String get insightWeek34Tip => 'Обсудите с врачом ваш план родов: отношение к анестезии, стимуляции и перерезанию пуповины.';

  @override
  String get insightWeek34Milestone => 'Легкие могут дышать самостоятельно';

  @override
  String get insightWeek34Insight1Title => 'Легкие';

  @override
  String get insightWeek34Insight1Content => 'Они почти созрели. Если родится сейчас, он сможет дышать.';

  @override
  String get insightWeek34Insight2Title => 'Замедление';

  @override
  String get insightWeek34Insight2Content => 'Разрешите себе лениться. Берегите силы.';

  @override
  String get insightWeek34Insight3Title => 'Зрение';

  @override
  String get insightWeek34Insight3Content => 'Зрачки могут расширяться и сужаться, реагируя на свет.';

  @override
  String get insightWeek35FruitTitle => 'Дыня Медовая';

  @override
  String get insightWeek35FruitDescription => 'Гладкая и сладкая. Округляется.';

  @override
  String get insightWeek35RealisticTitle => 'Велошлем';

  @override
  String get insightWeek35RealisticDescription => 'Безопасность в первых больших приключениях. Вы всегда будете страховать его.';

  @override
  String get insightWeek35GrowthTitle => 'Рост ~46 см, Вес ~2300 г';

  @override
  String get insightWeek35GrowthDescription => 'Стремительный набор массы — по 200 граммов в неделю.';

  @override
  String get insightWeek35BabyDev => 'Малыш набирает по 200-300 граммов в неделю. Ручки и ножки становятся пухлыми.';

  @override
  String get insightWeek35MomBody => 'Мочевой пузырь сдавлен так, что походы в туалет каждые полчаса не кажутся шуткой.';

  @override
  String get insightWeek35Tip => 'Установите автокресло в машину. Настроить ремни с кричащим младенцем на руках будет сложно.';

  @override
  String get insightWeek35Milestone => 'Активный набор жировой массы';

  @override
  String get insightWeek35Insight1Title => 'Пухляш';

  @override
  String get insightWeek35Insight1Content => 'Он набирает по 200-300 грамм в неделю. Становится очень тесно.';

  @override
  String get insightWeek35Insight2Title => 'План родов';

  @override
  String get insightWeek35Insight2Content => 'Обсудите пожелания с врачом, но будьте готовы к гибкости.';

  @override
  String get insightWeek35Insight3Title => 'Туалет';

  @override
  String get insightWeek35Insight3Content => 'Частые пробежки? Голова малыша давит на мочевой пузырь.';

  @override
  String get insightWeek36FruitTitle => 'Ромэн-салат';

  @override
  String get insightWeek36FruitDescription => 'Крупный и свежий. Живот опускается.';

  @override
  String get insightWeek36RealisticTitle => 'Клавиатура';

  @override
  String get insightWeek36RealisticDescription => 'Первые написанные рассказы, код или письма друзьям.';

  @override
  String get insightWeek36GrowthTitle => 'Рост ~47 см, Вес ~2600 г';

  @override
  String get insightWeek36GrowthDescription => 'Почти готовы! Малыш очень пухлый и милый.';

  @override
  String get insightWeek36BabyDev => 'Пищеварительная система полностью готова к маминому молоку. Череп остается мягким.';

  @override
  String get insightWeek36MomBody => 'Живот может \'опуститься\'. Малыш продвигается в таз. Дышать станет легче, но ходить — тяжелее.';

  @override
  String get insightWeek36Tip => 'Убедитесь, что все документы (паспорт, обменная карта) лежат в сумке. С этой недели вы должны быть готовы.';

  @override
  String get insightWeek36Milestone => 'Опускание живота';

  @override
  String get insightWeek36Insight1Title => 'Опускание';

  @override
  String get insightWeek36Insight1Content => 'Живот может опуститься. Дышать легче, ходить сложнее.';

  @override
  String get insightWeek36Insight2Title => 'Кости черепа';

  @override
  String get insightWeek36Insight2Content => 'Череп малыша остается мягким, чтобы пройти родовые пути.';

  @override
  String get insightWeek36Insight3Title => 'КТГ';

  @override
  String get insightWeek36Insight3Content => 'Теперь вы будете слушать сердцебиение малыша еженедельно.';

  @override
  String get insightWeek37FruitTitle => 'Свекла';

  @override
  String get insightWeek37FruitDescription => 'Крепкий корнеплод. Полностью готов к жизни.';

  @override
  String get insightWeek37RealisticTitle => 'Фотоаппарат';

  @override
  String get insightWeek37RealisticDescription => 'Умение видеть красоту мира и сохранять лучшие моменты.';

  @override
  String get insightWeek37GrowthTitle => 'Рост ~48 см, Вес ~2800 г';

  @override
  String get insightWeek37GrowthDescription => 'Беременность доношена. Роды могут начаться скоро.';

  @override
  String get insightWeek37BabyDev => 'Беременность официально доношенная! Все системы готовы к самостоятельной жизни.';

  @override
  String get insightWeek37MomBody => 'Возможно отхождение слизистой пробки. Тренировочные схватки становятся регулярнее.';

  @override
  String get insightWeek37Tip => 'Заранее удалите лак с ногтей на руках или оставьте прозрачный — врачам нужно видеть цвет ногтевой пластины.';

  @override
  String get insightWeek37Milestone => 'Доношенная беременность';

  @override
  String get insightWeek37Insight1Title => 'Доношенность';

  @override
  String get insightWeek37Insight1Content => 'Поздравляем! Беременность считается доношенной. Можно рожать.';

  @override
  String get insightWeek37Insight2Title => 'Пробка';

  @override
  String get insightWeek37Insight2Content => 'Отхождение слизистой пробки — знак скорых родов.';

  @override
  String get insightWeek37Insight3Title => 'Логистика';

  @override
  String get insightWeek37Insight3Content => 'Проверьте маршрут в роддом и зарядите телефон.';

  @override
  String get insightWeek38FruitTitle => 'Лук-порей';

  @override
  String get insightWeek38FruitDescription => 'Длинный стебель. Учимся терпению.';

  @override
  String get insightWeek38RealisticTitle => 'Скейтборд';

  @override
  String get insightWeek38RealisticDescription => 'Смелость падать и подниматься снова. Баланс и свобода.';

  @override
  String get insightWeek38GrowthTitle => 'Рост ~49 см, Вес ~3000 г';

  @override
  String get insightWeek38GrowthDescription => 'Отметка в 3 килограмма успешно пройдена!';

  @override
  String get insightWeek38BabyDev => 'Кишечник наполнен меконием (первородным калом). Голова опустилась глубоко в таз.';

  @override
  String get insightWeek38MomBody => 'Тяжело стоять, лежать и сидеть. Ожидание сводит с ума. Возможны приступы «чистки» квартиры.';

  @override
  String get insightWeek38Tip => 'Отдыхайте впрок. Выспитесь так, как будто это ваша последняя неделя сна (возможно, так и есть).';

  @override
  String get insightWeek38Milestone => 'Накопление мекония';

  @override
  String get insightWeek38Insight1Title => 'Схватки';

  @override
  String get insightWeek38Insight1Content => 'Тренировочные схватки могут стать сильнее. Если нерегулярно — это тренировка.';

  @override
  String get insightWeek38Insight2Title => 'Ожидание';

  @override
  String get insightWeek38Insight2Content => 'Вопросы «еще не родила?» раздражают. Отключите уведомления.';

  @override
  String get insightWeek38Insight3Title => 'Цвет глаз';

  @override
  String get insightWeek38Insight3Content => 'Большинство детей рождаются с голубыми или серыми глазами.';

  @override
  String get insightWeek39FruitTitle => 'Арбуз';

  @override
  String get insightWeek39FruitDescription => 'Тяжелый и спелый. Затихает.';

  @override
  String get insightWeek39RealisticTitle => 'Глобус';

  @override
  String get insightWeek39RealisticDescription => 'Весь мир у его ног. Ему предстоит открыть континенты и океаны.';

  @override
  String get insightWeek39GrowthTitle => 'Рост ~50 см, Вес ~3200 г';

  @override
  String get insightWeek39GrowthDescription => 'Длина полметра. Идеальные пропорции новорожденного.';

  @override
  String get insightWeek39BabyDev => 'Малышу негде двигаться. Пинки сменяются выпячиванием попы или локтей.';

  @override
  String get insightWeek39MomBody => 'Шейка матки начинает укорачиваться и размягчаться, готовясь к открытию.';

  @override
  String get insightWeek39Tip => 'Изучите признаки настоящих родов: регулярные нарастающие схватки с интервалом менее 5 минут или отхождение вод.';

  @override
  String get insightWeek39Milestone => 'Подготовка шейки матки';

  @override
  String get insightWeek39Insight1Title => 'Затишье';

  @override
  String get insightWeek39Insight1Content => 'Малыш может стать тише перед стартом. Копит силы.';

  @override
  String get insightWeek39Insight2Title => 'Отдых';

  @override
  String get insightWeek39Insight2Content => 'Спите, читайте, смотрите фильмы. Последний раз «только для себя».';

  @override
  String get insightWeek39Insight3Title => 'Шейка матки';

  @override
  String get insightWeek39Insight3Content => 'Врач может сказать, что шейка сглаживается и раскрывается.';

  @override
  String get insightWeek40FruitTitle => 'Тыква';

  @override
  String get insightWeek40FruitDescription => 'Праздничная и огромная. Готов к дню Икс.';

  @override
  String get insightWeek40RealisticTitle => 'Первое боди';

  @override
  String get insightWeek40RealisticDescription => 'Он готов. Скоро вы оденете его и обнимете по-настоящему.';

  @override
  String get insightWeek40GrowthTitle => 'Рост ~51 см, Вес ~3400+ г';

  @override
  String get insightWeek40GrowthDescription => 'Средний размер доношенного новорожденного малыша.';

  @override
  String get insightWeek40BabyDev => 'Вес может достигать 3.5 кг и больше. Малыш полностью сформирован и ждет сигнала к рождению.';

  @override
  String get insightWeek40MomBody => 'ПДР настал! Если ничего не происходит — не паникуйте. Только 5% детей рождаются точно в ПДР.';

  @override
  String get insightWeek40Tip => 'Запустите наш таймер схваток. Мы подскажем, когда нужно ехать в больницу по правилу 5-1-1.';

  @override
  String get insightWeek40Milestone => 'Предполагаемая дата родов (ПДР)';

  @override
  String get insightWeek40Insight1Title => 'День Икс';

  @override
  String get insightWeek40Insight1Content => 'ПДР — лишь ориентир. Малыш выберет свой идеальный момент.';

  @override
  String get insightWeek40Insight2Title => 'Встреча';

  @override
  String get insightWeek40Insight2Content => 'Скоро вы посмотрите в глаза, которые создавали 9 месяцев.';

  @override
  String get insightWeek40Insight3Title => 'Воды';

  @override
  String get insightWeek40Insight3Content => 'Если воды отошли — езжайте в роддом сразу, даже без боли.';

  @override
  String get insightWeek41FruitTitle => 'Спелая дыня';

  @override
  String get insightWeek41FruitDescription => 'Идеально созревшая. Ожидание затягивается.';

  @override
  String get insightWeek41RealisticTitle => 'Упакованный чемодан';

  @override
  String get insightWeek41RealisticDescription => 'Билеты на руках, багаж сдан, но рейс слегка задерживается.';

  @override
  String get insightWeek41BabyDev => 'Продолжает расти и набирать вес в животе. Кожа может стать немного сухой из-за уменьшения смазки.';

  @override
  String get insightWeek41MomBody => 'Усталость от ожидания на пике. Врач может предложить стимуляцию или тщательный мониторинг (КТГ и УЗИ).';

  @override
  String get insightWeek41Tip => 'Попробуйте естественные методы стимуляции (после консультации с врачом): долгие прогулки, острая еда или романтика.';

  @override
  String get insightWeek41Milestone => 'Переношенная беременность';

  @override
  String get insightWeek41Insight1Title => 'Спокойствие';

  @override
  String get insightWeek41Insight1Content => 'Многие дети просто не торопятся. Ваша задача сейчас — доверять врачам и расслабляться.';

  @override
  String get insightWeek41Insight2Title => 'Стимуляция';

  @override
  String get insightWeek41Insight2Content => 'Прогулки по лестнице и теплый душ могут помочь мягко запустить процесс.';

  @override
  String get insightWeek41Insight3Title => 'Мониторинг';

  @override
  String get insightWeek41Insight3Content => 'Врачи будут чаще проверять кровоток в плаценте и количество околоплодных вод.';

  @override
  String get insightWeek42FruitTitle => 'Сочный джекфрут';

  @override
  String get insightWeek42FruitDescription => 'Самый большой и ожидаемый. Пора знакомиться.';

  @override
  String get insightWeek42RealisticTitle => 'Стрелка часов';

  @override
  String get insightWeek42RealisticDescription => 'Тот самый решающий момент наступил.';

  @override
  String get insightWeek42BabyDev => 'Ногти стали очень длинными, а волосы на голове густыми. Места совсем нет.';

  @override
  String get insightWeek42MomBody => 'Это абсолютный предел. Если роды не начались, вас госпитализируют для медицинской индукции родов.';

  @override
  String get insightWeek42Tip => 'Не расстраивайтесь, если роды придется стимулировать. Главное — это здоровье вас и малыша.';

  @override
  String get insightWeek42Milestone => 'Госпитализация';

  @override
  String get insightWeek42Insight1Title => 'Индукция';

  @override
  String get insightWeek42Insight1Content => 'Врачи помогут вашему телу начать процесс с помощью медицинских методов.';

  @override
  String get insightWeek42Insight2Title => 'Конец пути';

  @override
  String get insightWeek42Insight2Content => 'Это последняя неделя беременности 100%. Финишная черта перед вами.';

  @override
  String get insightWeek42Insight3Title => 'Внешность';

  @override
  String get insightWeek42Insight3Content => 'Переношенные дети рождаются без пушка и смазки, с открытыми и очень внимательными глазками.';

  @override
  String get symptom1Title => 'Токсикоз (Тошнота)';

  @override
  String get symptom1ShortDescription => 'Тошнота и рвота, обычно в начале беременности.';

  @override
  String get symptom1FullDescription => 'Тошнота очень распространена из-за роста гормонов (ХГЧ). Обычно проходит к 16 неделе. \n\nСоветы: Ешьте часто и понемногу, пейте имбирный чай и воду.';

  @override
  String get symptom2Title => 'Боль в круглых связках';

  @override
  String get symptom2ShortDescription => 'Резкая боль внизу живота или в паху.';

  @override
  String get symptom2FullDescription => 'Острая колющая боль в нижней части живота или в паху с одной или обеих сторон. Вызвана растяжением связок, поддерживающих матку.';

  @override
  String get symptom3Title => 'Кровотечение';

  @override
  String get symptom3ShortDescription => 'Любые кровянистые выделения.';

  @override
  String get symptom3FullDescription => 'Легкие мажущие выделения могут быть после секса или осмотра, но ярко-красная кровь НЕ является нормой. \n\nДействие: Немедленно позвоните врачу.';

  @override
  String get symptom4Title => 'Отеки';

  @override
  String get symptom4ShortDescription => 'Отекшие ступни и лодыжки.';

  @override
  String get symptom4FullDescription => 'Легкая отечность нормальна. Однако внезапный отек лица или рук в сочетании с головной болью может быть признаком преэклампсии.';

  @override
  String get symptom5Title => 'Головные боли';

  @override
  String get symptom5ShortDescription => 'От легкой до сильной боли.';

  @override
  String get symptom5FullDescription => 'Часто возникают из-за гормонов или обезвоживания. \n\nВажно: Сильная головная боль, которая не проходит, может быть признаком высокого давления.';

  @override
  String get symptom6Title => 'Схватки Брэкстона-Хикса';

  @override
  String get symptom6ShortDescription => 'Тренировочные схватки.';

  @override
  String get symptom6FullDescription => 'Нерегулярное, безболезненное напряжение живота. Проходит при движении или после воды. \n\nЕсли они становятся регулярными и болезненными -> Звоните врачу.';

  @override
  String get symptom7Title => 'Усталость';

  @override
  String get symptom7ShortDescription => 'Сильная утомляемость.';

  @override
  String get symptom7FullDescription => 'Очень часто встречается из-за гормональных изменений и повышенных затрат энергии. Отдыхайте при любой возможности.';

  @override
  String get symptom8Title => 'Чувствительность груди';

  @override
  String get symptom8ShortDescription => 'Болезненность или чувствительность.';

  @override
  String get symptom8FullDescription => 'Вызвана ростом гормонов. Обычно состояние улучшается после первого триместра.';

  @override
  String get symptom9Title => 'Частое мочеиспускание';

  @override
  String get symptom9ShortDescription => 'Частые позывы в туалет.';

  @override
  String get symptom9FullDescription => 'Давление матки на мочевой пузырь и гормоны вызывают частые позывы. Это норма, если нет боли.';

  @override
  String get symptom10Title => 'Запор';

  @override
  String get symptom10ShortDescription => 'Трудности с пищеварением.';

  @override
  String get symptom10FullDescription => 'Гормоны замедляют пищеварение. Увеличьте количество клетчатки, пейте больше воды и двигайтесь.';

  @override
  String get symptom11Title => 'Изжога';

  @override
  String get symptom11ShortDescription => 'Жжение в груди или горле.';

  @override
  String get symptom11FullDescription => 'Вызвана расслаблением мышц пищевода и давлением матки на желудок.';

  @override
  String get symptom12Title => 'Одышка';

  @override
  String get symptom12ShortDescription => 'Нехватка воздуха.';

  @override
  String get symptom12FullDescription => 'Легкая одышка нормальна. Внезапная или сильная нехватка воздуха требует медицинской помощи.';

  @override
  String get symptom13Title => 'Боль в пояснице';

  @override
  String get symptom13ShortDescription => 'Ноющая боль в спине.';

  @override
  String get symptom13FullDescription => 'Вызвана изменением осанки и лишним весом. Помогает легкая растяжка и правильная обувь.';

  @override
  String get symptom14Title => 'Судороги ног';

  @override
  String get symptom14ShortDescription => 'Болезненные спазмы, обычно ночью.';

  @override
  String get symptom14FullDescription => 'Часто встречаются на поздних сроках. Растяжка икр и достаточное питье могут помочь.';

  @override
  String get symptom15Title => 'Головокружение';

  @override
  String get symptom15ShortDescription => 'Чувство дурноты.';

  @override
  String get symptom15FullDescription => 'Часто вызвано низким давлением или обезвоживанием. Сядьте или лягте, если чувствуете головокружение.';

  @override
  String get symptom16Title => 'Заложенность носа';

  @override
  String get symptom16ShortDescription => 'Ринит беременных.';

  @override
  String get symptom16FullDescription => 'Гормоны беременности усиливают приток крови к слизистой носа. Это нормально и часто встречается.';

  @override
  String get symptom17Title => 'Перепады настроения';

  @override
  String get symptom17ShortDescription => 'Быстрая смена эмоций.';

  @override
  String get symptom17FullDescription => 'Гормональные штормы влияют на настроение. Поддержка близких и отдых очень важны.';

  @override
  String get symptom18Title => 'Выделения';

  @override
  String get symptom18ShortDescription => 'Жидкие, молочные выделения.';

  @override
  String get symptom18FullDescription => 'Нормально, если они без запаха и не вызывают зуда. Помогают защитить от инфекций.';

  @override
  String get symptom19Title => 'Давление в тазу';

  @override
  String get symptom19ShortDescription => 'Чувство тяжести внизу.';

  @override
  String get symptom19FullDescription => 'Обычное явление при росте ребенка. Внезапное сильное давление с болью может указывать на преждевременные роды.';

  @override
  String get symptom20Title => 'Зуд';

  @override
  String get symptom20ShortDescription => 'Легкий зуд кожи.';

  @override
  String get symptom20FullDescription => 'Растягивающаяся кожа может чесаться. Сильный зуд (особенно ладоней и стоп) требует проверки у врача.';

  @override
  String get symptom21Title => 'Температура (Жар)';

  @override
  String get symptom21ShortDescription => 'Повышенная температура тела.';

  @override
  String get symptom21FullDescription => 'Лихорадка во время беременности НЕ является нормой. Свяжитесь с врачом.';

  @override
  String get symptom22Title => 'Сильная боль в животе';

  @override
  String get symptom22ShortDescription => 'Острая боль.';

  @override
  String get symptom22FullDescription => 'Сильная или постоянная боль в животе НЕ нормальна. Требуется медицинская помощь.';

  @override
  String get symptom23Title => 'Малыш меньше шевелится';

  @override
  String get symptom23ShortDescription => 'Снижение активности ребенка.';

  @override
  String get symptom23FullDescription => 'Заметное снижение количества шевелений требует немедленного внимания врача.';

  @override
  String get authEntryTitle => 'Выберите, как начать';

  @override
  String get authEntryBody => 'Можно войти через Apple или Google, если вы хотите связать путь с аккаунтом, или продолжить без аккаунта и пока хранить всё спокойно на этом устройстве.';

  @override
  String get authEntryHint => 'Если захотите, вы сможете подключить аккаунт позже в настройках и не потерять локальный прогресс.';

  @override
  String get authGoogleContinue => 'Продолжить с Google';

  @override
  String get authAppleContinue => 'Продолжить с Apple';

  @override
  String get authGuestContinue => 'Продолжить без аккаунта';

  @override
  String get authSignInError => 'Не удалось завершить вход';

  @override
  String get authConflictTitle => 'Выберите, какие данные сохранить';

  @override
  String get authConflictBody => 'Для этого аккаунта на этом устройстве уже есть сохранённые данные, и одновременно есть прогресс в текущем гостевом режиме. Выберите, какая версия должна остаться за этим аккаунтом.';

  @override
  String get authConflictUseAccount => 'Оставить данные аккаунта';

  @override
  String get authConflictUseDevice => 'Оставить данные с этого устройства';

  @override
  String get authSettingsSectionTitle => 'АККАУНТ';

  @override
  String get authGuestModeTitle => 'Гостевой режим';

  @override
  String get authGuestModeBody => 'Все данные остаются на этом устройстве. Когда захотите, можно будет подключить аккаунт и сохранить путь в более стабильном личном пространстве.';

  @override
  String authSignedInTitle(String provider) {
    return 'Подключено через $provider';
  }

  @override
  String get authSignedInSubtitle => 'Ваш локальный прогресс привязан к этому аккаунту на этом устройстве.';

  @override
  String get authSwitchToGuestTitle => 'Перейти в гостевой режим?';

  @override
  String get authSwitchToGuestBody => 'Данные текущего аккаунта останутся сохранёнными на этом устройстве. После выхода мы откроем для вас новое гостевое пространство.';

  @override
  String get authSwitchToGuestAction => 'Перейти в гостевой режим';

  @override
  String get authGoogleProvider => 'Google';

  @override
  String get authAppleProvider => 'Apple';

  @override
  String get authGuestProvider => 'Гость';
}
