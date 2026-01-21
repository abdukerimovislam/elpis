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
  String get pdfReportTitle => 'Bloom Mama Report';

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
}
