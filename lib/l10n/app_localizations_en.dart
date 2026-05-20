// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Aura';

  @override
  String weekLabel(int week) {
    return 'WEEK $week';
  }

  @override
  String get menuHealth => 'Health & Body';

  @override
  String get menuFamily => 'Family & Memory';

  @override
  String get menuPrep => 'Preparation';

  @override
  String get tabConnection => 'Connection';

  @override
  String get tabDetails => 'Details';

  @override
  String get connectionTitle => 'Letter to baby';

  @override
  String connectionTitleNamed(String name) {
    return 'Letter for $name';
  }

  @override
  String get connectionPlaceholder => 'Write something timeless...';

  @override
  String get connectionSaveAction => 'Save thought';

  @override
  String get connectionOpenDiary => 'Open diary';

  @override
  String get onboardingTitle => 'When is your miracle due?';

  @override
  String get onboardingSubtitle => 'We will personalize the journey for you';

  @override
  String get onboardingNameHint => 'Baby\'s name (optional)';

  @override
  String get onboardingAction => 'Start Journey';

  @override
  String get onboardingStep1Title => 'Welcome!';

  @override
  String get onboardingStep1Sub => 'Elpis is your gentle companion throughout your pregnancy';

  @override
  String get onboardingMomNameLabel => 'YOUR NAME';

  @override
  String get onboardingMomNameHint => 'E.g. Emma or Sarah';

  @override
  String get onboardingBabyNameLabel => 'BABY\'S NICKNAME (OPTIONAL)';

  @override
  String get onboardingBabyNameHint => 'Peanut, Bean...';

  @override
  String get onboardingStep2Title => 'When is your baby due?';

  @override
  String get onboardingByLmp => 'By LMP';

  @override
  String get onboardingByEdd => 'I know EDD';

  @override
  String onboardingDueResult(String date) {
    return 'Due date: $date';
  }

  @override
  String get onboardingStep3Title => 'Almost there!';

  @override
  String get onboardingStep3Sub => 'Elpis is your personal pregnancy journal. We\'re with you every week.';

  @override
  String get onboardingDisclaimerTitle => 'Medical Disclaimer';

  @override
  String get onboardingDisclaimerBody => 'This app provides informational content only and is not a substitute for professional medical advice. Always consult your doctor.';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingBegin => 'Begin Journey 🌸';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNameLabel => 'WHAT DO WE CALL THE BABY?';

  @override
  String get settingsNameHint => 'E.g. Oliver or Bean';

  @override
  String get settingsDateLabel => 'DUE DATE';

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsDeleteData => 'Delete all data';

  @override
  String get settingsDeleteDataConfirm => 'Are you sure? This will delete all your photos, names and history. App will restart.';

  @override
  String get settingsPrivacy => 'Privacy Policy';

  @override
  String get loadingTitle => 'Loading...';

  @override
  String get loadingBody => 'Getting data for this week.';

  @override
  String weekDefault(Object week) {
    return 'Week $week';
  }

  @override
  String get waterTitle => 'Hydration';

  @override
  String get waterFact => 'Water helps renew amniotic fluid every 3 hours.';

  @override
  String waterProgress(int goal) {
    return 'of $goal';
  }

  @override
  String get visitNew => 'New Visit';

  @override
  String get visitEdit => 'Edit Visit';

  @override
  String get visitSectionMain => 'BASICS';

  @override
  String get visitTitleHint => 'Title (e.g. Ultrasound)';

  @override
  String get visitDoctor => 'Doctor / Clinic';

  @override
  String get visitQuestions => 'YOUR QUESTIONS';

  @override
  String get visitQuestionsPlaceholder => 'What to ask the doctor?\n- Can I fly?\n- Which vitamins to take?';

  @override
  String get visitResults => 'RESULTS';

  @override
  String get visitWeight => 'Weight (kg)';

  @override
  String get visitBpSys => 'Sys';

  @override
  String get visitBpDia => 'Dia';

  @override
  String get visitNotesHint => 'Doctor\'s notes & prescription...';

  @override
  String get visitCalendar => 'Visits Calendar';

  @override
  String get visitEmpty => 'No upcoming visits';

  @override
  String get visitFab => 'Visit';

  @override
  String get visitBadgeQuestions => 'Questions';

  @override
  String get visitBadgeResults => 'Results';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonMin => 'min';

  @override
  String get commonSec => 'sec';

  @override
  String get toolsTitle => 'Care Center';

  @override
  String get toolsSectionDaily => 'Daily';

  @override
  String get toolsSectionHealth => 'Health & Labor';

  @override
  String get toolsSectionFamily => 'Family & Memories';

  @override
  String get toolSymptoms => 'Wellness';

  @override
  String get toolSymptomsSub => 'Symptoms log';

  @override
  String get toolKegel => 'Kegel';

  @override
  String get toolKegelSub => 'Pelvic floor';

  @override
  String get toolNames => 'Baby Names';

  @override
  String get toolNamesSub => 'Swipe together';

  @override
  String get toolContractions => 'Contractions';

  @override
  String get toolContractionsSub => 'Labor timer';

  @override
  String get toolWeight => 'Weight';

  @override
  String get toolWeightSub => 'Tracker';

  @override
  String get toolWater => 'Water';

  @override
  String get toolWaterSub => 'Hydration';

  @override
  String get toolKicks => 'Kicks';

  @override
  String get toolKicksSub => 'Counter';

  @override
  String get toolBag => 'Hospital Bag';

  @override
  String get toolBagSub => 'Checklist';

  @override
  String get toolVisits => 'Visits';

  @override
  String get toolVisitsSub => 'Plan & Notes';

  @override
  String get toolGallery => 'Bump Gallery';

  @override
  String get toolGallerySub => 'Bump timelapse';

  @override
  String get paywallTitle => 'Bloom Premium';

  @override
  String get paywallSubtitleAndroid => 'Premium features for Android are still in development.';

  @override
  String get paywallSubtitleDefault => 'Support development and unlock all features.';

  @override
  String get paywallFeatureBackup => 'Full cloud backup coming soon';

  @override
  String get paywallFeatureInsights => 'Advanced health insights';

  @override
  String get paywallFeatureNoAds => 'No ads';

  @override
  String get paywallStatusTitleAndroid => 'Android purchases are coming soon';

  @override
  String get paywallStatusTitleDefault => 'Purchases are being connected';

  @override
  String get paywallStatusBody => 'Premium tools are already marked in the app. Plans will appear here as soon as billing is available.';

  @override
  String get symptomTitle => 'How do you feel?';

  @override
  String get symptomMoodLabel => 'MOOD';

  @override
  String get symptomLabel => 'SYMPTOMS';

  @override
  String get symptomSave => 'Save Log';

  @override
  String get symNausea => 'Nausea';

  @override
  String get symFatigue => 'Fatigue';

  @override
  String get symHeartburn => 'Heartburn';

  @override
  String get symSwelling => 'Swelling';

  @override
  String get symHeadache => 'Headache';

  @override
  String get symInsomnia => 'Insomnia';

  @override
  String get symBackPain => 'Back pain';

  @override
  String get symHunger => 'Hunger';

  @override
  String get symBabyActive => 'Baby active';

  @override
  String get symAnxiety => 'Anxiety';

  @override
  String get kickTitle => 'CONNECTION SESSION';

  @override
  String get kickInstruction => 'Tap on\nmovement';

  @override
  String kickCount(int count) {
    return 'Movements: $count';
  }

  @override
  String get kickGoal => 'Goal: 10 movements';

  @override
  String get kickSessionDone => 'Session Completed';

  @override
  String get kickDialogTitle => 'Great Job!';

  @override
  String kickDialogBody(int count, String time) {
    return 'You counted $count movements in $time.';
  }

  @override
  String get kegelTitle => 'Kegel Training';

  @override
  String get kegelSubtitle => 'Strengthening pelvic floor muscles prepares body for labor.';

  @override
  String get kegelPhaseSqueeze => 'SQUEEZE';

  @override
  String get kegelPhaseSqueezeInstr => 'Tense your muscles';

  @override
  String get kegelPhaseRelax => 'RELAX';

  @override
  String get kegelPhaseRelaxInstr => 'Exhale and relax';

  @override
  String get kegelPhaseDone => 'Great Job!';

  @override
  String get kegelPhaseDoneInstr => 'Workout completed';

  @override
  String kegelRepCounter(int current, int total) {
    return 'Rep $current of $total';
  }

  @override
  String get kegelStart => 'Start Training';

  @override
  String get kegelFinish => 'Finish';

  @override
  String get contractionTitle => 'Contractions';

  @override
  String get contractionInstruction => 'Press the button when contraction starts';

  @override
  String get contractionRelax => 'Rest and breathe deeply';

  @override
  String get contractionLabelActive => 'CONTRACTION';

  @override
  String get contractionLabelRest => 'REST';

  @override
  String get contractionBtnStart => 'Start';

  @override
  String get contractionBtnStop => 'Stop';

  @override
  String get contractionHistory => 'HISTORY';

  @override
  String get contractionColStart => 'Start';

  @override
  String get contractionColDuration => 'Duration';

  @override
  String get contractionColInterval => 'Freq';

  @override
  String get contractionEmpty => 'No records yet';

  @override
  String get checklistTitle => 'Hospital Bag';

  @override
  String checklistProgress(int percent) {
    return 'Packed $percent%';
  }

  @override
  String get checklistTabDocs => 'Documents';

  @override
  String get checklistTabMom => 'For Mom';

  @override
  String get checklistTabBaby => 'For Baby';

  @override
  String get checklistEmpty => 'Empty';

  @override
  String get checkDocPassport => 'Passport / ID';

  @override
  String get checkDocRecords => 'Pregnancy records';

  @override
  String get checkDocInsurance => 'Insurance';

  @override
  String get checkDocContract => 'Hospital contract';

  @override
  String get checkDocTests => 'Recent test results';

  @override
  String get checkMomSlippers => 'Washable slippers';

  @override
  String get checkMomWater => 'Water (2 bottles)';

  @override
  String get checkMomSocks => 'Warm socks / Compression';

  @override
  String get checkMomLipBalm => 'Lip balm';

  @override
  String get checkMomCharger => 'Phone & long charger';

  @override
  String get checkMomPads => 'Postpartum pads';

  @override
  String get checkMomUnderwear => 'Disposable underwear';

  @override
  String get checkMomBra => 'Nursing bra';

  @override
  String get checkMomCream => 'Nipple cream';

  @override
  String get checkMomHygiene => 'Toiletries (Brush, Soap)';

  @override
  String get checkBabyDiapers => 'Diapers (Newborn)';

  @override
  String get checkBabyWipes => 'Wet wipes (0+)';

  @override
  String get checkBabyCream => 'Diaper cream';

  @override
  String get checkBabyClothes => 'Onesies / Bodysuits (3-4)';

  @override
  String get checkBabyHat => 'Hat & socks';

  @override
  String get checkBabyOutfit => 'Going home outfit';

  @override
  String get weightTitle => 'Weight Control';

  @override
  String weightWeek(int week) {
    return 'Week $week';
  }

  @override
  String get weightInputHint => 'Enter weight to get analysis';

  @override
  String get weightNoParams => 'Fill in \'Pre-pregnancy weight\' in settings for smart analysis';

  @override
  String get weightUnit => 'kg';

  @override
  String get weightSave => 'Save Weight';

  @override
  String get weightFeedbackLow => 'Your weight gain is slightly below average. Remember to eat balanced meals.';

  @override
  String get weightFeedbackHigh => 'Your weight gain is slightly above average. Focus on healthy foods and hydration.';

  @override
  String get weightFeedbackNormal => 'Great job! Your weight gain is perfectly on track.';

  @override
  String get nameTitle => 'Search Settings';

  @override
  String get nameReset => 'Reset';

  @override
  String get nameGenderLabel => 'GENDER';

  @override
  String get nameGenderAny => 'Any';

  @override
  String get nameGenderBoy => 'Boy';

  @override
  String get nameGenderGirl => 'Girl';

  @override
  String get nameActionShow => 'Show Names';

  @override
  String get nameTabSearch => 'Search';

  @override
  String get nameTabFavorites => 'Favorites';

  @override
  String get nameEmptyTitle => 'No names found';

  @override
  String get nameEmptyBody => 'Try changing filters\nor selecting other countries';

  @override
  String get nameEmptyAction => 'Adjust Filters';

  @override
  String get nameFavEmpty => 'Favorites list is empty';

  @override
  String get countryRU => '🇷🇺 Russian';

  @override
  String get countryUS => '🇺🇸 American';

  @override
  String get countryTR => '🇹🇷 Turkish';

  @override
  String get countryKZ => '🇰🇿 Kazakh';

  @override
  String get countryUA => '🇺🇦 Ukrainian';

  @override
  String get countryPL => '🇵🇱 Polish';

  @override
  String get countryDE => '🇩🇪 German';

  @override
  String get countryFR => '🇫🇷 French';

  @override
  String get countryIT => '🇮🇹 Italian';

  @override
  String get countryES => '🇪🇸 Spanish';

  @override
  String get countryGB => '🇬🇧 British';

  @override
  String get countryCA => '🇨🇦 Canadian';

  @override
  String get countryBR => '🇧🇷 Brazilian';

  @override
  String get countryAE => '🇦🇪 Arabic (UAE)';

  @override
  String get countrySA => '🇸🇦 Arabic (Saudi)';

  @override
  String get countryEG => '🇪🇬 Egyptian';

  @override
  String get countryMA => '🇲🇦 Moroccan';

  @override
  String get countryNL => '🇳🇱 Dutch';

  @override
  String get countryCZ => '🇨🇿 Czech';

  @override
  String get countryRO => '🇷🇴 Romanian';

  @override
  String get countryAR => '🇦🇷 Argentine';

  @override
  String get countryMX => '🇲🇽 Mexican';

  @override
  String get countryJP => '🇯🇵 Japanese';

  @override
  String get countryCN => '🇨🇳 Chinese';

  @override
  String get countryKR => '🇰🇷 Korean';

  @override
  String get countryIN => '🇮🇳 Indian';

  @override
  String get countryIL => '🇮🇱 Hebrew';

  @override
  String get countryGR => '🇬🇷 Greek';

  @override
  String get countryIE => '🇮🇪 Irish';

  @override
  String get countryPT => '🇵🇹 Portuguese';

  @override
  String get countryAU => '🇦🇺 Australian';

  @override
  String get galleryTitle => 'Bump Gallery';

  @override
  String get gallerySubtitle => 'Save memories every week';

  @override
  String galleryWeek(int week) {
    return 'Week $week';
  }

  @override
  String get galleryCamera => 'Take a photo';

  @override
  String get galleryPick => 'Choose from gallery';

  @override
  String get galleryDeleteTitle => 'Delete photo?';

  @override
  String get galleryDeleteBody => 'This action cannot be undone.';

  @override
  String get todayForYouTitle => 'Today for You';

  @override
  String get todayForYouWeeklyNote => 'Weekly Note';

  @override
  String get diaryLoadError => 'Error loading diary';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Russian';

  @override
  String get startupErrorTitle => 'Bloom Mama could not start correctly.';

  @override
  String get todayFocusMorningEarlyTitle => 'A Gentle Start';

  @override
  String get todayFocusMorningEarlyBody => 'Begin the morning softly with water, a calm breakfast, and a little kindness toward yourself.';

  @override
  String get todayFocusMorningMidTitle => 'Rhythm and Support';

  @override
  String get todayFocusMorningMidBody => 'A steady rhythm will help today: small pauses, gentle movement, and calm breathing.';

  @override
  String get todayFocusMorningLateTitle => 'A Steady Morning';

  @override
  String get todayFocusMorningLateBody => 'The closer you get, the more a softer pace matters. Fewer rushes, more small pauses.';

  @override
  String get todayFocusDayEarlyTitle => 'Support Your Body';

  @override
  String get todayFocusDayEarlyBody => 'Choose one small act of care today: a snack, a glass of water, or five quiet minutes.';

  @override
  String get todayFocusDayMidTitle => 'A Soft Midday Pause';

  @override
  String get todayFocusDayMidBody => 'Take a short pause and notice how you feel. Even one small break can reset the whole day.';

  @override
  String get todayFocusDayLateTitle => 'Protect Your Energy';

  @override
  String get todayFocusDayLateBody => 'This is a good time to spend energy gently: less overload, more support, and a predictable pace.';

  @override
  String get todayFocusEveningEarlyTitle => 'A Quiet Evening';

  @override
  String get todayFocusEveningEarlyBody => 'Close the day gently: lower the noise, exhale, and let yourself settle into calm.';

  @override
  String get todayFocusEveningMidTitle => 'An Evening to Restore';

  @override
  String get todayFocusEveningMidBody => 'A warm shower, a comfortable position, and a quiet bedtime ritual can help the body release the day.';

  @override
  String get todayFocusEveningLateTitle => 'Slow Down Tonight';

  @override
  String get todayFocusEveningLateBody => 'At this stage, evenings matter even more. Let your surroundings tell your body it is safe to soften.';

  @override
  String get habitTrackerTitle => 'Daily Companion';

  @override
  String get habitTrackerQuestion => 'How are you feeling?';

  @override
  String get habitMoodTired => 'Tired';

  @override
  String get habitMoodGood => 'Good';

  @override
  String get habitMoodGreat => 'Great';

  @override
  String get habitWater => 'Water';

  @override
  String get habitWalk => 'Walk';

  @override
  String get habitVitamins => 'Vitamins';

  @override
  String get onboardingModeLmp => 'Calculate by period';

  @override
  String get onboardingModeEdd => 'I know the due date';

  @override
  String get onboardingLmpLabel => 'First day of last period';

  @override
  String get onboardingEddLabel => 'Expected due date';

  @override
  String onboardingCalculatedDate(String date) {
    return 'Estimated due date: $date';
  }

  @override
  String homeReturnToCurrent(int week) {
    return 'Back to week $week';
  }

  @override
  String get babyNameLabel => 'Baby Name';

  @override
  String get currentWeekLabel => 'Current Week';

  @override
  String get languageLabel => 'Language';

  @override
  String get saveButton => 'Save';

  @override
  String get weightLabel => 'WEIGHT';

  @override
  String get lengthLabel => 'LENGTH';

  @override
  String get mode => 'Visual Mode';

  @override
  String get fruit => 'Fruit';

  @override
  String get realistic => 'Realistic';

  @override
  String get labelWeight => 'WEIGHT';

  @override
  String get labelLength => 'LENGTH';

  @override
  String get errorNoImage => 'No Image';

  @override
  String get valLessThanOneGram => '< 1 g';

  @override
  String get valLessThanOneMm => '< 1 mm';

  @override
  String valGram(Object value) {
    return '$value g';
  }

  @override
  String valKg(Object value) {
    return '$value kg';
  }

  @override
  String valMm(Object value) {
    return '$value mm';
  }

  @override
  String valCm(Object value) {
    return '$value cm';
  }

  @override
  String get toolIsItNormal => 'Is It Normal?';

  @override
  String get toolIsItNormalSub => 'Symptom check';

  @override
  String get normalDisclaimer => 'This guide is for reference only. Always contact your doctor for professional advice.';

  @override
  String get normalSearchHint => 'Search symptoms (e.g. Headache)';

  @override
  String get statusCommon => 'Common';

  @override
  String get statusMonitor => 'Monitor';

  @override
  String get statusUrgent => 'Call Doc';

  @override
  String get actionContactDoctor => 'CONTACT DOCTOR';

  @override
  String get toolReport => 'Doctor Report';

  @override
  String get toolReportSub => 'PDF Export';

  @override
  String get settingsExportPdf => 'Export PDF Report';

  @override
  String get exporting => 'Generating PDF...';

  @override
  String get kickTabTimer => 'Timer';

  @override
  String get kickTabHistory => 'History';

  @override
  String get kickBtnStart => 'Start Session';

  @override
  String get kickHistoryEmpty => 'No history yet';

  @override
  String get weightChartTitle => 'Progress Chart';

  @override
  String get weightHistoryTitle => 'Recent History';

  @override
  String get weightChartEmpty => 'Add at least 2 records to see the chart';

  @override
  String get settingsThemeTitle => 'THEME';

  @override
  String get settingsThemeSerenity => 'Serenity';

  @override
  String get settingsThemeNature => 'Nature';

  @override
  String get settingsThemeWarmth => 'Warmth';

  @override
  String get settingsModeTitle => 'Visual Mode';

  @override
  String get settingsModeFruit => 'Fruit';

  @override
  String get settingsModeRealistic => 'Realistic';

  @override
  String get contractionBreathIn => 'Inhale...';

  @override
  String get contractionBreathOut => 'Exhale...';

  @override
  String get contractionAlertTitle => 'Time to call the hospital?';

  @override
  String get contractionAlertMessage => 'Hospital Rule (5-1-1) Met!';

  @override
  String get contractionTapToStop => 'Tap circle to stop';

  @override
  String get kegelSettingsTitle => 'Workout Settings';

  @override
  String get kegelSettingWork => 'Squeeze (sec)';

  @override
  String get kegelSettingRest => 'Relax (sec)';

  @override
  String get kegelSettingReps => 'Repetitions';

  @override
  String get kegelPaused => 'Paused';

  @override
  String get pdfReportTitle => 'Comprehensive Health Report';

  @override
  String get generatedDate => 'Generated';

  @override
  String get dateLabel => 'Date';

  @override
  String get weightUnitLabel => 'Weight (kg)';

  @override
  String get changeLabel => '+/-';

  @override
  String get durationLabel => 'Duration';

  @override
  String get kickCountLabel => 'Movements';

  @override
  String get symptomsTitle => 'Recent Symptoms';

  @override
  String get pdfDisclaimer => 'Disclaimer: This report is for tracking purposes only. Consult your doctor.';

  @override
  String get diaryTitle => 'Dear Baby...';

  @override
  String get diarySubtitle => 'Your letters and thoughts';

  @override
  String get diaryEmpty => 'You haven\'t written any notes yet. Tap on the weekly card to write a letter.';

  @override
  String get settingsLegalTitle => 'LEGAL & INFO';

  @override
  String get settingsDisclaimer => 'Medical Disclaimer';

  @override
  String get disclaimerTitle => 'Medical Disclaimer';

  @override
  String get disclaimerBody => 'This application is for informational purposes only and is not a substitute for professional medical advice, diagnosis, or treatment. \n\nAlways seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition. \n\nNever disregard professional medical advice or delay in seeking it because of something you have read in this application.';

  @override
  String get commonUnderstood => 'Understood';

  @override
  String get defaultMomName => 'Mom-to-be';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get errorGenericRetry => 'Something went wrong. Please try again.';

  @override
  String get errorPdfGeneration => 'Failed to generate PDF';

  @override
  String get errorDeleteData => 'Failed to delete data';

  @override
  String get errorOpenBrowser => 'Could not open browser';

  @override
  String get themeSerenity => 'Serenity';

  @override
  String get themeNature => 'Nature';

  @override
  String get themeWarmth => 'Warmth';

  @override
  String get settingsVisualMode => 'VISUAL MODE';

  @override
  String get visualModeFruit => 'Fruit';

  @override
  String get visualModeRealistic => 'Realistic';

  @override
  String get exportingPdf => 'Exporting...';

  @override
  String get laborModeTitle => 'LABOR MODE';

  @override
  String get laborTriggerButton => 'I\'M IN LABOR';

  @override
  String get laborMotivationalQuote => 'You got this, Mama! 💪';

  @override
  String get laborConfirmTitle => 'Baby is coming?';

  @override
  String get laborConfirmBody => 'This will switch the app to Labor Mode. We\'ll hide everything except the essentials: Contraction Timer and Hospital Checklist.';

  @override
  String get laborConfirmPartnerPhone => 'Partner\'s Mobile Number';

  @override
  String get laborConfirmNotifySwitch => 'Notify Partner via WhatsApp/SMS';

  @override
  String get laborConfirmStartBtn => 'YES, START LABOR MODE';

  @override
  String get laborConfirmFalseAlarm => 'False Alarm';

  @override
  String get laborExitTitle => 'End Labor Mode?';

  @override
  String get laborExitBody => 'Congratulations if the baby is here! Or was it a false alarm?';

  @override
  String get laborExitEndBtn => 'END MODE';

  @override
  String get laborEmergencyPrepTitle => 'EMERGENCY PREP';

  @override
  String get laborEmergencyPrepSubtitle => 'Fill this now to save time during contractions.';

  @override
  String get laborPartnerName => 'Partner\'s Name';

  @override
  String get laborPartnerPhone => 'Partner\'s Phone';

  @override
  String get laborDoctorPhone => 'Doctor\'s Phone';

  @override
  String get laborHospitalAddress => 'Hospital Address';

  @override
  String get laborHospitalBtn => 'HOSPITAL';

  @override
  String get laborDoctorBtn => 'DOCTOR';

  @override
  String get laborTimerContraction => 'CONTRACTION';

  @override
  String get laborTimerResting => 'RESTING';

  @override
  String get laborTimerBreathe => 'BREATHE';

  @override
  String get laborTimerStart => 'START';

  @override
  String get laborTimerReady => 'Ready for your first contraction';

  @override
  String get laborTimerMonitoring => 'Monitoring...';

  @override
  String get laborTimerLastDuration => 'LAST DURATION';

  @override
  String get laborTimerFrequency => 'FREQUENCY';

  @override
  String laborHelpMessage(String name) {
    return '🚨 $name, IT\'S TIME! \n\nThe contractions have started. I\'m switching to Labor Mode in the app. Please get ready! ❤️';
  }

  @override
  String get errorNoHospitalAddress => 'No hospital address set in Settings';

  @override
  String get errorNoDoctorPhone => 'No doctor phone set in Settings';

  @override
  String get commonMinutes => 'min';

  @override
  String get commonSeconds => 'sec';

  @override
  String get commonNext => 'NEXT';

  @override
  String get onboardingNameTitle => 'How should we call you?';

  @override
  String get jumpToWeek => 'JUMP TO WEEK';

  @override
  String get growthSectionTitle => 'How Baby Is Growing';

  @override
  String get growthSectionSubtitle => 'A smooth visual growth journey through pregnancy';

  @override
  String growthStage(int stage) {
    return 'Stage $stage';
  }

  @override
  String get weightPersonalizeTitle => 'Personalize Tracker';

  @override
  String get weightPersonalizeDesc => 'Tap to set your pre-pregnancy weight and height to get personalized insights.';

  @override
  String get weightHeightLabel => 'Height (cm)';

  @override
  String get weightPrePregnancyLabel => 'Pre-pregnancy Weight (kg)';

  @override
  String get weightTotalGain => 'Total Gain';

  @override
  String get weightRecommended => 'Recommended';

  @override
  String get pdfPatient => 'Patient: ';

  @override
  String get pdfDueDate => 'Due Date: ';

  @override
  String get pdfDueDateNotSet => 'Due Date: Not set';

  @override
  String get pdfReportDate => 'Report Date:';

  @override
  String get pdfHealthSummaryTitle => '30-Day Health Summary';

  @override
  String get pdfNoHealthData => 'No health data recorded in the last 30 days.';

  @override
  String get pdfColDate => 'Date';

  @override
  String get pdfColWeight => 'Weight';

  @override
  String get pdfColSymptoms => 'Symptoms';

  @override
  String get pdfColKicks => 'Kicks';

  @override
  String get pdfColWater => 'Water';

  @override
  String get pdfNone => 'None';

  @override
  String get pdfContractionsHistory => 'Contractions History';

  @override
  String get pdfNoContractions => 'No contractions recorded.';

  @override
  String get pdfFooter => 'Confidential Medical Report - Generated by Elpis Premium';

  @override
  String get paywallProTitle => 'Unlock Elpis PRO';

  @override
  String get paywallProSubtitle => 'Premium currently unlocks the kick counter, contraction timer, symptom guide, and bump gallery.';

  @override
  String get paywallFeatBabyTitle => 'Kick Counter';

  @override
  String get paywallFeatBabyDesc => 'Track movement sessions in one dedicated tool.';

  @override
  String get paywallFeatReportTitle => 'Contraction Timer';

  @override
  String get paywallFeatReportDesc => 'Time contractions and export a PDF summary for your doctor.';

  @override
  String get paywallFeatAnalyticsTitle => 'Symptom Guide';

  @override
  String get paywallFeatAnalyticsDesc => 'Open "Is it normal?" for quick symptom reference.';

  @override
  String get paywallFeatGalleryTitle => 'Bump Gallery';

  @override
  String get paywallFeatGalleryDesc => 'Keep weekly bump photos together as a visual timeline.';

  @override
  String get paywallMonth => 'MONTHLY';

  @override
  String get paywallYear => 'ANNUAL';

  @override
  String get paywallSaveBadge => 'BEST VALUE';

  @override
  String get paywallContinue => 'UNLOCK PRO';

  @override
  String get paywallTerms => 'Terms';

  @override
  String get paywallRestore => 'Restore';

  @override
  String get paywallError => 'Failed to unlock. Try again.';

  @override
  String get paywallTrialBadge => 'RECOMMENDED';

  @override
  String get paywallStartTrial => 'UNLOCK PRO';

  @override
  String get paywallCancelAnytime => 'Subscriptions can be managed in your store settings.';

  @override
  String get greetingNight => 'Good night 🌙';

  @override
  String get greetingMorning => 'Good morning ☀️';

  @override
  String get greetingAfternoon => 'Good afternoon 🌸';

  @override
  String get greetingEvening => 'Good evening 🌷';

  @override
  String get trimesterFirst => 'Trimester I';

  @override
  String get trimesterSecond => 'Trimester II';

  @override
  String get trimesterThird => 'Trimester III';

  @override
  String get letterStateDraft => 'Draft';

  @override
  String get letterStateSaving => 'Saving...';

  @override
  String get letterStateSaved => 'Saved';

  @override
  String get letterStateError => 'Not saved';

  @override
  String get insightBabyDevTitle => 'Baby Development';

  @override
  String get insightYourBodyTitle => 'Your Body';

  @override
  String get navHome => 'Home';

  @override
  String get navCare => 'Care';

  @override
  String get navDiary => 'Diary';

  @override
  String get phaseBeginning => 'Gentle Beginning';

  @override
  String get phaseGrowing => 'Growing Together';

  @override
  String get phaseAlmostTime => 'Almost Time To Meet';

  @override
  String get insightTagForYou => 'For You';

  @override
  String get insightTagFeelings => 'Feelings';

  @override
  String get insightTagTip => 'Gentle Tip';

  @override
  String get insightTagBaby => 'About Baby';

  @override
  String get weekNavLabel => 'Pregnancy Weeks';

  @override
  String get weekNavLaborMode => 'Labor Mode';

  @override
  String get weekNavGrowth => 'Growth';

  @override
  String get weekNavNow => 'now';

  @override
  String get snapshotStage => 'Stage';

  @override
  String get snapshotNow => 'Now';

  @override
  String get quickDiary => 'Diary';

  @override
  String get quickCare => 'Care';

  @override
  String get settingsNotificationsTitle => 'NOTIFICATIONS';

  @override
  String get settingsNotifyWeekly => 'Weekly Growth';

  @override
  String get settingsNotifyVitamins => 'Habit: Vitamins (09:00)';

  @override
  String get settingsNotifyWater => 'Habit: Water (18:00)';

  @override
  String get onboardingStep1Title2 => 'Welcome!';

  @override
  String get onboardingEddTitle => 'Expected Due Date';

  @override
  String get onboardingLmpTitle => 'First day of\nyour last period';

  @override
  String get onboardingEddSubtitle => 'Did your doctor give you a due date?';

  @override
  String get onboardingLmpSubtitle => 'We\'ll calculate your due date automatically';

  @override
  String get onboardingLanguagePrompt => 'Choose language';

  @override
  String get onboardingLanguageBody =>
      'Set your language now. You can change it later in Settings.';

  @override
  String get onboardingProfileBody =>
      'A few gentle details help us shape the journey around you.';

  @override
  String get onboardingDateBody =>
      'Choose the option you know best. We\'ll calculate the timeline for you.';

  @override
  String get onboardingReadyBody =>
      'Your space is ready. You can adjust names, reminders, and labor prep any time.';

  @override
  String get privacyUnavailable => 'Privacy policy has not been added to the app yet.';

  @override
  String get paywallOffersLoadError => 'Unable to load offers right now.';

  @override
  String get paywallProBadge => 'PRO';

  @override
  String get paywallMockTitle => 'Test PRO access';

  @override
  String get paywallMockBody =>
      'You are in a development build. Use the button below to simulate Premium and verify locked flows.';

  @override
  String get paywallMockCta => 'ENABLE TEST PRO';

  @override
  String reportGenerationError(Object error) {
    return 'Error generating report:\n$error';
  }

  @override
  String get pdfFilePrefix => 'Bloom_Report';

  @override
  String get pdfHealthFilePrefix => 'elpis_health_report';

  @override
  String get pdfFallbackPatientName => 'Patient';

  @override
  String pdfBmiValue(Object value) {
    return ' | BMI: $value';
  }

  @override
  String get laborHelpFallbackName => 'Honey';

  @override
  String get laborPartnerNameHint => 'e.g. Alex';

  @override
  String get laborPartnerPhoneHint => '+1 234 ...';

  @override
  String get laborDoctorPhoneHint => 'Emergency contact';

  @override
  String get laborHospitalAddressHint => 'Street, Building...';

  @override
  String get settingsOverviewTitle => 'Everything in one calm place';

  @override
  String get settingsOverviewBody =>
      'Update your names, due date, reminders, and emergency details without hunting through the app.';

  @override
  String get settingsProfileTitle => 'Profile';

  @override
  String get settingsProfileBody =>
      'Names and due date used across your journey.';

  @override
  String get settingsPreferencesTitle => 'App preferences';

  @override
  String get settingsPreferencesBody =>
      'Language, reminders, and the way your baby is shown.';

  @override
  String get settingsAccountTitle => 'Account';

  @override
  String get settingsAccountBody =>
      'Stay in guest mode or connect an account whenever you\'re ready.';

  @override
  String get settingsLaborPrepTitle => 'Labor & emergency prep';

  @override
  String get settingsLaborPrepBody =>
      'Keep important contacts ready and leave the labor shortcut visible only if you want it.';

  @override
  String get settingsDocsTitle => 'Reports & privacy';

  @override
  String get settingsDocsBody =>
      'Export a PDF, review the medical disclaimer, and check privacy information.';

  @override
  String get settingsDangerTitle => 'Danger zone';

  @override
  String get settingsDangerBody =>
      'Delete local data only if you truly want to start over.';

  @override
  String get settingsSaveChanges => 'Save changes';

  @override
  String get settingsChangesSaved => 'Changes saved';

  @override
  String get settingsSaveHelper =>
      'Toggles save instantly. Text fields save when you tap Save.';

  @override
  String get settingsShowLaborButton => 'Show labor shortcut on Home';

  @override
  String get settingsShowLaborButtonBody =>
      'Keep the emergency entry point visible when you want faster access.';

  @override
  String get todayForYouFootnote => 'You can come back to this gentle focus anytime today.';

  @override
  String get earlyWeek1Title => 'Cycle Start';

  @override
  String get earlyWeek1Description => 'Your body is preparing for a possible miracle.';

  @override
  String get earlyWeek2Title => 'Ovulation';

  @override
  String get earlyWeek2Description => 'The crucial moment for creating new life.';

  @override
  String get earlyWeek3Title => 'Conception';

  @override
  String get earlyWeek3Description => 'A tiny cell begins its big journey.';

  @override
  String get updatingData => 'Updating data';

  @override
  String get updatingDataSentence => 'Data updating.';

  @override
  String get weekDetailTakeCare => 'Take care of yourself.';

  @override
  String get weekDetailBabyActive => 'Baby is actively developing.';

  @override
  String get weekDetailBodyChanging => 'Your body continues to change.';

  @override
  String get weekDetailRest => 'Rest and listen to your body.';

  @override
  String get notificationBabyFallback => 'baby';

  @override
  String notificationWeeklyTitleNamed(Object name) {
    return '$name, happy new week! 🎉';
  }

  @override
  String get notificationWeeklyTitle => 'Happy new week! 🎉';

  @override
  String notificationWeeklyBody(Object week, Object baby) {
    return 'You are on week $week. Tap to see how $baby has grown.';
  }

  @override
  String notificationVitaminsTitleNamed(Object name) {
    return 'Good morning, $name! 💊';
  }

  @override
  String get notificationVitaminsTitle => 'Vitamin time ☀️';

  @override
  String get notificationVitaminsBody => 'Don\'t forget to take your vitamins.';

  @override
  String notificationWaterTitleNamed(Object name) {
    return '$name, hydration check! 💧';
  }

  @override
  String get notificationWaterTitle => 'Hydration check 💧';

  @override
  String get notificationWaterBody => 'Time to drink a glass of water!';

  @override
  String get insightWeek1FruitTitle => 'Invisible Pollen';

  @override
  String get insightWeek1FruitDescription => 'Your body is just preparing to create a miracle.';

  @override
  String get insightWeek1RealisticTitle => 'Blank Canvas';

  @override
  String get insightWeek1RealisticDescription => 'The beginning of a beautiful new story.';

  @override
  String get insightWeek1BabyDev => 'Physically, the baby doesn\'t exist yet. This is the start of your menstrual cycle, during which an egg matures.';

  @override
  String get insightWeek1MomBody => 'Your body is updating the uterine lining, creating the perfect \'soil\' for the future embryo to attach.';

  @override
  String get insightWeek1Tip => 'Start taking folic acid (400 mcg daily) and cut out any unhealthy habits.';

  @override
  String get insightWeek1Milestone => 'Start of the gestational clock';

  @override
  String get insightWeek1Insight1Title => 'Preparation';

  @override
  String get insightWeek1Insight1Content => 'Your body is starting a new cycle. Hormones are working to mature the perfect egg.';

  @override
  String get insightWeek1Insight2Title => 'Vitamins';

  @override
  String get insightWeek1Insight2Content => 'Vitamin B9 (folic acid) is crucial right now to prevent neural tube defects.';

  @override
  String get insightWeek1Insight3Title => 'Mindset';

  @override
  String get insightWeek1Insight3Content => 'Minimize stress. It\'s the perfect time for positive thoughts and planning.';

  @override
  String get insightWeek2FruitTitle => 'Tiny Spore';

  @override
  String get insightWeek2FruitDescription => 'Hidden potential for the birth of a new life.';

  @override
  String get insightWeek2RealisticTitle => 'A Spark';

  @override
  String get insightWeek2RealisticDescription => 'The moment when all the stars align.';

  @override
  String get insightWeek2BabyDev => 'Ovulation happens at the end of this week. The strongest egg will meet the sperm.';

  @override
  String get insightWeek2MomBody => 'Estrogen levels are rising. You might feel a slight twinge in your lower abdomen — a sign of ovulation.';

  @override
  String get insightWeek2Tip => 'The perfect time for romance and conception. Enjoy the process!';

  @override
  String get insightWeek2Milestone => 'Ovulation and fertilization';

  @override
  String get insightWeek2Insight1Title => 'Ovulation';

  @override
  String get insightWeek2Insight1Content => 'The egg leaves the ovary and travels into the fallopian tube to meet its destiny.';

  @override
  String get insightWeek2Insight2Title => 'Love';

  @override
  String get insightWeek2Insight2Content => 'Sperm can live in the female body for up to 5 days. It\'s time to act!';

  @override
  String get insightWeek2Insight3Title => 'Intuition';

  @override
  String get insightWeek2Insight3Content => 'Many women claim they intuitively feel the exact moment of conception.';

  @override
  String get insightWeek3FruitTitle => 'Vanilla Seed';

  @override
  String get insightWeek3FruitDescription => 'Less than a millimeter, but already an incredibly complex creation.';

  @override
  String get insightWeek3RealisticTitle => 'Grain of Sand';

  @override
  String get insightWeek3RealisticDescription => 'A golden speck that has found its perfect place.';

  @override
  String get insightWeek3BabyDev => 'The fertilized egg (zygote) is actively dividing and turns into a blastocyst as it travels to the uterus.';

  @override
  String get insightWeek3MomBody => 'The blastocyst implants itself into the uterine wall. You might notice light spotting.';

  @override
  String get insightWeek3Tip => 'Avoid heavy physical exertion, hot baths, and X-ray exposure.';

  @override
  String get insightWeek3Milestone => 'Embryo implantation';

  @override
  String get insightWeek3Insight1Title => 'The Journey';

  @override
  String get insightWeek3Insight1Content => 'The baby makes a 7-day journey down the fallopian tube into the uterus.';

  @override
  String get insightWeek3Insight2Title => 'Implantation';

  @override
  String get insightWeek3Insight2Content => 'Mild cramping and a few drops of blood are common signs of successful attachment.';

  @override
  String get insightWeek3Insight3Title => 'Take care';

  @override
  String get insightWeek3Insight3Content => 'Your body is putting all its energy into supporting new life. Rest up.';

  @override
  String get insightWeek4FruitTitle => 'Poppy Seed';

  @override
  String get insightWeek4FruitDescription => 'A tiny dot containing the entire universe of your future child.';

  @override
  String get insightWeek4RealisticTitle => 'Tiny Bead';

  @override
  String get insightWeek4RealisticDescription => 'A tiny but precious detail of the huge picture you are starting to paint.';

  @override
  String get insightWeek4GrowthTitle => '1–2 mm, <1 g';

  @override
  String get insightWeek4GrowthDescription => 'The size of a poppy seed. The embryo is forming.';

  @override
  String get insightWeek4BabyDev => 'The embryo consists of two layers (epiblast and hypoblast) from which all organs and tissues will develop.';

  @override
  String get insightWeek4MomBody => 'hCG hormone levels are high enough for a pregnancy test to show those two lines.';

  @override
  String get insightWeek4Tip => 'Schedule your first prenatal appointment for around week 7 or 8.';

  @override
  String get insightWeek4Milestone => 'Positive pregnancy test!';

  @override
  String get insightWeek4Insight1Title => 'Silent Miracle';

  @override
  String get insightWeek4Insight1Content => 'A revolution of cell division is happening inside.';

  @override
  String get insightWeek4Insight2Title => 'Vitamins';

  @override
  String get insightWeek4Insight2Content => 'Folic acid is the main building block right now.';

  @override
  String get insightWeek4Insight3Title => 'Caution';

  @override
  String get insightWeek4Insight3Content => 'Avoid overheating. Saunas are best postponed.';

  @override
  String get insightWeek5FruitTitle => 'Sesame Seed';

  @override
  String get insightWeek5FruitDescription => 'A small miracle opening doors to a huge world.';

  @override
  String get insightWeek5RealisticTitle => 'Pinhead';

  @override
  String get insightWeek5RealisticDescription => 'Hidden in this seed is the power of a whole garden.';

  @override
  String get insightWeek5GrowthTitle => '2–3 mm, <1 g';

  @override
  String get insightWeek5GrowthDescription => 'The size of a sesame seed. A tiny life inside you.';

  @override
  String get insightWeek5BabyDev => 'The neural tube (future brain and spinal cord) and a tiny heart are beginning to form.';

  @override
  String get insightWeek5MomBody => 'Your breasts may become tender. Early fatigue and frequent urination begin.';

  @override
  String get insightWeek5Tip => 'Cut out raw fish (sushi), rare meat, and unpasteurized cheeses from your diet.';

  @override
  String get insightWeek5Milestone => 'The heart starts beating';

  @override
  String get insightWeek5Insight1Title => 'Heartbeat';

  @override
  String get insightWeek5Insight1Content => 'A tiny engine starts working. It beats twice as fast as yours.';

  @override
  String get insightWeek5Insight2Title => 'Emotions';

  @override
  String get insightWeek5Insight2Content => 'Hormones are reshaping your world. Cry if you need to.';

  @override
  String get insightWeek5Insight3Title => 'Diet';

  @override
  String get insightWeek5Insight3Content => 'Avoid raw fish, soft cheeses, and alcohol.';

  @override
  String get insightWeek6FruitTitle => 'Sweet Pea';

  @override
  String get insightWeek6FruitDescription => 'Small and sweet. The baby is curled up.';

  @override
  String get insightWeek6RealisticTitle => 'Bright Bead';

  @override
  String get insightWeek6RealisticDescription => 'One day you will string such beads together.';

  @override
  String get insightWeek6GrowthTitle => '4–6 mm, <1 g';

  @override
  String get insightWeek6GrowthDescription => 'The size of a lentil. Rapid growth is underway.';

  @override
  String get insightWeek6BabyDev => 'Jaws, cheeks, and chin are forming, along with the beginnings of eyes and ears.';

  @override
  String get insightWeek6MomBody => 'Morning sickness may begin. Nausea is a faithful companion for many moms at this stage.';

  @override
  String get insightWeek6Tip => 'Keep crackers or dry toast by your bed. Eat a couple before getting up in the morning.';

  @override
  String get insightWeek6Milestone => 'Facial features begin to form';

  @override
  String get insightWeek6Insight1Title => 'Super Smell';

  @override
  String get insightWeek6Insight1Content => 'Your sense of smell sharpens acting as a detector.';

  @override
  String get insightWeek6Insight2Title => 'Fatigue';

  @override
  String get insightWeek6Insight2Content => 'Your body spends colossal energy. Napping is normal.';

  @override
  String get insightWeek6Insight3Title => 'Hydration';

  @override
  String get insightWeek6Insight3Content => 'Sip water frequently to help reduce nausea.';

  @override
  String get insightWeek7FruitTitle => 'Blueberry';

  @override
  String get insightWeek7FruitDescription => 'A dark berry. The brain is actively forming.';

  @override
  String get insightWeek7RealisticTitle => 'Glass Marble';

  @override
  String get insightWeek7RealisticDescription => 'Small and transparent. What allows him to feel this world is already forming.';

  @override
  String get insightWeek7GrowthTitle => '10–13 mm, <1 g';

  @override
  String get insightWeek7GrowthDescription => 'The size of a blueberry. Almost a centimeter!';

  @override
  String get insightWeek7BabyDev => 'About 100 new nerve cells are generated every minute! Arm and leg buds appear.';

  @override
  String get insightWeek7MomBody => 'Your uterus has grown to the size of a lemon. You might be running to the bathroom more often.';

  @override
  String get insightWeek7Tip => 'Have your first ultrasound to confirm the heartbeat and rule out ectopic pregnancy.';

  @override
  String get insightWeek7Milestone => 'Umbilical cord formation';

  @override
  String get insightWeek7Insight1Title => 'Morning Sickness';

  @override
  String get insightWeek7Insight1Content => 'Nausea can happen at night too. Eat crackers.';

  @override
  String get insightWeek7Insight2Title => 'Secret';

  @override
  String get insightWeek7Insight2Content => 'You carry a secret only you know. Enjoy this privacy.';

  @override
  String get insightWeek7Insight3Title => 'Restroom Runs';

  @override
  String get insightWeek7Insight3Content => 'The uterus grows and presses on the bladder.';

  @override
  String get insightWeek8FruitTitle => 'Raspberry';

  @override
  String get insightWeek8FruitDescription => 'A complex berry. First micro-movements begin.';

  @override
  String get insightWeek8RealisticTitle => 'Toy Brick';

  @override
  String get insightWeek8RealisticDescription => 'The first brick for building whole worlds.';

  @override
  String get insightWeek8GrowthTitle => '14–20 mm, ~1 g';

  @override
  String get insightWeek8GrowthDescription => 'The size of a raspberry. Crossing the 1g milestone.';

  @override
  String get insightWeek8BabyDev => 'The embryo loses its \'tail\'. Fingers and toes begin to take shape.';

  @override
  String get insightWeek8MomBody => 'Your blood volume increases by 40-50%. Your heart is working for two.';

  @override
  String get insightWeek8Tip => 'Buy a comfortable, wire-free bra — your breasts will continue to grow.';

  @override
  String get insightWeek8Milestone => 'First spontaneous movements';

  @override
  String get insightWeek8Insight1Title => 'Movement';

  @override
  String get insightWeek8Insight1Content => 'He is already moving, though you don\'t feel it yet.';

  @override
  String get insightWeek8Insight2Title => 'Cramping';

  @override
  String get insightWeek8Insight2Content => 'The uterus is the size of a grapefruit. Mild cramping is possible.';

  @override
  String get insightWeek8Insight3Title => 'Walks';

  @override
  String get insightWeek8Insight3Content => 'Fresh air is the best cure for fatigue.';

  @override
  String get insightWeek9FruitTitle => 'Green Olive';

  @override
  String get insightWeek9FruitDescription => 'Firm and strong. Muscles are strengthening.';

  @override
  String get insightWeek9RealisticTitle => 'AAA Battery';

  @override
  String get insightWeek9RealisticDescription => 'Juicy and full of life. The tail is gone.';

  @override
  String get insightWeek9GrowthTitle => '2–3 cm, ~2 g';

  @override
  String get insightWeek9GrowthDescription => 'The size of an olive. Proportions are changing.';

  @override
  String get insightWeek9BabyDev => 'Tiny muscles form. The baby begins to bend arms at the elbows and wrists.';

  @override
  String get insightWeek9MomBody => 'Your bump isn\'t visible yet, but your waist may thicken. Mood swings are common.';

  @override
  String get insightWeek9Tip => 'Don\'t forget calcium (dairy, spinach) — it\'s essential for your baby\'s bones.';

  @override
  String get insightWeek9Milestone => 'Status upgrade: Now a fetus!';

  @override
  String get insightWeek9Insight1Title => 'Muscles';

  @override
  String get insightWeek9Insight1Content => 'Tiny muscles develop; he learns to bend his arms.';

  @override
  String get insightWeek9Insight2Title => 'Dreams';

  @override
  String get insightWeek9Insight2Content => 'Dreams can become vivid. Subconscious is processing fears.';

  @override
  String get insightWeek9Insight3Title => 'Lingerie';

  @override
  String get insightWeek9Insight3Content => 'Time to find a comfortable bra.';

  @override
  String get insightWeek10FruitTitle => 'Kumquat';

  @override
  String get insightWeek10FruitDescription => 'Golden citrus. Vital organs are functioning.';

  @override
  String get insightWeek10RealisticTitle => 'Bottle Cap';

  @override
  String get insightWeek10RealisticDescription => 'A tough nut. His brain develops incredibly fast.';

  @override
  String get insightWeek10GrowthTitle => '3–4 cm, ~4 g';

  @override
  String get insightWeek10GrowthDescription => 'The size of a prune. Active mass gaining begins.';

  @override
  String get insightWeek10BabyDev => 'Kidneys begin to produce urine. The liver produces bile. Organs start functioning.';

  @override
  String get insightWeek10MomBody => 'Veins on your breasts and belly may become more noticeable due to increased blood flow.';

  @override
  String get insightWeek10Tip => 'Schedule your first genetic screening ultrasound (between 11-13 weeks).';

  @override
  String get insightWeek10Milestone => 'Organs start working';

  @override
  String get insightWeek10Insight1Title => 'Autonomy';

  @override
  String get insightWeek10Insight1Content => 'Kidneys, liver, and brain are functioning independently.';

  @override
  String get insightWeek10Insight2Title => 'Clothing';

  @override
  String get insightWeek10Insight2Content => 'Comfort is more important than fashion now.';

  @override
  String get insightWeek10Insight3Title => 'Mood Swings';

  @override
  String get insightWeek10Insight3Content => 'Euphoria to anxiety. Breathe deep.';

  @override
  String get insightWeek11FruitTitle => 'Fig';

  @override
  String get insightWeek11FruitDescription => 'Sweet fruit. Baby learns to open its mouth.';

  @override
  String get insightWeek11RealisticTitle => 'Golf Ball';

  @override
  String get insightWeek11RealisticDescription => 'Dense and bouncy. Soon he will start playing inside.';

  @override
  String get insightWeek11GrowthTitle => '4–5 cm, ~7 g';

  @override
  String get insightWeek11GrowthDescription => 'Reaching 5 cm long from crown to rump.';

  @override
  String get insightWeek11BabyDev => 'Fingers and toes have fully separated. Tooth buds and nail beds begin to form.';

  @override
  String get insightWeek11MomBody => 'Hair and nails may grow faster and stronger (a pregnancy bonus!).';

  @override
  String get insightWeek11Tip => 'Avoid infections. Wash your hands frequently and avoid crowded places.';

  @override
  String get insightWeek11Milestone => 'Tooth buds formation';

  @override
  String get insightWeek11Insight1Title => 'First Scan';

  @override
  String get insightWeek11Insight1Content => 'You will hear the most important rhythm — the heartbeat.';

  @override
  String get insightWeek11Insight2Title => 'Hair & Nails';

  @override
  String get insightWeek11Insight2Content => 'You may notice they grow faster.';

  @override
  String get insightWeek11Insight3Title => 'Snacks';

  @override
  String get insightWeek11Insight3Content => 'Carry nuts or an apple for hunger.';

  @override
  String get insightWeek12FruitTitle => 'Plum';

  @override
  String get insightWeek12FruitDescription => 'Smooth and juicy. Skeleton is hardening.';

  @override
  String get insightWeek12RealisticTitle => 'Pacifier';

  @override
  String get insightWeek12RealisticDescription => 'A symbol of calmness. One day it will help him sleep.';

  @override
  String get insightWeek12GrowthTitle => '5–6 cm, ~14 g';

  @override
  String get insightWeek12GrowthDescription => 'The size of an apricot. First trimester ends!';

  @override
  String get insightWeek12BabyDev => 'Reflexes improve: the baby can clench fists, frown, and suck their thumb.';

  @override
  String get insightWeek12MomBody => 'The top of your uterus rises above your pubic bone. Morning sickness often fades.';

  @override
  String get insightWeek12Tip => 'This is the perfect time to officially announce your pregnancy to family and friends!';

  @override
  String get insightWeek12Milestone => 'End of the first trimester';

  @override
  String get insightWeek12Insight1Title => 'Second Wind';

  @override
  String get insightWeek12Insight1Content => 'The placenta takes over. Energy returns.';

  @override
  String get insightWeek12Insight2Title => 'Realization';

  @override
  String get insightWeek12Insight2Content => 'The risk of loss drops sharply.';

  @override
  String get insightWeek12Insight3Title => 'Cream';

  @override
  String get insightWeek12Insight3Content => 'Start moisturizing your belly.';

  @override
  String get insightWeek13FruitTitle => 'Lemon';

  @override
  String get insightWeek13FruitDescription => 'Bright and sunny. Fingerprints are appearing.';

  @override
  String get insightWeek13RealisticTitle => 'Baby Soap';

  @override
  String get insightWeek13RealisticDescription => 'The scent of purity and a soft towel.';

  @override
  String get insightWeek13GrowthTitle => '7–8 cm, ~23 g';

  @override
  String get insightWeek13GrowthDescription => 'The size of a peach. Weighing over 20 grams.';

  @override
  String get insightWeek13BabyDev => 'Vocal cords form. Intestines move from the umbilical cord into the baby\'s abdomen.';

  @override
  String get insightWeek13MomBody => 'You are entering the \'golden period\' of pregnancy. You feel much better.';

  @override
  String get insightWeek13Tip => 'If you exercised before pregnancy, you can return to light workouts (yoga, swimming).';

  @override
  String get insightWeek13Milestone => 'Fingerprint formation';

  @override
  String get insightWeek13Insight1Title => 'Uniqueness';

  @override
  String get insightWeek13Insight1Content => 'Fingerprints have formed.';

  @override
  String get insightWeek13Insight2Title => 'Sharing News';

  @override
  String get insightWeek13Insight2Content => 'Many choose this time to tell friends.';

  @override
  String get insightWeek13Insight3Title => 'Ligaments';

  @override
  String get insightWeek13Insight3Content => 'Pain on the sides is normal — ligaments are stretching.';

  @override
  String get insightWeek14FruitTitle => 'Nectarine';

  @override
  String get insightWeek14FruitDescription => 'Rosy fruit. Baby learns facial expressions.';

  @override
  String get insightWeek14RealisticTitle => 'Christmas Bauble';

  @override
  String get insightWeek14RealisticDescription => 'A fragile miracle that makes the holiday special.';

  @override
  String get insightWeek14GrowthTitle => '8–9 cm, ~43 g';

  @override
  String get insightWeek14GrowthDescription => 'The size of a lemon. The second trimester is in full swing.';

  @override
  String get insightWeek14BabyDev => 'The baby practices facial expressions: frowning, squinting, and even swallowing.';

  @override
  String get insightWeek14MomBody => 'Your bump begins to round out. Your energy is at its peak right now.';

  @override
  String get insightWeek14Tip => 'Visit your dentist for a routine checkup. Gums are especially vulnerable now.';

  @override
  String get insightWeek14Milestone => 'Start of the second trimester';

  @override
  String get insightWeek14Insight1Title => 'Grimaces';

  @override
  String get insightWeek14Insight1Content => 'The baby learns to frown and smile.';

  @override
  String get insightWeek14Insight2Title => 'Golden Time';

  @override
  String get insightWeek14Insight2Content => 'The second trimester is the calmest.';

  @override
  String get insightWeek14Insight3Title => 'Dentist';

  @override
  String get insightWeek14Insight3Content => 'Best time to visit a doctor.';

  @override
  String get insightWeek15FruitTitle => 'Apple';

  @override
  String get insightWeek15FruitDescription => 'A ripe apple. Baby reacts to light.';

  @override
  String get insightWeek15RealisticTitle => 'Teacup';

  @override
  String get insightWeek15RealisticDescription => 'For warm cocoa. He can already hear your heartbeat from the inside.';

  @override
  String get insightWeek15GrowthTitle => '10–11 cm, ~70 g';

  @override
  String get insightWeek15GrowthDescription => 'The size of an apple. Over 10 cm in length!';

  @override
  String get insightWeek15BabyDev => 'Baby\'s skin is very thin, with visible blood vessels. Hearing begins to develop.';

  @override
  String get insightWeek15MomBody => 'You might experience a stuffy nose (\'pregnancy rhinitis\') due to increased blood volume.';

  @override
  String get insightWeek15Tip => 'Start sleeping on your side. Sleeping on your back can compress the vena cava.';

  @override
  String get insightWeek15Milestone => 'Hearing develops';

  @override
  String get insightWeek15Insight1Title => 'Hearing';

  @override
  String get insightWeek15Insight1Content => 'Ear bones have hardened.';

  @override
  String get insightWeek15Insight2Title => 'Immunity';

  @override
  String get insightWeek15Insight2Content => 'You may get \'pregnancy rhinitis\'.';

  @override
  String get insightWeek15Insight3Title => 'Communication';

  @override
  String get insightWeek15Insight3Content => 'Read aloud or sing.';

  @override
  String get insightWeek16FruitTitle => 'Avocado';

  @override
  String get insightWeek16FruitDescription => 'Nutritious and soft. Baby holds head up.';

  @override
  String get insightWeek16RealisticTitle => 'Rubber Duckie';

  @override
  String get insightWeek16RealisticDescription => 'Your future companion for fun baths.';

  @override
  String get insightWeek16GrowthTitle => '11–12 cm, ~100 g';

  @override
  String get insightWeek16GrowthDescription => 'The size of an avocado. The baby is now 100 grams!';

  @override
  String get insightWeek16BabyDev => 'Proportions align: legs are longer than arms. The heart pumps about 25 liters of blood a day.';

  @override
  String get insightWeek16MomBody => 'Some moms already feel the first light flutters of their baby at this stage.';

  @override
  String get insightWeek16Tip => 'Buy a U or C-shaped pregnancy pillow — it will save your sleep.';

  @override
  String get insightWeek16Milestone => 'Proportions become human';

  @override
  String get insightWeek16Insight1Title => 'Proportions';

  @override
  String get insightWeek16Insight1Content => 'Legs are now longer than arms.';

  @override
  String get insightWeek16Insight2Title => 'Pregnancy Brain';

  @override
  String get insightWeek16Insight2Content => 'Forgetful? Brain focuses on the main thing.';

  @override
  String get insightWeek16Insight3Title => 'Sleep';

  @override
  String get insightWeek16Insight3Content => 'Learn to sleep on your side.';

  @override
  String get insightWeek17FruitTitle => 'Pomegranate';

  @override
  String get insightWeek17FruitDescription => 'Full of treasures. Cartilage turning to bone.';

  @override
  String get insightWeek17RealisticTitle => 'Game Controller';

  @override
  String get insightWeek17RealisticDescription => 'He learns to control his body like in a game.';

  @override
  String get insightWeek17GrowthTitle => '13–14 cm, ~140 g';

  @override
  String get insightWeek17GrowthDescription => 'The size of a large onion. Bones are getting stronger.';

  @override
  String get insightWeek17BabyDev => 'Subcutaneous fat starts accumulating. Sweat glands are forming.';

  @override
  String get insightWeek17MomBody => 'Your belly changes your center of gravity. Lower back pain is possible.';

  @override
  String get insightWeek17Tip => 'Do some light stretching or prenatal yoga to relieve back spasms.';

  @override
  String get insightWeek17Milestone => 'Fat accumulation begins';

  @override
  String get insightWeek17Insight1Title => 'Bones';

  @override
  String get insightWeek17Insight1Content => 'Soft cartilage turns into hard bone.';

  @override
  String get insightWeek17Insight2Title => 'Umbilical Cord';

  @override
  String get insightWeek17Insight2Content => 'It becomes thicker and stronger.';

  @override
  String get insightWeek17Insight3Title => 'Shoes';

  @override
  String get insightWeek17Insight3Content => 'Ditch heels for stable shoes.';

  @override
  String get insightWeek18FruitTitle => 'Bell Pepper';

  @override
  String get insightWeek18FruitDescription => 'Voluminous and light. Nerves get protection.';

  @override
  String get insightWeek18RealisticTitle => 'Paper Plane';

  @override
  String get insightWeek18RealisticDescription => 'Dreams launched into flight.';

  @override
  String get insightWeek18GrowthTitle => '~14 cm, ~190 g';

  @override
  String get insightWeek18GrowthDescription => 'The size of a bell pepper. Rapidly putting on weight.';

  @override
  String get insightWeek18BabyDev => 'Nerves are coated in myelin (a protective sheath). Ears move to their final position.';

  @override
  String get insightWeek18MomBody => 'Many women clearly feel the baby\'s kicks this week.';

  @override
  String get insightWeek18Tip => 'Schedule your mid-pregnancy anatomy scan (weeks 18-21) to check organs in detail.';

  @override
  String get insightWeek18Milestone => 'First clear kicks';

  @override
  String get insightWeek18Insight1Title => 'First Kicks';

  @override
  String get insightWeek18Insight1Content => 'Like a butterfly wing. The first hellos.';

  @override
  String get insightWeek18Insight2Title => 'Dad';

  @override
  String get insightWeek18Insight2Content => 'Let him put his hand on your belly too.';

  @override
  String get insightWeek18Insight3Title => 'Ultrasound';

  @override
  String get insightWeek18Insight3Content => 'Scheduled scan soon.';

  @override
  String get insightWeek19FruitTitle => 'Mango';

  @override
  String get insightWeek19FruitDescription => 'Sweet and exotic. Vernix protects the skin.';

  @override
  String get insightWeek19RealisticTitle => 'Kids Sunglasses';

  @override
  String get insightWeek19RealisticDescription => 'Protection for the most curious eyes.';

  @override
  String get insightWeek19GrowthTitle => '~15 cm, ~240 g';

  @override
  String get insightWeek19GrowthDescription => 'The size of a mango. Fat tissue is accumulating.';

  @override
  String get insightWeek19BabyDev => 'The skin gets coated with vernix caseosa to prevent it from wrinkling in the amniotic fluid.';

  @override
  String get insightWeek19MomBody => 'You might notice dark spots or a dark line down your belly (linea nigra). It\'s temporary.';

  @override
  String get insightWeek19Tip => 'Wear sunscreen when going outside; your skin is prone to pigmentation right now.';

  @override
  String get insightWeek19Milestone => 'Vernix caseosa appears';

  @override
  String get insightWeek19Insight1Title => 'Vernix';

  @override
  String get insightWeek19Insight1Content => 'Skin is covered with a cheese-like coating.';

  @override
  String get insightWeek19Insight2Title => 'Hair';

  @override
  String get insightWeek19Insight2Content => 'First hairs appear on the head.';

  @override
  String get insightWeek19Insight3Title => 'Name';

  @override
  String get insightWeek19Insight3Content => 'Start making a list of names.';

  @override
  String get insightWeek20FruitTitle => 'Banana';

  @override
  String get insightWeek20FruitDescription => 'Long and curved. Equator! Halfway there.';

  @override
  String get insightWeek20RealisticTitle => 'Baby Bottle';

  @override
  String get insightWeek20RealisticDescription => 'A symbol of care. You are needed most.';

  @override
  String get insightWeek20GrowthTitle => '~25 cm, ~300 g';

  @override
  String get insightWeek20GrowthDescription => 'From this week, height is measured from crown to heel!';

  @override
  String get insightWeek20BabyDev => 'The baby starts swallowing amniotic fluid, practicing digestion and kidney function.';

  @override
  String get insightWeek20MomBody => 'Happy halfway point! Your uterus has reached the level of your belly button.';

  @override
  String get insightWeek20Tip => 'Check your iron levels. Your doctor may prescribe supplements if needed.';

  @override
  String get insightWeek20Milestone => 'Halfway mark!';

  @override
  String get insightWeek20Insight1Title => 'Equator';

  @override
  String get insightWeek20Insight1Content => 'The uterus has risen to the navel.';

  @override
  String get insightWeek20Insight2Title => 'Boy or Girl?';

  @override
  String get insightWeek20Insight2Content => 'Knowing gender can strengthen the bond.';

  @override
  String get insightWeek20Insight3Title => 'Iron';

  @override
  String get insightWeek20Insight3Content => 'Blood volume increased. Eat beef or buckwheat.';

  @override
  String get insightWeek21FruitTitle => 'Carrot';

  @override
  String get insightWeek21FruitDescription => 'Bright root vegetable. Baby trains digestion.';

  @override
  String get insightWeek21RealisticTitle => 'Pencil Case';

  @override
  String get insightWeek21RealisticDescription => 'First drawings and scribbles.';

  @override
  String get insightWeek21GrowthTitle => '~26 cm, ~360 g';

  @override
  String get insightWeek21GrowthDescription => 'The size of a carrot. Weight continues to soar.';

  @override
  String get insightWeek21BabyDev => 'Taste buds are formed. The taste of the fluid changes depending on what mom eats.';

  @override
  String get insightWeek21MomBody => 'Back strain can cause muscle spasms. Leg cramps at night are common.';

  @override
  String get insightWeek21Tip => 'Eat magnesium and potassium-rich foods (bananas, nuts) to avoid leg cramps.';

  @override
  String get insightWeek21Milestone => 'Baby tastes the food';

  @override
  String get insightWeek21Insight1Title => 'Tastes';

  @override
  String get insightWeek21Insight1Content => 'He swallows fluid and tastes your food.';

  @override
  String get insightWeek21Insight2Title => 'Dancing';

  @override
  String get insightWeek21Insight2Content => 'Kicks become strong.';

  @override
  String get insightWeek21Insight3Title => 'Varicose Veins';

  @override
  String get insightWeek21Insight3Content => 'Rest with legs raised.';

  @override
  String get insightWeek22FruitTitle => 'Papaya';

  @override
  String get insightWeek22FruitDescription => 'Soft tropical fruit. Baby explores itself.';

  @override
  String get insightWeek22RealisticTitle => 'Teddy Bear';

  @override
  String get insightWeek22RealisticDescription => 'The faithful friend for sleeping.';

  @override
  String get insightWeek22GrowthTitle => '~27 cm, ~430 g';

  @override
  String get insightWeek22GrowthDescription => 'Weighing nearly half a kilo! The size of a papaya.';

  @override
  String get insightWeek22BabyDev => 'Sense of touch improves. The baby touches their face, pulls the cord, and sucks their thumb.';

  @override
  String get insightWeek22MomBody => 'Your uterus continues to grow, stretching the skin. Your belly might itch.';

  @override
  String get insightWeek22Tip => 'If your belly itches, slather it with stretch mark oil or a moisturizing lotion.';

  @override
  String get insightWeek22Milestone => 'Sense of touch develops';

  @override
  String get insightWeek22Insight1Title => 'Touch';

  @override
  String get insightWeek22Insight1Content => 'He touches his face, legs, and cord.';

  @override
  String get insightWeek22Insight2Title => 'Photoshoot';

  @override
  String get insightWeek22Insight2Content => 'Perfect time for memory photos.';

  @override
  String get insightWeek22Insight3Title => 'Emotions';

  @override
  String get insightWeek22Insight3Content => 'He feels your mood.';

  @override
  String get insightWeek23FruitTitle => 'Grapefruit';

  @override
  String get insightWeek23FruitDescription => 'Large citrus. Baby hears external sounds.';

  @override
  String get insightWeek23RealisticTitle => 'First Sneaker';

  @override
  String get insightWeek23RealisticDescription => 'For those very first unsure steps.';

  @override
  String get insightWeek23GrowthTitle => '~28 cm, ~500 g';

  @override
  String get insightWeek23GrowthDescription => 'A major milestone: the baby reached 500 grams.';

  @override
  String get insightWeek23BabyDev => 'Lungs begin to produce surfactant — a substance that keeps air sacs from collapsing after birth.';

  @override
  String get insightWeek23MomBody => 'You might experience Braxton Hicks contractions (painless tightening of the belly).';

  @override
  String get insightWeek23Tip => 'Start doing Kegel exercises. They help avoid tearing during labor and speed up recovery.';

  @override
  String get insightWeek23Milestone => 'Surfactant production in lungs';

  @override
  String get insightWeek23Insight1Title => 'Training';

  @override
  String get insightWeek23Insight1Content => 'He \'inhales\' fluid, training lungs.';

  @override
  String get insightWeek23Insight2Title => 'Rhythm';

  @override
  String get insightWeek23Insight2Content => 'Baby moves to the beat of music.';

  @override
  String get insightWeek23Insight3Title => 'Water';

  @override
  String get insightWeek23Insight3Content => 'Swelling may worsen. Drink clean water.';

  @override
  String get insightWeek24FruitTitle => 'Ear of Corn';

  @override
  String get insightWeek24FruitDescription => 'Golden and ripe. Face is fully formed.';

  @override
  String get insightWeek24RealisticTitle => 'School Ruler';

  @override
  String get insightWeek24RealisticDescription => 'He grows and gathers strength.';

  @override
  String get insightWeek24GrowthTitle => '~30 cm, ~600 g';

  @override
  String get insightWeek24GrowthDescription => 'Length has reached 30 cm (size of corn).';

  @override
  String get insightWeek24BabyDev => 'The baby\'s face is formed: eyelashes, eyebrows, hair. The body is still quite thin.';

  @override
  String get insightWeek24MomBody => 'Your belly button might pop out. Uterine pressure can cause heartburn.';

  @override
  String get insightWeek24Tip => 'Between weeks 24 and 28, it\'s crucial to take the glucose tolerance test for gestational diabetes.';

  @override
  String get insightWeek24Milestone => 'Age of viability';

  @override
  String get insightWeek24Insight1Title => 'Viability';

  @override
  String get insightWeek24Insight1Content => 'Important milestone. Baby can survive outside.';

  @override
  String get insightWeek24Insight2Title => 'Face';

  @override
  String get insightWeek24Insight2Content => 'Eyelashes, brows, nose — all in place.';

  @override
  String get insightWeek24Insight3Title => 'Glucose Test';

  @override
  String get insightWeek24Insight3Content => 'Important to check sugar levels.';

  @override
  String get insightWeek25FruitTitle => 'Cauliflower';

  @override
  String get insightWeek25FruitDescription => 'Lush floret. Skin smooths out.';

  @override
  String get insightWeek25RealisticTitle => 'Baseball Glove';

  @override
  String get insightWeek25RealisticDescription => 'Being part of a team with mom and dad.';

  @override
  String get insightWeek25GrowthTitle => '~34 cm, ~660 g';

  @override
  String get insightWeek25GrowthDescription => 'Gaining mass quickly, skin is smoothing out.';

  @override
  String get insightWeek25BabyDev => 'Blood vessels form in the lungs. The baby gains fat, and the skin turns pink.';

  @override
  String get insightWeek25MomBody => 'Your hair looks amazing! It barely falls out thanks to high estrogen levels.';

  @override
  String get insightWeek25Tip => 'If you get restless leg syndrome before bed, have your iron (ferritin) checked.';

  @override
  String get insightWeek25Milestone => 'Fat accumulation';

  @override
  String get insightWeek25Insight1Title => 'Capillaries';

  @override
  String get insightWeek25Insight1Content => 'Skin turns pink.';

  @override
  String get insightWeek25Insight2Title => 'Hair';

  @override
  String get insightWeek25Insight2Content => 'Your hair becomes thick and shiny.';

  @override
  String get insightWeek25Insight3Title => 'Back';

  @override
  String get insightWeek25Insight3Content => 'Center of gravity shifted. Yoga helps.';

  @override
  String get insightWeek26FruitTitle => 'Zucchini';

  @override
  String get insightWeek26FruitDescription => 'Smooth and growing. Eyes open!';

  @override
  String get insightWeek26RealisticTitle => 'Folded Umbrella';

  @override
  String get insightWeek26RealisticDescription => 'Protection from weather and fun jumps.';

  @override
  String get insightWeek26GrowthTitle => '~35 cm, ~760 g';

  @override
  String get insightWeek26GrowthDescription => 'Surpassed 700 grams. The baby is getting rounder.';

  @override
  String get insightWeek26BabyDev => 'The baby opens their eyes for the first time! Irises are blue/grey; color will change later.';

  @override
  String get insightWeek26MomBody => 'The bump is growing fast. You might feel breathless even walking up short stairs.';

  @override
  String get insightWeek26Tip => 'It\'s time to start researching hospitals and doctors if you plan to hire a private team.';

  @override
  String get insightWeek26Milestone => 'Baby opens their eyes';

  @override
  String get insightWeek26Insight1Title => 'Eyes';

  @override
  String get insightWeek26Insight1Content => 'Eyelids open. He blinks.';

  @override
  String get insightWeek26Insight2Title => 'Communication';

  @override
  String get insightWeek26Insight2Content => 'He remembers voices.';

  @override
  String get insightWeek26Insight3Title => 'Rings';

  @override
  String get insightWeek26Insight3Content => 'Fingers may swell. Remove rings.';

  @override
  String get insightWeek27FruitTitle => 'Cabbage';

  @override
  String get insightWeek27FruitDescription => 'Many layers. Brain develops actively.';

  @override
  String get insightWeek27RealisticTitle => 'Lunchbox';

  @override
  String get insightWeek27RealisticDescription => 'Care you will pack for him to school.';

  @override
  String get insightWeek27GrowthTitle => '~36 cm, ~870 g';

  @override
  String get insightWeek27GrowthDescription => 'Approaching the 1 kilogram mark!';

  @override
  String get insightWeek27BabyDev => 'The brain gets its grooves. The baby dreams and might rhythmically hiccup.';

  @override
  String get insightWeek27MomBody => 'Welcome to the third trimester! The uterus pushes up against your ribcage.';

  @override
  String get insightWeek27Tip => 'Start learning breathing techniques for labor — it\'s your best natural pain relief.';

  @override
  String get insightWeek27Milestone => 'Start of the third trimester';

  @override
  String get insightWeek27Insight1Title => 'Home Stretch';

  @override
  String get insightWeek27Insight1Content => 'Welcome to the third trimester!';

  @override
  String get insightWeek27Insight2Title => 'Dreams';

  @override
  String get insightWeek27Insight2Content => 'Anxious dreams are normal rehearsal.';

  @override
  String get insightWeek27Insight3Title => 'Hiccups';

  @override
  String get insightWeek27Insight3Content => 'Rhythmic twitching? Baby is hiccuping.';

  @override
  String get insightWeek28FruitTitle => 'Eggplant';

  @override
  String get insightWeek28FruitDescription => 'Glossy and dark. Getting tight.';

  @override
  String get insightWeek28RealisticTitle => 'Drawing Tablet';

  @override
  String get insightWeek28RealisticDescription => 'A space for fantasy.';

  @override
  String get insightWeek28GrowthTitle => '~37 cm, ~1000 g';

  @override
  String get insightWeek28GrowthDescription => 'Hit 1 kilogram! A highly significant milestone.';

  @override
  String get insightWeek28BabyDev => 'Weight crosses 1 kilogram (2.2 lbs). Eyelashes appear. They distinguish light and shadows.';

  @override
  String get insightWeek28MomBody => 'Blood pressure might rise slightly. Your doctor will watch for protein in your urine.';

  @override
  String get insightWeek28Tip => 'Start counting kicks daily. Use the Kick Counter in our Care Center.';

  @override
  String get insightWeek28Milestone => 'Weight crosses 1 kilogram';

  @override
  String get insightWeek28Insight1Title => 'Weight';

  @override
  String get insightWeek28Insight1Content => 'Baby weighs over 1 kg.';

  @override
  String get insightWeek28Insight2Title => 'Rh Factor';

  @override
  String get insightWeek28Insight2Content => 'Doctor may prescribe immunoglobulin.';

  @override
  String get insightWeek28Insight3Title => 'Kick Counter';

  @override
  String get insightWeek28Insight3Content => 'Start tracking activity.';

  @override
  String get insightWeek29FruitTitle => 'Butternut Squash';

  @override
  String get insightWeek29FruitDescription => 'Firm and sweet. Heat regulation starts.';

  @override
  String get insightWeek29RealisticTitle => 'Ukulele';

  @override
  String get insightWeek29RealisticDescription => 'A small instrument for big songs.';

  @override
  String get insightWeek29GrowthTitle => '~38 cm, ~1150 g';

  @override
  String get insightWeek29GrowthDescription => 'Around 38 cm long. Space is getting tight.';

  @override
  String get insightWeek29BabyDev => 'The baby starts producing their own immunity. Bones get harder.';

  @override
  String get insightWeek29MomBody => 'The growing uterus can press on veins, causing hemorrhoids or varicose veins. Eat fiber.';

  @override
  String get insightWeek29Tip => 'Prepare a baby first-aid kit and a basic newborn care set.';

  @override
  String get insightWeek29Milestone => 'Thermoregulation starts';

  @override
  String get insightWeek29Insight1Title => 'Warmth';

  @override
  String get insightWeek29Insight1Content => 'Brain learns to regulate temperature.';

  @override
  String get insightWeek29Insight2Title => 'Calcium';

  @override
  String get insightWeek29Insight2Content => 'Baby takes calcium for bones.';

  @override
  String get insightWeek29Insight3Title => 'Fatigue';

  @override
  String get insightWeek29Insight3Content => 'Desire to nap returned?';

  @override
  String get insightWeek30FruitTitle => 'Cantaloupe';

  @override
  String get insightWeek30FruitDescription => 'Fragrant melon. Lanugo disappears.';

  @override
  String get insightWeek30RealisticTitle => 'Winter Hat';

  @override
  String get insightWeek30RealisticDescription => 'Warmth for long walks.';

  @override
  String get insightWeek30GrowthTitle => '~39 cm, ~1300 g';

  @override
  String get insightWeek30GrowthDescription => 'Weighs 1.3 kg (the size of a large cabbage).';

  @override
  String get insightWeek30BabyDev => 'The fine hair (lanugo) begins to shed. Skin gets smoother and lighter.';

  @override
  String get insightWeek30MomBody => 'Maternity leave is near! Back and leg fatigue by evening becomes the usual.';

  @override
  String get insightWeek30Tip => 'Time to pack your hospital bag. Go through the checklist in our app.';

  @override
  String get insightWeek30Milestone => 'Lanugo shedding';

  @override
  String get insightWeek30Insight1Title => 'Skin';

  @override
  String get insightWeek30Insight1Content => 'Body fuzz (lanugo) disappears.';

  @override
  String get insightWeek30Insight2Title => 'Nesting';

  @override
  String get insightWeek30Insight2Content => 'Urge to clean is an instinct.';

  @override
  String get insightWeek30Insight3Title => 'Shoes';

  @override
  String get insightWeek30Insight3Content => 'Feet might grow a size due to swelling.';

  @override
  String get insightWeek31FruitTitle => 'Pineapple';

  @override
  String get insightWeek31FruitDescription => 'Brain works at full capacity.';

  @override
  String get insightWeek31RealisticTitle => 'Soccer Ball';

  @override
  String get insightWeek31RealisticDescription => 'First goal and pride of a winner.';

  @override
  String get insightWeek31GrowthTitle => '~41 cm, ~1500 g';

  @override
  String get insightWeek31GrowthDescription => '1.5 kilograms! Active growth continues unabated.';

  @override
  String get insightWeek31BabyDev => 'Brain volume increases, neural connections form at lightning speed. They react to light and dark.';

  @override
  String get insightWeek31MomBody => 'Breasts begin producing colostrum (a yellowish fluid). Breathing is harder.';

  @override
  String get insightWeek31Tip => 'If you experience severe shortness of breath, try sleeping propped up on a few pillows.';

  @override
  String get insightWeek31Milestone => 'Brain development leap';

  @override
  String get insightWeek31Insight1Title => 'Brain';

  @override
  String get insightWeek31Insight1Content => 'Neural connections form at huge speed.';

  @override
  String get insightWeek31Insight2Title => 'Breathing';

  @override
  String get insightWeek31Insight2Content => 'Shortness of breath may occur.';

  @override
  String get insightWeek31Insight3Title => 'Colostrum';

  @override
  String get insightWeek31Insight3Content => 'Liquid may leak from breasts.';

  @override
  String get insightWeek32FruitTitle => 'Napa Cabbage';

  @override
  String get insightWeek32FruitDescription => 'Soft leaves. Baby turns head down.';

  @override
  String get insightWeek32RealisticTitle => 'Thick Storybook';

  @override
  String get insightWeek32RealisticDescription => 'Stories teaching kindness.';

  @override
  String get insightWeek32GrowthTitle => '~42 cm, ~1700 g';

  @override
  String get insightWeek32GrowthDescription => 'From crown to heel, length is about 42 cm.';

  @override
  String get insightWeek32BabyDev => 'Most babies settle into the starting position by now — head down.';

  @override
  String get insightWeek32MomBody => 'Circulation is slow. Foot swelling by the evening is your new normal.';

  @override
  String get insightWeek32Tip => 'If the baby is still breech, your doctor might recommend special exercises.';

  @override
  String get insightWeek32Milestone => 'Head-down position';

  @override
  String get insightWeek32Insight1Title => 'Position';

  @override
  String get insightWeek32Insight1Content => 'Most likely, he turned head down.';

  @override
  String get insightWeek32Insight2Title => 'Classes';

  @override
  String get insightWeek32Insight2Content => 'Learn breathing techniques.';

  @override
  String get insightWeek32Insight3Title => 'Visits';

  @override
  String get insightWeek32Insight3Content => 'Doctor visits become more frequent.';

  @override
  String get insightWeek33FruitTitle => 'Durian';

  @override
  String get insightWeek33FruitDescription => 'King of fruits. Immunity is strong.';

  @override
  String get insightWeek33RealisticTitle => 'Sleeping Bag';

  @override
  String get insightWeek33RealisticDescription => 'Camping and starry skies.';

  @override
  String get insightWeek33GrowthTitle => '~43 cm, ~1900 g';

  @override
  String get insightWeek33GrowthDescription => 'Nearly 2 kilograms. The size of a pineapple.';

  @override
  String get insightWeek33BabyDev => 'The baby receives your antibodies through the placenta. Bones are fully hardened, except the skull.';

  @override
  String get insightWeek33MomBody => 'Insomnia might peak. It\'s hard to find a comfy position with a huge belly.';

  @override
  String get insightWeek33Tip => 'Finish all major purchases. Wash and iron the baby clothes.';

  @override
  String get insightWeek33Milestone => 'Immune system ready';

  @override
  String get insightWeek33Insight1Title => 'Immunity';

  @override
  String get insightWeek33Insight1Content => 'You pass your antibodies to him.';

  @override
  String get insightWeek33Insight2Title => 'Hospital Bag';

  @override
  String get insightWeek33Insight2Content => 'Start packing.';

  @override
  String get insightWeek33Insight3Title => 'Heartburn';

  @override
  String get insightWeek33Insight3Content => 'Eat often but in small portions.';

  @override
  String get insightWeek34FruitTitle => 'Muscat Squash';

  @override
  String get insightWeek34FruitDescription => 'Ribbed squash. Lungs are ready.';

  @override
  String get insightWeek34RealisticTitle => 'Violin';

  @override
  String get insightWeek34RealisticDescription => 'A subtle soul and persistence.';

  @override
  String get insightWeek34GrowthTitle => '~45 cm, ~2100 g';

  @override
  String get insightWeek34GrowthDescription => 'The baby weighs over 2 kilograms!';

  @override
  String get insightWeek34BabyDev => 'Central nervous system is mature. Lungs have enough surfactant to breathe.';

  @override
  String get insightWeek34MomBody => 'Eyes might feel dry or vision slightly blurry. It will pass after birth.';

  @override
  String get insightWeek34Tip => 'Discuss your birth plan with your doctor: pain relief, interventions, and cord clamping.';

  @override
  String get insightWeek34Milestone => 'Lungs can breathe independently';

  @override
  String get insightWeek34Insight1Title => 'Lungs';

  @override
  String get insightWeek34Insight1Content => 'They are almost mature.';

  @override
  String get insightWeek34Insight2Title => 'Slow Down';

  @override
  String get insightWeek34Insight2Content => 'Allow yourself to be lazy.';

  @override
  String get insightWeek34Insight3Title => 'Vision';

  @override
  String get insightWeek34Insight3Content => 'Pupils react to light.';

  @override
  String get insightWeek35FruitTitle => 'Honeydew Melon';

  @override
  String get insightWeek35FruitDescription => 'Smooth and sweet. Rounding out.';

  @override
  String get insightWeek35RealisticTitle => 'Bicycle Helmet';

  @override
  String get insightWeek35RealisticDescription => 'Safety in first adventures.';

  @override
  String get insightWeek35GrowthTitle => '~46 cm, ~2300 g';

  @override
  String get insightWeek35GrowthDescription => 'Rapid mass gain—about 200 grams per week.';

  @override
  String get insightWeek35BabyDev => 'Gaining 200-300 grams a week. Arms and legs are getting chubby.';

  @override
  String get insightWeek35MomBody => 'Bladder is so squished that bathroom trips every 30 mins are not a joke.';

  @override
  String get insightWeek35Tip => 'Install the car seat. Adjusting straps with a crying newborn in your arms is tough.';

  @override
  String get insightWeek35Milestone => 'Active fat accumulation';

  @override
  String get insightWeek35Insight1Title => 'Chubby';

  @override
  String get insightWeek35Insight1Content => 'He gains 200-300 grams a week.';

  @override
  String get insightWeek35Insight2Title => 'Birth Plan';

  @override
  String get insightWeek35Insight2Content => 'Discuss your wishes with the doctor.';

  @override
  String get insightWeek35Insight3Title => 'Restroom';

  @override
  String get insightWeek35Insight3Content => 'Frequent runs? Baby presses on bladder.';

  @override
  String get insightWeek36FruitTitle => 'Romaine Lettuce';

  @override
  String get insightWeek36FruitDescription => 'Large and fresh. Belly drops.';

  @override
  String get insightWeek36RealisticTitle => 'Keyboard';

  @override
  String get insightWeek36RealisticDescription => 'First written stories or code.';

  @override
  String get insightWeek36GrowthTitle => '~47 cm, ~2600 g';

  @override
  String get insightWeek36GrowthDescription => 'Almost ready! Very plump and adorable.';

  @override
  String get insightWeek36BabyDev => 'Digestive system is fully ready for mom\'s milk. The skull remains soft.';

  @override
  String get insightWeek36MomBody => 'Your belly might \'drop\' as baby moves into the pelvis. Breathing gets easier, walking gets harder.';

  @override
  String get insightWeek36Tip => 'Ensure all documents (ID, medical records) are in your bag. From this week on, be ready.';

  @override
  String get insightWeek36Milestone => 'Belly dropping';

  @override
  String get insightWeek36Insight1Title => 'Dropping';

  @override
  String get insightWeek36Insight1Content => 'Breathing gets easier, walking harder.';

  @override
  String get insightWeek36Insight2Title => 'Skull Bones';

  @override
  String get insightWeek36Insight2Content => 'Skull remains soft for birth.';

  @override
  String get insightWeek36Insight3Title => 'CTG';

  @override
  String get insightWeek36Insight3Content => 'Weekly heartbeat checks.';

  @override
  String get insightWeek37FruitTitle => 'Beetroot';

  @override
  String get insightWeek37FruitDescription => 'Strong root. Fully ready for life.';

  @override
  String get insightWeek37RealisticTitle => 'Camera';

  @override
  String get insightWeek37RealisticDescription => 'Capturing the best moments.';

  @override
  String get insightWeek37GrowthTitle => '~48 cm, ~2800 g';

  @override
  String get insightWeek37GrowthDescription => 'Pregnancy is officially full term.';

  @override
  String get insightWeek37BabyDev => 'Pregnancy is officially full-term! All systems are ready for independent life.';

  @override
  String get insightWeek37MomBody => 'The mucus plug might pass. Practice contractions become more regular.';

  @override
  String get insightWeek37Tip => 'Remove nail polish or use clear gloss — doctors need to see your nail beds during labor.';

  @override
  String get insightWeek37Milestone => 'Full-term pregnancy';

  @override
  String get insightWeek37Insight1Title => 'Full Term';

  @override
  String get insightWeek37Insight1Content => 'Congrats! You can give birth anytime.';

  @override
  String get insightWeek37Insight2Title => 'Plug';

  @override
  String get insightWeek37Insight2Content => 'Loss of mucus plug is a sign.';

  @override
  String get insightWeek37Insight3Title => 'Logistics';

  @override
  String get insightWeek37Insight3Content => 'Check route to hospital.';

  @override
  String get insightWeek38FruitTitle => 'Leek';

  @override
  String get insightWeek38FruitDescription => 'Long stalk. Learning patience.';

  @override
  String get insightWeek38RealisticTitle => 'Skateboard';

  @override
  String get insightWeek38RealisticDescription => 'Courage to fall and get back up.';

  @override
  String get insightWeek38GrowthTitle => '~49 cm, ~3000 g';

  @override
  String get insightWeek38GrowthDescription => 'The crucial 3 kilogram milestone has been passed!';

  @override
  String get insightWeek38BabyDev => 'Intestines are filled with meconium (first stool). The head is deep in the pelvis.';

  @override
  String get insightWeek38MomBody => 'Hard to stand, lie down, or sit. The wait drives you crazy. \'Nesting\' cleaning bursts happen.';

  @override
  String get insightWeek38Tip => 'Rest in advance. Sleep as if it\'s your last week of sleep (it might well be).';

  @override
  String get insightWeek38Milestone => 'Meconium accumulation';

  @override
  String get insightWeek38Insight1Title => 'Contractions';

  @override
  String get insightWeek38Insight1Content => 'Braxton Hicks may get stronger.';

  @override
  String get insightWeek38Insight2Title => 'Waiting';

  @override
  String get insightWeek38Insight2Content => 'Turn off notifications about \'when?\'.';

  @override
  String get insightWeek38Insight3Title => 'Eye Color';

  @override
  String get insightWeek38Insight3Content => 'Most babies born with blue/gray eyes.';

  @override
  String get insightWeek39FruitTitle => 'Watermelon';

  @override
  String get insightWeek39FruitDescription => 'Heavy and ripe. Quieting down.';

  @override
  String get insightWeek39RealisticTitle => 'Globe';

  @override
  String get insightWeek39RealisticDescription => 'The whole world at his feet.';

  @override
  String get insightWeek39GrowthTitle => '~50 cm, ~3200 g';

  @override
  String get insightWeek39GrowthDescription => 'Half a meter long. Ideal proportions of a newborn.';

  @override
  String get insightWeek39BabyDev => 'No room to move. Kicks are replaced by poking out a bum or elbow.';

  @override
  String get insightWeek39MomBody => 'The cervix begins to efface (shorten) and soften, preparing to dilate.';

  @override
  String get insightWeek39Tip => 'Review signs of true labor: regular, intensifying contractions <5 mins apart, or water breaking.';

  @override
  String get insightWeek39Milestone => 'Cervix preparation';

  @override
  String get insightWeek39Insight1Title => 'Quiet';

  @override
  String get insightWeek39Insight1Content => 'Baby saves energy for birth.';

  @override
  String get insightWeek39Insight2Title => 'Rest';

  @override
  String get insightWeek39Insight2Content => 'Sleep, read, watch movies.';

  @override
  String get insightWeek39Insight3Title => 'Cervix';

  @override
  String get insightWeek39Insight3Content => 'Cervix is thinning and dilating.';

  @override
  String get insightWeek40FruitTitle => 'Pumpkin';

  @override
  String get insightWeek40FruitDescription => 'Festive and huge. Ready for D-Day.';

  @override
  String get insightWeek40RealisticTitle => 'First Onesie';

  @override
  String get insightWeek40RealisticDescription => 'Soon you will hug him for real.';

  @override
  String get insightWeek40GrowthTitle => '~51 cm, ~3400+ g';

  @override
  String get insightWeek40GrowthDescription => 'Average size of a fully developed newborn baby.';

  @override
  String get insightWeek40BabyDev => 'Weight can reach 3.5 kg or more. Fully formed and waiting for the signal to be born.';

  @override
  String get insightWeek40MomBody => 'Due date is here! If nothing is happening — don\'t panic. Only 5% of babies arrive exactly on their due date.';

  @override
  String get insightWeek40Tip => 'Launch our contraction timer. We\'ll tell you when to head to the hospital based on the 5-1-1 rule.';

  @override
  String get insightWeek40Milestone => 'Estimated Due Date (EDD)';

  @override
  String get insightWeek40Insight1Title => 'D-Day';

  @override
  String get insightWeek40Insight1Content => 'Due date is just a guide.';

  @override
  String get insightWeek40Insight2Title => 'Meeting';

  @override
  String get insightWeek40Insight2Content => 'Soon you\'ll look into his eyes.';

  @override
  String get insightWeek40Insight3Title => 'Water Breaking';

  @override
  String get insightWeek40Insight3Content => 'If water breaks — go to hospital.';

  @override
  String get insightWeek41FruitTitle => 'Ripe Melon';

  @override
  String get insightWeek41FruitDescription => 'Perfectly ripe. The wait drags on.';

  @override
  String get insightWeek41RealisticTitle => 'Packed Suitcase';

  @override
  String get insightWeek41RealisticDescription => 'Tickets in hand, luggage checked, but the flight is slightly delayed.';

  @override
  String get insightWeek41BabyDev => 'Continues to grow and gain weight. Skin might get a bit dry as vernix decreases.';

  @override
  String get insightWeek41MomBody => 'Waiting fatigue is at its peak. Doctor might suggest induction or close monitoring (NST & Ultrasound).';

  @override
  String get insightWeek41Tip => 'Try natural induction methods (after consulting your doctor): long walks, spicy food, or romance.';

  @override
  String get insightWeek41Milestone => 'Post-term pregnancy';

  @override
  String get insightWeek41Insight1Title => 'Stay Calm';

  @override
  String get insightWeek41Insight1Content => 'Many babies just aren\'t in a rush. Your job right now is to trust your doctors and relax.';

  @override
  String get insightWeek41Insight2Title => 'Induction';

  @override
  String get insightWeek41Insight2Content => 'Walking stairs and taking a warm shower can help gently jumpstart the process.';

  @override
  String get insightWeek41Insight3Title => 'Monitoring';

  @override
  String get insightWeek41Insight3Content => 'Doctors will check placental blood flow and amniotic fluid levels more frequently.';

  @override
  String get insightWeek42FruitTitle => 'Juicy Jackfruit';

  @override
  String get insightWeek42FruitDescription => 'The biggest and most anticipated. Time to meet.';

  @override
  String get insightWeek42RealisticTitle => 'Clock Hand';

  @override
  String get insightWeek42RealisticDescription => 'That crucial moment has finally arrived.';

  @override
  String get insightWeek42BabyDev => 'Nails are very long, head hair is thick. Absolutely no room left.';

  @override
  String get insightWeek42MomBody => 'This is the absolute limit. If labor hasn\'t started, you\'ll be admitted for medical induction.';

  @override
  String get insightWeek42Tip => 'Don\'t be upset if you need a medical induction. The most important thing is a healthy mom and baby.';

  @override
  String get insightWeek42Milestone => 'Hospital admission';

  @override
  String get insightWeek42Insight1Title => 'Induction';

  @override
  String get insightWeek42Insight1Content => 'Doctors will help your body start the process using medical methods.';

  @override
  String get insightWeek42Insight2Title => 'End of the Road';

  @override
  String get insightWeek42Insight2Content => 'This is your last week of pregnancy, 100%. The finish line is right here.';

  @override
  String get insightWeek42Insight3Title => 'Appearance';

  @override
  String get insightWeek42Insight3Content => 'Post-term babies are born without vernix or lanugo, with eyes wide open and very alert.';

  @override
  String get symptom1Title => 'Morning Sickness';

  @override
  String get symptom1ShortDescription => 'Nausea and vomiting, usually in early pregnancy.';

  @override
  String get symptom1FullDescription => 'Nausea is very common due to rising hormones (hCG). Usually fades by week 16. \n\nTips: Eat small meals, ginger tea, stay hydrated.';

  @override
  String get symptom2Title => 'Round Ligament Pain';

  @override
  String get symptom2ShortDescription => 'Sharp pain in lower belly or groin.';

  @override
  String get symptom2FullDescription => 'Sharp jabbing pain felt in the lower abdomen or groin area on one or both sides. Caused by the stretching of ligaments supporting the uterus.';

  @override
  String get symptom3Title => 'Bleeding / Spotting';

  @override
  String get symptom3ShortDescription => 'Any vaginal bleeding.';

  @override
  String get symptom3FullDescription => 'Light spotting can happen after sex or an exam, but bright red blood or heavy flow is NOT normal. \n\nAction: Call your doctor immediately.';

  @override
  String get symptom4Title => 'Swelling (Edema)';

  @override
  String get symptom4ShortDescription => 'Swollen feet and ankles.';

  @override
  String get symptom4FullDescription => 'Mild swelling is normal. However, sudden swelling in face or hands combined with headache could be Preeclampsia.';

  @override
  String get symptom5Title => 'Headaches';

  @override
  String get symptom5ShortDescription => 'Mild to severe head pain.';

  @override
  String get symptom5FullDescription => 'Common due to hormones/dehydration. \n\nWarning: Severe headache that won\'t go away could be a sign of high blood pressure.';

  @override
  String get symptom6Title => 'Braxton Hicks';

  @override
  String get symptom6ShortDescription => 'Practice contractions.';

  @override
  String get symptom6FullDescription => 'Irregular, non-painful tightening of the belly. They go away if you move or drink water. \n\nIf they become regular/painful -> Call doctor.';

  @override
  String get symptom7Title => 'Fatigue';

  @override
  String get symptom7ShortDescription => 'Extreme tiredness.';

  @override
  String get symptom7FullDescription => 'Very common due to hormonal changes and increased energy demands. Rest when possible.';

  @override
  String get symptom8Title => 'Breast Tenderness';

  @override
  String get symptom8ShortDescription => 'Sore or sensitive breasts.';

  @override
  String get symptom8FullDescription => 'Caused by rising hormones. Usually improves after the first trimester.';

  @override
  String get symptom9Title => 'Frequent Urination';

  @override
  String get symptom9ShortDescription => 'Needing to pee more often.';

  @override
  String get symptom9FullDescription => 'Pressure on the bladder and hormonal changes cause frequent urination. Normal unless painful.';

  @override
  String get symptom10Title => 'Constipation';

  @override
  String get symptom10ShortDescription => 'Difficulty passing stools.';

  @override
  String get symptom10FullDescription => 'Hormones slow digestion. Increase fiber, fluids, and gentle movement.';

  @override
  String get symptom11Title => 'Heartburn';

  @override
  String get symptom11ShortDescription => 'Burning sensation in chest or throat.';

  @override
  String get symptom11FullDescription => 'Caused by relaxed digestive muscles and pressure from the uterus.';

  @override
  String get symptom12Title => 'Shortness of Breath';

  @override
  String get symptom12ShortDescription => 'Feeling out of breath.';

  @override
  String get symptom12FullDescription => 'Mild breathlessness is normal. Sudden or severe shortness of breath needs medical attention.';

  @override
  String get symptom13Title => 'Lower Back Pain';

  @override
  String get symptom13ShortDescription => 'Aching lower back.';

  @override
  String get symptom13FullDescription => 'Caused by posture changes and extra weight. Gentle stretching may help.';

  @override
  String get symptom14Title => 'Leg Cramps';

  @override
  String get symptom14ShortDescription => 'Painful cramps, usually at night.';

  @override
  String get symptom14FullDescription => 'Common in later pregnancy. Stretching and hydration may reduce cramps.';

  @override
  String get symptom15Title => 'Dizziness';

  @override
  String get symptom15ShortDescription => 'Feeling lightheaded.';

  @override
  String get symptom15FullDescription => 'Often caused by low blood pressure or dehydration. Sit or lie down if dizzy.';

  @override
  String get symptom16Title => 'Nasal Congestion';

  @override
  String get symptom16ShortDescription => 'Stuffy or runny nose.';

  @override
  String get symptom16FullDescription => 'Pregnancy hormones increase blood flow to nasal passages. Normal and common.';

  @override
  String get symptom17Title => 'Mood Swings';

  @override
  String get symptom17ShortDescription => 'Rapid emotional changes.';

  @override
  String get symptom17FullDescription => 'Hormonal changes can affect mood. Support and rest are important.';

  @override
  String get symptom18Title => 'Increased Vaginal Discharge';

  @override
  String get symptom18ShortDescription => 'Thin, milky discharge.';

  @override
  String get symptom18FullDescription => 'Normal if odorless and not itchy. Helps prevent infections.';

  @override
  String get symptom19Title => 'Pelvic Pressure';

  @override
  String get symptom19ShortDescription => 'Feeling of heaviness in pelvis.';

  @override
  String get symptom19FullDescription => 'Common as baby grows. Sudden pressure with pain could indicate preterm labor.';

  @override
  String get symptom20Title => 'Itching';

  @override
  String get symptom20ShortDescription => 'Mild skin itching.';

  @override
  String get symptom20FullDescription => 'Stretching skin can itch. Severe itching (especially hands/feet) needs evaluation.';

  @override
  String get symptom21Title => 'Fever';

  @override
  String get symptom21ShortDescription => 'Elevated body temperature.';

  @override
  String get symptom21FullDescription => 'Fever during pregnancy is NOT normal. Contact a healthcare provider.';

  @override
  String get symptom22Title => 'Severe Abdominal Pain';

  @override
  String get symptom22ShortDescription => 'Intense belly pain.';

  @override
  String get symptom22FullDescription => 'Strong or persistent abdominal pain is NOT normal. Seek medical care.';

  @override
  String get symptom23Title => 'Reduced Baby Movements';

  @override
  String get symptom23ShortDescription => 'Baby moving less than usual.';

  @override
  String get symptom23FullDescription => 'A noticeable decrease in movements requires immediate medical attention.';

  @override
  String get authEntryTitle => 'Choose how you want to begin';

  @override
  String get authEntryBody => 'Use Apple or Google if you want your journey tied to an account, or continue without an account and keep everything gently on this device for now.';

  @override
  String get authEntryHint => 'You can stay in guest mode now and connect an account later from Settings without losing your local progress.';

  @override
  String get authGoogleContinue => 'Continue with Google';

  @override
  String get authAppleContinue => 'Continue with Apple';

  @override
  String get authGuestContinue => 'Continue without account';

  @override
  String get authSignInError => 'We couldn\'t complete sign in';

  @override
  String get authConflictTitle => 'Choose which data to keep';

  @override
  String get authConflictBody => 'We found saved data for this account on this device, and there is also progress in your current guest mode. Pick which version should stay with this account.';

  @override
  String get authConflictUseAccount => 'Keep account data';

  @override
  String get authConflictUseDevice => 'Keep this device data';

  @override
  String get authSettingsSectionTitle => 'ACCOUNT';

  @override
  String get authGuestModeTitle => 'Guest mode';

  @override
  String get authGuestModeBody => 'Everything stays on this device. Connect an account whenever you want a more stable long-term home for your journey.';

  @override
  String authSignedInTitle(String provider) {
    return 'Connected with $provider';
  }

  @override
  String get authSignedInSubtitle => 'Your local progress is attached to this account on this device.';

  @override
  String get authSwitchToGuestTitle => 'Switch to guest mode?';

  @override
  String get authSwitchToGuestBody => 'Your current account data will stay safely on this device. We will open a fresh guest space for you after sign out.';

  @override
  String get authSwitchToGuestAction => 'Switch to guest mode';

  @override
  String get authGoogleProvider => 'Google';

  @override
  String get authAppleProvider => 'Apple';

  @override
  String get authGuestProvider => 'Guest';
}
