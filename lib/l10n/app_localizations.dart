import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Aura'**
  String get appName;

  /// No description provided for @weekLabel.
  ///
  /// In en, this message translates to:
  /// **'WEEK {week}'**
  String weekLabel(int week);

  /// No description provided for @menuHealth.
  ///
  /// In en, this message translates to:
  /// **'Health & Body'**
  String get menuHealth;

  /// No description provided for @menuFamily.
  ///
  /// In en, this message translates to:
  /// **'Family & Memory'**
  String get menuFamily;

  /// No description provided for @menuPrep.
  ///
  /// In en, this message translates to:
  /// **'Preparation'**
  String get menuPrep;

  /// No description provided for @tabConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get tabConnection;

  /// No description provided for @tabDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get tabDetails;

  /// No description provided for @connectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Letter to baby'**
  String get connectionTitle;

  /// No description provided for @connectionTitleNamed.
  ///
  /// In en, this message translates to:
  /// **'Letter for {name}'**
  String connectionTitleNamed(String name);

  /// No description provided for @connectionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Write something timeless...'**
  String get connectionPlaceholder;

  /// No description provided for @connectionSaveAction.
  ///
  /// In en, this message translates to:
  /// **'Save thought'**
  String get connectionSaveAction;

  /// No description provided for @connectionOpenDiary.
  ///
  /// In en, this message translates to:
  /// **'Open diary'**
  String get connectionOpenDiary;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'When is your miracle due?'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will personalize the journey for you'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingNameHint.
  ///
  /// In en, this message translates to:
  /// **'Baby\'s name (optional)'**
  String get onboardingNameHint;

  /// No description provided for @onboardingAction.
  ///
  /// In en, this message translates to:
  /// **'Start Journey'**
  String get onboardingAction;

  /// No description provided for @onboardingStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get onboardingStep1Title;

  /// No description provided for @onboardingStep1Sub.
  ///
  /// In en, this message translates to:
  /// **'Elpis is your gentle companion throughout your pregnancy'**
  String get onboardingStep1Sub;

  /// No description provided for @onboardingMomNameLabel.
  ///
  /// In en, this message translates to:
  /// **'YOUR NAME'**
  String get onboardingMomNameLabel;

  /// No description provided for @onboardingMomNameHint.
  ///
  /// In en, this message translates to:
  /// **'E.g. Emma or Sarah'**
  String get onboardingMomNameHint;

  /// No description provided for @onboardingBabyNameLabel.
  ///
  /// In en, this message translates to:
  /// **'BABY\'S NICKNAME (OPTIONAL)'**
  String get onboardingBabyNameLabel;

  /// No description provided for @onboardingBabyNameHint.
  ///
  /// In en, this message translates to:
  /// **'Peanut, Bean...'**
  String get onboardingBabyNameHint;

  /// No description provided for @onboardingStep2Title.
  ///
  /// In en, this message translates to:
  /// **'When is your baby due?'**
  String get onboardingStep2Title;

  /// No description provided for @onboardingByLmp.
  ///
  /// In en, this message translates to:
  /// **'By LMP'**
  String get onboardingByLmp;

  /// No description provided for @onboardingByEdd.
  ///
  /// In en, this message translates to:
  /// **'I know EDD'**
  String get onboardingByEdd;

  /// No description provided for @onboardingDueResult.
  ///
  /// In en, this message translates to:
  /// **'Due date: {date}'**
  String onboardingDueResult(String date);

  /// No description provided for @onboardingStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Almost there!'**
  String get onboardingStep3Title;

  /// No description provided for @onboardingStep3Sub.
  ///
  /// In en, this message translates to:
  /// **'Elpis is your personal pregnancy journal. We\'re with you every week.'**
  String get onboardingStep3Sub;

  /// No description provided for @onboardingDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical Disclaimer'**
  String get onboardingDisclaimerTitle;

  /// No description provided for @onboardingDisclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'This app provides informational content only and is not a substitute for professional medical advice. Always consult your doctor.'**
  String get onboardingDisclaimerBody;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onboardingContinue;

  /// No description provided for @onboardingBegin.
  ///
  /// In en, this message translates to:
  /// **'Begin Journey 🌸'**
  String get onboardingBegin;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'WHAT DO WE CALL THE BABY?'**
  String get settingsNameLabel;

  /// No description provided for @settingsNameHint.
  ///
  /// In en, this message translates to:
  /// **'E.g. Oliver or Bean'**
  String get settingsNameHint;

  /// No description provided for @settingsDateLabel.
  ///
  /// In en, this message translates to:
  /// **'DUE DATE'**
  String get settingsDateLabel;

  /// No description provided for @settingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSave;

  /// No description provided for @settingsDeleteData.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDeleteData;

  /// No description provided for @settingsDeleteDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This will delete all your photos, names and history. App will restart.'**
  String get settingsDeleteDataConfirm;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacy;

  /// No description provided for @loadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingTitle;

  /// No description provided for @loadingBody.
  ///
  /// In en, this message translates to:
  /// **'Getting data for this week.'**
  String get loadingBody;

  /// No description provided for @weekDefault.
  ///
  /// In en, this message translates to:
  /// **'Week {week}'**
  String weekDefault(Object week);

  /// No description provided for @waterTitle.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get waterTitle;

  /// No description provided for @waterFact.
  ///
  /// In en, this message translates to:
  /// **'Water helps renew amniotic fluid every 3 hours.'**
  String get waterFact;

  /// No description provided for @waterProgress.
  ///
  /// In en, this message translates to:
  /// **'of {goal}'**
  String waterProgress(int goal);

  /// No description provided for @visitNew.
  ///
  /// In en, this message translates to:
  /// **'New Visit'**
  String get visitNew;

  /// No description provided for @visitEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Visit'**
  String get visitEdit;

  /// No description provided for @visitSectionMain.
  ///
  /// In en, this message translates to:
  /// **'BASICS'**
  String get visitSectionMain;

  /// No description provided for @visitTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Title (e.g. Ultrasound)'**
  String get visitTitleHint;

  /// No description provided for @visitDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor / Clinic'**
  String get visitDoctor;

  /// No description provided for @visitQuestions.
  ///
  /// In en, this message translates to:
  /// **'YOUR QUESTIONS'**
  String get visitQuestions;

  /// No description provided for @visitQuestionsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'What to ask the doctor?\n- Can I fly?\n- Which vitamins to take?'**
  String get visitQuestionsPlaceholder;

  /// No description provided for @visitResults.
  ///
  /// In en, this message translates to:
  /// **'RESULTS'**
  String get visitResults;

  /// No description provided for @visitWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get visitWeight;

  /// No description provided for @visitBpSys.
  ///
  /// In en, this message translates to:
  /// **'Sys'**
  String get visitBpSys;

  /// No description provided for @visitBpDia.
  ///
  /// In en, this message translates to:
  /// **'Dia'**
  String get visitBpDia;

  /// No description provided for @visitNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s notes & prescription...'**
  String get visitNotesHint;

  /// No description provided for @visitCalendar.
  ///
  /// In en, this message translates to:
  /// **'Visits Calendar'**
  String get visitCalendar;

  /// No description provided for @visitEmpty.
  ///
  /// In en, this message translates to:
  /// **'No upcoming visits'**
  String get visitEmpty;

  /// No description provided for @visitFab.
  ///
  /// In en, this message translates to:
  /// **'Visit'**
  String get visitFab;

  /// No description provided for @visitBadgeQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get visitBadgeQuestions;

  /// No description provided for @visitBadgeResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get visitBadgeResults;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonMin.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get commonMin;

  /// No description provided for @commonSec.
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get commonSec;

  /// No description provided for @toolsTitle.
  ///
  /// In en, this message translates to:
  /// **'Care Center'**
  String get toolsTitle;

  /// No description provided for @toolsSectionDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get toolsSectionDaily;

  /// No description provided for @toolsSectionHealth.
  ///
  /// In en, this message translates to:
  /// **'Health & Labor'**
  String get toolsSectionHealth;

  /// No description provided for @toolsSectionFamily.
  ///
  /// In en, this message translates to:
  /// **'Family & Memories'**
  String get toolsSectionFamily;

  /// No description provided for @toolSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get toolSymptoms;

  /// No description provided for @toolSymptomsSub.
  ///
  /// In en, this message translates to:
  /// **'Symptoms log'**
  String get toolSymptomsSub;

  /// No description provided for @toolKegel.
  ///
  /// In en, this message translates to:
  /// **'Kegel'**
  String get toolKegel;

  /// No description provided for @toolKegelSub.
  ///
  /// In en, this message translates to:
  /// **'Pelvic floor'**
  String get toolKegelSub;

  /// No description provided for @toolNames.
  ///
  /// In en, this message translates to:
  /// **'Baby Names'**
  String get toolNames;

  /// No description provided for @toolNamesSub.
  ///
  /// In en, this message translates to:
  /// **'Swipe together'**
  String get toolNamesSub;

  /// No description provided for @toolContractions.
  ///
  /// In en, this message translates to:
  /// **'Contractions'**
  String get toolContractions;

  /// No description provided for @toolContractionsSub.
  ///
  /// In en, this message translates to:
  /// **'Labor timer'**
  String get toolContractionsSub;

  /// No description provided for @toolWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get toolWeight;

  /// No description provided for @toolWeightSub.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get toolWeightSub;

  /// No description provided for @toolWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get toolWater;

  /// No description provided for @toolWaterSub.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get toolWaterSub;

  /// No description provided for @toolKicks.
  ///
  /// In en, this message translates to:
  /// **'Kicks'**
  String get toolKicks;

  /// No description provided for @toolKicksSub.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get toolKicksSub;

  /// No description provided for @toolBag.
  ///
  /// In en, this message translates to:
  /// **'Hospital Bag'**
  String get toolBag;

  /// No description provided for @toolBagSub.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get toolBagSub;

  /// No description provided for @toolVisits.
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get toolVisits;

  /// No description provided for @toolVisitsSub.
  ///
  /// In en, this message translates to:
  /// **'Plan & Notes'**
  String get toolVisitsSub;

  /// No description provided for @toolGallery.
  ///
  /// In en, this message translates to:
  /// **'Bump Gallery'**
  String get toolGallery;

  /// No description provided for @toolGallerySub.
  ///
  /// In en, this message translates to:
  /// **'Bump timelapse'**
  String get toolGallerySub;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Bloom Premium'**
  String get paywallTitle;

  /// No description provided for @paywallSubtitleAndroid.
  ///
  /// In en, this message translates to:
  /// **'Premium features for Android are still in development.'**
  String get paywallSubtitleAndroid;

  /// No description provided for @paywallSubtitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Support development and unlock all features.'**
  String get paywallSubtitleDefault;

  /// No description provided for @paywallFeatureBackup.
  ///
  /// In en, this message translates to:
  /// **'Full cloud backup coming soon'**
  String get paywallFeatureBackup;

  /// No description provided for @paywallFeatureInsights.
  ///
  /// In en, this message translates to:
  /// **'Advanced health insights'**
  String get paywallFeatureInsights;

  /// No description provided for @paywallFeatureNoAds.
  ///
  /// In en, this message translates to:
  /// **'No ads'**
  String get paywallFeatureNoAds;

  /// No description provided for @paywallStatusTitleAndroid.
  ///
  /// In en, this message translates to:
  /// **'Android purchases are coming soon'**
  String get paywallStatusTitleAndroid;

  /// No description provided for @paywallStatusTitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get paywallStatusTitleDefault;

  /// No description provided for @paywallStatusBody.
  ///
  /// In en, this message translates to:
  /// **'We are working hard to bring Premium features to everyone.'**
  String get paywallStatusBody;

  /// No description provided for @symptomTitle.
  ///
  /// In en, this message translates to:
  /// **'How do you feel?'**
  String get symptomTitle;

  /// No description provided for @symptomMoodLabel.
  ///
  /// In en, this message translates to:
  /// **'MOOD'**
  String get symptomMoodLabel;

  /// No description provided for @symptomLabel.
  ///
  /// In en, this message translates to:
  /// **'SYMPTOMS'**
  String get symptomLabel;

  /// No description provided for @symptomSave.
  ///
  /// In en, this message translates to:
  /// **'Save Log'**
  String get symptomSave;

  /// No description provided for @symNausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get symNausea;

  /// No description provided for @symFatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get symFatigue;

  /// No description provided for @symHeartburn.
  ///
  /// In en, this message translates to:
  /// **'Heartburn'**
  String get symHeartburn;

  /// No description provided for @symSwelling.
  ///
  /// In en, this message translates to:
  /// **'Swelling'**
  String get symSwelling;

  /// No description provided for @symHeadache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get symHeadache;

  /// No description provided for @symInsomnia.
  ///
  /// In en, this message translates to:
  /// **'Insomnia'**
  String get symInsomnia;

  /// No description provided for @symBackPain.
  ///
  /// In en, this message translates to:
  /// **'Back pain'**
  String get symBackPain;

  /// No description provided for @symHunger.
  ///
  /// In en, this message translates to:
  /// **'Hunger'**
  String get symHunger;

  /// No description provided for @symBabyActive.
  ///
  /// In en, this message translates to:
  /// **'Baby active'**
  String get symBabyActive;

  /// No description provided for @symAnxiety.
  ///
  /// In en, this message translates to:
  /// **'Anxiety'**
  String get symAnxiety;

  /// No description provided for @kickTitle.
  ///
  /// In en, this message translates to:
  /// **'CONNECTION SESSION'**
  String get kickTitle;

  /// No description provided for @kickInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap on\nmovement'**
  String get kickInstruction;

  /// No description provided for @kickCount.
  ///
  /// In en, this message translates to:
  /// **'Movements: {count}'**
  String kickCount(int count);

  /// No description provided for @kickGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal: 10 movements'**
  String get kickGoal;

  /// No description provided for @kickSessionDone.
  ///
  /// In en, this message translates to:
  /// **'Session Completed'**
  String get kickSessionDone;

  /// No description provided for @kickDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Great Job!'**
  String get kickDialogTitle;

  /// No description provided for @kickDialogBody.
  ///
  /// In en, this message translates to:
  /// **'You counted {count} movements in {time}.'**
  String kickDialogBody(int count, String time);

  /// No description provided for @kegelTitle.
  ///
  /// In en, this message translates to:
  /// **'Kegel Training'**
  String get kegelTitle;

  /// No description provided for @kegelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Strengthening pelvic floor muscles prepares body for labor.'**
  String get kegelSubtitle;

  /// No description provided for @kegelPhaseSqueeze.
  ///
  /// In en, this message translates to:
  /// **'SQUEEZE'**
  String get kegelPhaseSqueeze;

  /// No description provided for @kegelPhaseSqueezeInstr.
  ///
  /// In en, this message translates to:
  /// **'Tense your muscles'**
  String get kegelPhaseSqueezeInstr;

  /// No description provided for @kegelPhaseRelax.
  ///
  /// In en, this message translates to:
  /// **'RELAX'**
  String get kegelPhaseRelax;

  /// No description provided for @kegelPhaseRelaxInstr.
  ///
  /// In en, this message translates to:
  /// **'Exhale and relax'**
  String get kegelPhaseRelaxInstr;

  /// No description provided for @kegelPhaseDone.
  ///
  /// In en, this message translates to:
  /// **'Great Job!'**
  String get kegelPhaseDone;

  /// No description provided for @kegelPhaseDoneInstr.
  ///
  /// In en, this message translates to:
  /// **'Workout completed'**
  String get kegelPhaseDoneInstr;

  /// No description provided for @kegelRepCounter.
  ///
  /// In en, this message translates to:
  /// **'Rep {current} of {total}'**
  String kegelRepCounter(int current, int total);

  /// No description provided for @kegelStart.
  ///
  /// In en, this message translates to:
  /// **'Start Training'**
  String get kegelStart;

  /// No description provided for @kegelFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get kegelFinish;

  /// No description provided for @contractionTitle.
  ///
  /// In en, this message translates to:
  /// **'Contractions'**
  String get contractionTitle;

  /// No description provided for @contractionInstruction.
  ///
  /// In en, this message translates to:
  /// **'Press the button when contraction starts'**
  String get contractionInstruction;

  /// No description provided for @contractionRelax.
  ///
  /// In en, this message translates to:
  /// **'Rest and breathe deeply'**
  String get contractionRelax;

  /// No description provided for @contractionLabelActive.
  ///
  /// In en, this message translates to:
  /// **'CONTRACTION'**
  String get contractionLabelActive;

  /// No description provided for @contractionLabelRest.
  ///
  /// In en, this message translates to:
  /// **'REST'**
  String get contractionLabelRest;

  /// No description provided for @contractionBtnStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get contractionBtnStart;

  /// No description provided for @contractionBtnStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get contractionBtnStop;

  /// No description provided for @contractionHistory.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get contractionHistory;

  /// No description provided for @contractionColStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get contractionColStart;

  /// No description provided for @contractionColDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get contractionColDuration;

  /// No description provided for @contractionColInterval.
  ///
  /// In en, this message translates to:
  /// **'Freq'**
  String get contractionColInterval;

  /// No description provided for @contractionEmpty.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get contractionEmpty;

  /// No description provided for @checklistTitle.
  ///
  /// In en, this message translates to:
  /// **'Hospital Bag'**
  String get checklistTitle;

  /// No description provided for @checklistProgress.
  ///
  /// In en, this message translates to:
  /// **'Packed {percent}%'**
  String checklistProgress(int percent);

  /// No description provided for @checklistTabDocs.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get checklistTabDocs;

  /// No description provided for @checklistTabMom.
  ///
  /// In en, this message translates to:
  /// **'For Mom'**
  String get checklistTabMom;

  /// No description provided for @checklistTabBaby.
  ///
  /// In en, this message translates to:
  /// **'For Baby'**
  String get checklistTabBaby;

  /// No description provided for @checklistEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get checklistEmpty;

  /// No description provided for @checkDocPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport / ID'**
  String get checkDocPassport;

  /// No description provided for @checkDocRecords.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy records'**
  String get checkDocRecords;

  /// No description provided for @checkDocInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get checkDocInsurance;

  /// No description provided for @checkDocContract.
  ///
  /// In en, this message translates to:
  /// **'Hospital contract'**
  String get checkDocContract;

  /// No description provided for @checkDocTests.
  ///
  /// In en, this message translates to:
  /// **'Recent test results'**
  String get checkDocTests;

  /// No description provided for @checkMomSlippers.
  ///
  /// In en, this message translates to:
  /// **'Washable slippers'**
  String get checkMomSlippers;

  /// No description provided for @checkMomWater.
  ///
  /// In en, this message translates to:
  /// **'Water (2 bottles)'**
  String get checkMomWater;

  /// No description provided for @checkMomSocks.
  ///
  /// In en, this message translates to:
  /// **'Warm socks / Compression'**
  String get checkMomSocks;

  /// No description provided for @checkMomLipBalm.
  ///
  /// In en, this message translates to:
  /// **'Lip balm'**
  String get checkMomLipBalm;

  /// No description provided for @checkMomCharger.
  ///
  /// In en, this message translates to:
  /// **'Phone & long charger'**
  String get checkMomCharger;

  /// No description provided for @checkMomPads.
  ///
  /// In en, this message translates to:
  /// **'Postpartum pads'**
  String get checkMomPads;

  /// No description provided for @checkMomUnderwear.
  ///
  /// In en, this message translates to:
  /// **'Disposable underwear'**
  String get checkMomUnderwear;

  /// No description provided for @checkMomBra.
  ///
  /// In en, this message translates to:
  /// **'Nursing bra'**
  String get checkMomBra;

  /// No description provided for @checkMomCream.
  ///
  /// In en, this message translates to:
  /// **'Nipple cream'**
  String get checkMomCream;

  /// No description provided for @checkMomHygiene.
  ///
  /// In en, this message translates to:
  /// **'Toiletries (Brush, Soap)'**
  String get checkMomHygiene;

  /// No description provided for @checkBabyDiapers.
  ///
  /// In en, this message translates to:
  /// **'Diapers (Newborn)'**
  String get checkBabyDiapers;

  /// No description provided for @checkBabyWipes.
  ///
  /// In en, this message translates to:
  /// **'Wet wipes (0+)'**
  String get checkBabyWipes;

  /// No description provided for @checkBabyCream.
  ///
  /// In en, this message translates to:
  /// **'Diaper cream'**
  String get checkBabyCream;

  /// No description provided for @checkBabyClothes.
  ///
  /// In en, this message translates to:
  /// **'Onesies / Bodysuits (3-4)'**
  String get checkBabyClothes;

  /// No description provided for @checkBabyHat.
  ///
  /// In en, this message translates to:
  /// **'Hat & socks'**
  String get checkBabyHat;

  /// No description provided for @checkBabyOutfit.
  ///
  /// In en, this message translates to:
  /// **'Going home outfit'**
  String get checkBabyOutfit;

  /// No description provided for @weightTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight Control'**
  String get weightTitle;

  /// No description provided for @weightWeek.
  ///
  /// In en, this message translates to:
  /// **'Week {week}'**
  String weightWeek(int week);

  /// No description provided for @weightInputHint.
  ///
  /// In en, this message translates to:
  /// **'Enter weight to get analysis'**
  String get weightInputHint;

  /// No description provided for @weightNoParams.
  ///
  /// In en, this message translates to:
  /// **'Fill in \'Pre-pregnancy weight\' in settings for smart analysis'**
  String get weightNoParams;

  /// No description provided for @weightUnit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get weightUnit;

  /// No description provided for @weightSave.
  ///
  /// In en, this message translates to:
  /// **'Save Weight'**
  String get weightSave;

  /// No description provided for @weightFeedbackLow.
  ///
  /// In en, this message translates to:
  /// **'Your weight gain is slightly below average. Remember to eat balanced meals.'**
  String get weightFeedbackLow;

  /// No description provided for @weightFeedbackHigh.
  ///
  /// In en, this message translates to:
  /// **'Your weight gain is slightly above average. Focus on healthy foods and hydration.'**
  String get weightFeedbackHigh;

  /// No description provided for @weightFeedbackNormal.
  ///
  /// In en, this message translates to:
  /// **'Great job! Your weight gain is perfectly on track.'**
  String get weightFeedbackNormal;

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Settings'**
  String get nameTitle;

  /// No description provided for @nameReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get nameReset;

  /// No description provided for @nameGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'GENDER'**
  String get nameGenderLabel;

  /// No description provided for @nameGenderAny.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get nameGenderAny;

  /// No description provided for @nameGenderBoy.
  ///
  /// In en, this message translates to:
  /// **'Boy'**
  String get nameGenderBoy;

  /// No description provided for @nameGenderGirl.
  ///
  /// In en, this message translates to:
  /// **'Girl'**
  String get nameGenderGirl;

  /// No description provided for @nameActionShow.
  ///
  /// In en, this message translates to:
  /// **'Show Names'**
  String get nameActionShow;

  /// No description provided for @nameTabSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get nameTabSearch;

  /// No description provided for @nameTabFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get nameTabFavorites;

  /// No description provided for @nameEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No names found'**
  String get nameEmptyTitle;

  /// No description provided for @nameEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Try changing filters\nor selecting other countries'**
  String get nameEmptyBody;

  /// No description provided for @nameEmptyAction.
  ///
  /// In en, this message translates to:
  /// **'Adjust Filters'**
  String get nameEmptyAction;

  /// No description provided for @nameFavEmpty.
  ///
  /// In en, this message translates to:
  /// **'Favorites list is empty'**
  String get nameFavEmpty;

  /// No description provided for @countryRU.
  ///
  /// In en, this message translates to:
  /// **'🇷🇺 Russian'**
  String get countryRU;

  /// No description provided for @countryUS.
  ///
  /// In en, this message translates to:
  /// **'🇺🇸 American'**
  String get countryUS;

  /// No description provided for @countryTR.
  ///
  /// In en, this message translates to:
  /// **'🇹🇷 Turkish'**
  String get countryTR;

  /// No description provided for @countryKZ.
  ///
  /// In en, this message translates to:
  /// **'🇰🇿 Kazakh'**
  String get countryKZ;

  /// No description provided for @countryUA.
  ///
  /// In en, this message translates to:
  /// **'🇺🇦 Ukrainian'**
  String get countryUA;

  /// No description provided for @countryPL.
  ///
  /// In en, this message translates to:
  /// **'🇵🇱 Polish'**
  String get countryPL;

  /// No description provided for @countryDE.
  ///
  /// In en, this message translates to:
  /// **'🇩🇪 German'**
  String get countryDE;

  /// No description provided for @countryFR.
  ///
  /// In en, this message translates to:
  /// **'🇫🇷 French'**
  String get countryFR;

  /// No description provided for @countryIT.
  ///
  /// In en, this message translates to:
  /// **'🇮🇹 Italian'**
  String get countryIT;

  /// No description provided for @countryES.
  ///
  /// In en, this message translates to:
  /// **'🇪🇸 Spanish'**
  String get countryES;

  /// No description provided for @countryGB.
  ///
  /// In en, this message translates to:
  /// **'🇬🇧 British'**
  String get countryGB;

  /// No description provided for @countryCA.
  ///
  /// In en, this message translates to:
  /// **'🇨🇦 Canadian'**
  String get countryCA;

  /// No description provided for @countryBR.
  ///
  /// In en, this message translates to:
  /// **'🇧🇷 Brazilian'**
  String get countryBR;

  /// No description provided for @countryAE.
  ///
  /// In en, this message translates to:
  /// **'🇦🇪 Arabic (UAE)'**
  String get countryAE;

  /// No description provided for @countrySA.
  ///
  /// In en, this message translates to:
  /// **'🇸🇦 Arabic (Saudi)'**
  String get countrySA;

  /// No description provided for @countryEG.
  ///
  /// In en, this message translates to:
  /// **'🇪🇬 Egyptian'**
  String get countryEG;

  /// No description provided for @countryMA.
  ///
  /// In en, this message translates to:
  /// **'🇲🇦 Moroccan'**
  String get countryMA;

  /// No description provided for @countryNL.
  ///
  /// In en, this message translates to:
  /// **'🇳🇱 Dutch'**
  String get countryNL;

  /// No description provided for @countryCZ.
  ///
  /// In en, this message translates to:
  /// **'🇨🇿 Czech'**
  String get countryCZ;

  /// No description provided for @countryRO.
  ///
  /// In en, this message translates to:
  /// **'🇷🇴 Romanian'**
  String get countryRO;

  /// No description provided for @countryAR.
  ///
  /// In en, this message translates to:
  /// **'🇦🇷 Argentine'**
  String get countryAR;

  /// No description provided for @countryMX.
  ///
  /// In en, this message translates to:
  /// **'🇲🇽 Mexican'**
  String get countryMX;

  /// No description provided for @countryJP.
  ///
  /// In en, this message translates to:
  /// **'🇯🇵 Japanese'**
  String get countryJP;

  /// No description provided for @countryCN.
  ///
  /// In en, this message translates to:
  /// **'🇨🇳 Chinese'**
  String get countryCN;

  /// No description provided for @countryKR.
  ///
  /// In en, this message translates to:
  /// **'🇰🇷 Korean'**
  String get countryKR;

  /// No description provided for @countryIN.
  ///
  /// In en, this message translates to:
  /// **'🇮🇳 Indian'**
  String get countryIN;

  /// No description provided for @countryIL.
  ///
  /// In en, this message translates to:
  /// **'🇮🇱 Hebrew'**
  String get countryIL;

  /// No description provided for @countryGR.
  ///
  /// In en, this message translates to:
  /// **'🇬🇷 Greek'**
  String get countryGR;

  /// No description provided for @countryIE.
  ///
  /// In en, this message translates to:
  /// **'🇮🇪 Irish'**
  String get countryIE;

  /// No description provided for @countryPT.
  ///
  /// In en, this message translates to:
  /// **'🇵🇹 Portuguese'**
  String get countryPT;

  /// No description provided for @countryAU.
  ///
  /// In en, this message translates to:
  /// **'🇦🇺 Australian'**
  String get countryAU;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Bump Gallery'**
  String get galleryTitle;

  /// No description provided for @gallerySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save memories every week'**
  String get gallerySubtitle;

  /// No description provided for @galleryWeek.
  ///
  /// In en, this message translates to:
  /// **'Week {week}'**
  String galleryWeek(int week);

  /// No description provided for @galleryCamera.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get galleryCamera;

  /// No description provided for @galleryPick.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get galleryPick;

  /// No description provided for @galleryDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete photo?'**
  String get galleryDeleteTitle;

  /// No description provided for @galleryDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get galleryDeleteBody;

  /// No description provided for @todayForYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Today for You'**
  String get todayForYouTitle;

  /// No description provided for @todayForYouWeeklyNote.
  ///
  /// In en, this message translates to:
  /// **'Weekly Note'**
  String get todayForYouWeeklyNote;

  /// No description provided for @diaryLoadError.
  ///
  /// In en, this message translates to:
  /// **'Error loading diary'**
  String get diaryLoadError;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @startupErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Bloom Mama could not start correctly.'**
  String get startupErrorTitle;

  /// No description provided for @todayFocusMorningEarlyTitle.
  ///
  /// In en, this message translates to:
  /// **'A Gentle Start'**
  String get todayFocusMorningEarlyTitle;

  /// No description provided for @todayFocusMorningEarlyBody.
  ///
  /// In en, this message translates to:
  /// **'Begin the morning softly with water, a calm breakfast, and a little kindness toward yourself.'**
  String get todayFocusMorningEarlyBody;

  /// No description provided for @todayFocusMorningMidTitle.
  ///
  /// In en, this message translates to:
  /// **'Rhythm and Support'**
  String get todayFocusMorningMidTitle;

  /// No description provided for @todayFocusMorningMidBody.
  ///
  /// In en, this message translates to:
  /// **'A steady rhythm will help today: small pauses, gentle movement, and calm breathing.'**
  String get todayFocusMorningMidBody;

  /// No description provided for @todayFocusMorningLateTitle.
  ///
  /// In en, this message translates to:
  /// **'A Steady Morning'**
  String get todayFocusMorningLateTitle;

  /// No description provided for @todayFocusMorningLateBody.
  ///
  /// In en, this message translates to:
  /// **'The closer you get, the more a softer pace matters. Fewer rushes, more small pauses.'**
  String get todayFocusMorningLateBody;

  /// No description provided for @todayFocusDayEarlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Your Body'**
  String get todayFocusDayEarlyTitle;

  /// No description provided for @todayFocusDayEarlyBody.
  ///
  /// In en, this message translates to:
  /// **'Choose one small act of care today: a snack, a glass of water, or five quiet minutes.'**
  String get todayFocusDayEarlyBody;

  /// No description provided for @todayFocusDayMidTitle.
  ///
  /// In en, this message translates to:
  /// **'A Soft Midday Pause'**
  String get todayFocusDayMidTitle;

  /// No description provided for @todayFocusDayMidBody.
  ///
  /// In en, this message translates to:
  /// **'Take a short pause and notice how you feel. Even one small break can reset the whole day.'**
  String get todayFocusDayMidBody;

  /// No description provided for @todayFocusDayLateTitle.
  ///
  /// In en, this message translates to:
  /// **'Protect Your Energy'**
  String get todayFocusDayLateTitle;

  /// No description provided for @todayFocusDayLateBody.
  ///
  /// In en, this message translates to:
  /// **'This is a good time to spend energy gently: less overload, more support, and a predictable pace.'**
  String get todayFocusDayLateBody;

  /// No description provided for @todayFocusEveningEarlyTitle.
  ///
  /// In en, this message translates to:
  /// **'A Quiet Evening'**
  String get todayFocusEveningEarlyTitle;

  /// No description provided for @todayFocusEveningEarlyBody.
  ///
  /// In en, this message translates to:
  /// **'Close the day gently: lower the noise, exhale, and let yourself settle into calm.'**
  String get todayFocusEveningEarlyBody;

  /// No description provided for @todayFocusEveningMidTitle.
  ///
  /// In en, this message translates to:
  /// **'An Evening to Restore'**
  String get todayFocusEveningMidTitle;

  /// No description provided for @todayFocusEveningMidBody.
  ///
  /// In en, this message translates to:
  /// **'A warm shower, a comfortable position, and a quiet bedtime ritual can help the body release the day.'**
  String get todayFocusEveningMidBody;

  /// No description provided for @todayFocusEveningLateTitle.
  ///
  /// In en, this message translates to:
  /// **'Slow Down Tonight'**
  String get todayFocusEveningLateTitle;

  /// No description provided for @todayFocusEveningLateBody.
  ///
  /// In en, this message translates to:
  /// **'At this stage, evenings matter even more. Let your surroundings tell your body it is safe to soften.'**
  String get todayFocusEveningLateBody;

  /// No description provided for @habitTrackerTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Companion'**
  String get habitTrackerTitle;

  /// No description provided for @habitTrackerQuestion.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get habitTrackerQuestion;

  /// No description provided for @habitMoodTired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get habitMoodTired;

  /// No description provided for @habitMoodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get habitMoodGood;

  /// No description provided for @habitMoodGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get habitMoodGreat;

  /// No description provided for @habitWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get habitWater;

  /// No description provided for @habitWalk.
  ///
  /// In en, this message translates to:
  /// **'Walk'**
  String get habitWalk;

  /// No description provided for @habitVitamins.
  ///
  /// In en, this message translates to:
  /// **'Vitamins'**
  String get habitVitamins;

  /// No description provided for @onboardingModeLmp.
  ///
  /// In en, this message translates to:
  /// **'Calculate by period'**
  String get onboardingModeLmp;

  /// No description provided for @onboardingModeEdd.
  ///
  /// In en, this message translates to:
  /// **'I know the due date'**
  String get onboardingModeEdd;

  /// No description provided for @onboardingLmpLabel.
  ///
  /// In en, this message translates to:
  /// **'First day of last period'**
  String get onboardingLmpLabel;

  /// No description provided for @onboardingEddLabel.
  ///
  /// In en, this message translates to:
  /// **'Expected due date'**
  String get onboardingEddLabel;

  /// No description provided for @onboardingCalculatedDate.
  ///
  /// In en, this message translates to:
  /// **'Estimated due date: {date}'**
  String onboardingCalculatedDate(String date);

  /// No description provided for @homeReturnToCurrent.
  ///
  /// In en, this message translates to:
  /// **'Back to week {week}'**
  String homeReturnToCurrent(int week);

  /// No description provided for @babyNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Baby Name'**
  String get babyNameLabel;

  /// No description provided for @currentWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Week'**
  String get currentWeekLabel;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT'**
  String get weightLabel;

  /// No description provided for @lengthLabel.
  ///
  /// In en, this message translates to:
  /// **'LENGTH'**
  String get lengthLabel;

  /// No description provided for @mode.
  ///
  /// In en, this message translates to:
  /// **'Visual Mode'**
  String get mode;

  /// No description provided for @fruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get fruit;

  /// No description provided for @realistic.
  ///
  /// In en, this message translates to:
  /// **'Realistic'**
  String get realistic;

  /// No description provided for @labelWeight.
  ///
  /// In en, this message translates to:
  /// **'WEIGHT'**
  String get labelWeight;

  /// No description provided for @labelLength.
  ///
  /// In en, this message translates to:
  /// **'LENGTH'**
  String get labelLength;

  /// No description provided for @errorNoImage.
  ///
  /// In en, this message translates to:
  /// **'No Image'**
  String get errorNoImage;

  /// No description provided for @valLessThanOneGram.
  ///
  /// In en, this message translates to:
  /// **'< 1 g'**
  String get valLessThanOneGram;

  /// No description provided for @valLessThanOneMm.
  ///
  /// In en, this message translates to:
  /// **'< 1 mm'**
  String get valLessThanOneMm;

  /// No description provided for @valGram.
  ///
  /// In en, this message translates to:
  /// **'{value} g'**
  String valGram(Object value);

  /// No description provided for @valKg.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String valKg(Object value);

  /// No description provided for @valMm.
  ///
  /// In en, this message translates to:
  /// **'{value} mm'**
  String valMm(Object value);

  /// No description provided for @valCm.
  ///
  /// In en, this message translates to:
  /// **'{value} cm'**
  String valCm(Object value);

  /// No description provided for @toolIsItNormal.
  ///
  /// In en, this message translates to:
  /// **'Is It Normal?'**
  String get toolIsItNormal;

  /// No description provided for @toolIsItNormalSub.
  ///
  /// In en, this message translates to:
  /// **'Symptom check'**
  String get toolIsItNormalSub;

  /// No description provided for @normalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This guide is for reference only. Always contact your doctor for professional advice.'**
  String get normalDisclaimer;

  /// No description provided for @normalSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search symptoms (e.g. Headache)'**
  String get normalSearchHint;

  /// No description provided for @statusCommon.
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get statusCommon;

  /// No description provided for @statusMonitor.
  ///
  /// In en, this message translates to:
  /// **'Monitor'**
  String get statusMonitor;

  /// No description provided for @statusUrgent.
  ///
  /// In en, this message translates to:
  /// **'Call Doc'**
  String get statusUrgent;

  /// No description provided for @actionContactDoctor.
  ///
  /// In en, this message translates to:
  /// **'CONTACT DOCTOR'**
  String get actionContactDoctor;

  /// No description provided for @toolReport.
  ///
  /// In en, this message translates to:
  /// **'Doctor Report'**
  String get toolReport;

  /// No description provided for @toolReportSub.
  ///
  /// In en, this message translates to:
  /// **'PDF Export'**
  String get toolReportSub;

  /// No description provided for @settingsExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF Report'**
  String get settingsExportPdf;

  /// No description provided for @exporting.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF...'**
  String get exporting;

  /// No description provided for @kickTabTimer.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get kickTabTimer;

  /// No description provided for @kickTabHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get kickTabHistory;

  /// No description provided for @kickBtnStart.
  ///
  /// In en, this message translates to:
  /// **'Start Session'**
  String get kickBtnStart;

  /// No description provided for @kickHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get kickHistoryEmpty;

  /// No description provided for @weightChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress Chart'**
  String get weightChartTitle;

  /// No description provided for @weightHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent History'**
  String get weightHistoryTitle;

  /// No description provided for @weightChartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add at least 2 records to see the chart'**
  String get weightChartEmpty;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'THEME'**
  String get settingsThemeTitle;

  /// No description provided for @settingsThemeSerenity.
  ///
  /// In en, this message translates to:
  /// **'Serenity'**
  String get settingsThemeSerenity;

  /// No description provided for @settingsThemeNature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get settingsThemeNature;

  /// No description provided for @settingsThemeWarmth.
  ///
  /// In en, this message translates to:
  /// **'Warmth'**
  String get settingsThemeWarmth;

  /// No description provided for @settingsModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Visual Mode'**
  String get settingsModeTitle;

  /// No description provided for @settingsModeFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get settingsModeFruit;

  /// No description provided for @settingsModeRealistic.
  ///
  /// In en, this message translates to:
  /// **'Realistic'**
  String get settingsModeRealistic;

  /// No description provided for @contractionBreathIn.
  ///
  /// In en, this message translates to:
  /// **'Inhale...'**
  String get contractionBreathIn;

  /// No description provided for @contractionBreathOut.
  ///
  /// In en, this message translates to:
  /// **'Exhale...'**
  String get contractionBreathOut;

  /// No description provided for @contractionAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Time to call the hospital?'**
  String get contractionAlertTitle;

  /// No description provided for @contractionAlertMessage.
  ///
  /// In en, this message translates to:
  /// **'Hospital Rule (5-1-1) Met!'**
  String get contractionAlertMessage;

  /// No description provided for @contractionTapToStop.
  ///
  /// In en, this message translates to:
  /// **'Tap circle to stop'**
  String get contractionTapToStop;

  /// No description provided for @kegelSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout Settings'**
  String get kegelSettingsTitle;

  /// No description provided for @kegelSettingWork.
  ///
  /// In en, this message translates to:
  /// **'Squeeze (sec)'**
  String get kegelSettingWork;

  /// No description provided for @kegelSettingRest.
  ///
  /// In en, this message translates to:
  /// **'Relax (sec)'**
  String get kegelSettingRest;

  /// No description provided for @kegelSettingReps.
  ///
  /// In en, this message translates to:
  /// **'Repetitions'**
  String get kegelSettingReps;

  /// No description provided for @kegelPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get kegelPaused;

  /// No description provided for @pdfReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive Health Report'**
  String get pdfReportTitle;

  /// No description provided for @generatedDate.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get generatedDate;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @weightUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightUnitLabel;

  /// No description provided for @changeLabel.
  ///
  /// In en, this message translates to:
  /// **'+/-'**
  String get changeLabel;

  /// No description provided for @durationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get durationLabel;

  /// No description provided for @kickCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Movements'**
  String get kickCountLabel;

  /// No description provided for @symptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Symptoms'**
  String get symptomsTitle;

  /// No description provided for @pdfDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer: This report is for tracking purposes only. Consult your doctor.'**
  String get pdfDisclaimer;

  /// No description provided for @diaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Dear Baby...'**
  String get diaryTitle;

  /// No description provided for @diarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your letters and thoughts'**
  String get diarySubtitle;

  /// No description provided for @diaryEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t written any notes yet. Tap on the weekly card to write a letter.'**
  String get diaryEmpty;

  /// No description provided for @settingsLegalTitle.
  ///
  /// In en, this message translates to:
  /// **'LEGAL & INFO'**
  String get settingsLegalTitle;

  /// No description provided for @settingsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Medical Disclaimer'**
  String get settingsDisclaimer;

  /// No description provided for @disclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Medical Disclaimer'**
  String get disclaimerTitle;

  /// No description provided for @disclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'This application is for informational purposes only and is not a substitute for professional medical advice, diagnosis, or treatment. \n\nAlways seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition. \n\nNever disregard professional medical advice or delay in seeking it because of something you have read in this application.'**
  String get disclaimerBody;

  /// No description provided for @commonUnderstood.
  ///
  /// In en, this message translates to:
  /// **'Understood'**
  String get commonUnderstood;

  /// No description provided for @defaultMomName.
  ///
  /// In en, this message translates to:
  /// **'Mom-to-be'**
  String get defaultMomName;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneric;

  /// No description provided for @errorGenericRetry.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGenericRetry;

  /// No description provided for @errorPdfGeneration.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate PDF'**
  String get errorPdfGeneration;

  /// No description provided for @errorDeleteData.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete data'**
  String get errorDeleteData;

  /// No description provided for @errorOpenBrowser.
  ///
  /// In en, this message translates to:
  /// **'Could not open browser'**
  String get errorOpenBrowser;

  /// No description provided for @themeSerenity.
  ///
  /// In en, this message translates to:
  /// **'Serenity'**
  String get themeSerenity;

  /// No description provided for @themeNature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get themeNature;

  /// No description provided for @themeWarmth.
  ///
  /// In en, this message translates to:
  /// **'Warmth'**
  String get themeWarmth;

  /// No description provided for @settingsVisualMode.
  ///
  /// In en, this message translates to:
  /// **'VISUAL MODE'**
  String get settingsVisualMode;

  /// No description provided for @visualModeFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get visualModeFruit;

  /// No description provided for @visualModeRealistic.
  ///
  /// In en, this message translates to:
  /// **'Realistic'**
  String get visualModeRealistic;

  /// No description provided for @exportingPdf.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exportingPdf;

  /// No description provided for @laborModeTitle.
  ///
  /// In en, this message translates to:
  /// **'LABOR MODE'**
  String get laborModeTitle;

  /// No description provided for @laborTriggerButton.
  ///
  /// In en, this message translates to:
  /// **'I\'M IN LABOR'**
  String get laborTriggerButton;

  /// No description provided for @laborMotivationalQuote.
  ///
  /// In en, this message translates to:
  /// **'You got this, Mama! 💪'**
  String get laborMotivationalQuote;

  /// No description provided for @laborConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Baby is coming?'**
  String get laborConfirmTitle;

  /// No description provided for @laborConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This will switch the app to Labor Mode. We\'ll hide everything except the essentials: Contraction Timer and Hospital Checklist.'**
  String get laborConfirmBody;

  /// No description provided for @laborConfirmPartnerPhone.
  ///
  /// In en, this message translates to:
  /// **'Partner\'s Mobile Number'**
  String get laborConfirmPartnerPhone;

  /// No description provided for @laborConfirmNotifySwitch.
  ///
  /// In en, this message translates to:
  /// **'Notify Partner via WhatsApp/SMS'**
  String get laborConfirmNotifySwitch;

  /// No description provided for @laborConfirmStartBtn.
  ///
  /// In en, this message translates to:
  /// **'YES, START LABOR MODE'**
  String get laborConfirmStartBtn;

  /// No description provided for @laborConfirmFalseAlarm.
  ///
  /// In en, this message translates to:
  /// **'False Alarm'**
  String get laborConfirmFalseAlarm;

  /// No description provided for @laborExitTitle.
  ///
  /// In en, this message translates to:
  /// **'End Labor Mode?'**
  String get laborExitTitle;

  /// No description provided for @laborExitBody.
  ///
  /// In en, this message translates to:
  /// **'Congratulations if the baby is here! Or was it a false alarm?'**
  String get laborExitBody;

  /// No description provided for @laborExitEndBtn.
  ///
  /// In en, this message translates to:
  /// **'END MODE'**
  String get laborExitEndBtn;

  /// No description provided for @laborEmergencyPrepTitle.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY PREP'**
  String get laborEmergencyPrepTitle;

  /// No description provided for @laborEmergencyPrepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill this now to save time during contractions.'**
  String get laborEmergencyPrepSubtitle;

  /// No description provided for @laborPartnerName.
  ///
  /// In en, this message translates to:
  /// **'Partner\'s Name'**
  String get laborPartnerName;

  /// No description provided for @laborPartnerPhone.
  ///
  /// In en, this message translates to:
  /// **'Partner\'s Phone'**
  String get laborPartnerPhone;

  /// No description provided for @laborDoctorPhone.
  ///
  /// In en, this message translates to:
  /// **'Doctor\'s Phone'**
  String get laborDoctorPhone;

  /// No description provided for @laborHospitalAddress.
  ///
  /// In en, this message translates to:
  /// **'Hospital Address'**
  String get laborHospitalAddress;

  /// No description provided for @laborHospitalBtn.
  ///
  /// In en, this message translates to:
  /// **'HOSPITAL'**
  String get laborHospitalBtn;

  /// No description provided for @laborDoctorBtn.
  ///
  /// In en, this message translates to:
  /// **'DOCTOR'**
  String get laborDoctorBtn;

  /// No description provided for @laborTimerContraction.
  ///
  /// In en, this message translates to:
  /// **'CONTRACTION'**
  String get laborTimerContraction;

  /// No description provided for @laborTimerResting.
  ///
  /// In en, this message translates to:
  /// **'RESTING'**
  String get laborTimerResting;

  /// No description provided for @laborTimerBreathe.
  ///
  /// In en, this message translates to:
  /// **'BREATHE'**
  String get laborTimerBreathe;

  /// No description provided for @laborTimerStart.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get laborTimerStart;

  /// No description provided for @laborTimerReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for your first contraction'**
  String get laborTimerReady;

  /// No description provided for @laborTimerMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Monitoring...'**
  String get laborTimerMonitoring;

  /// No description provided for @laborTimerLastDuration.
  ///
  /// In en, this message translates to:
  /// **'LAST DURATION'**
  String get laborTimerLastDuration;

  /// No description provided for @laborTimerFrequency.
  ///
  /// In en, this message translates to:
  /// **'FREQUENCY'**
  String get laborTimerFrequency;

  /// No description provided for @laborHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'🚨 {name}, IT\'S TIME! \n\nThe contractions have started. I\'m switching to Labor Mode in the app. Please get ready! ❤️'**
  String laborHelpMessage(String name);

  /// No description provided for @errorNoHospitalAddress.
  ///
  /// In en, this message translates to:
  /// **'No hospital address set in Settings'**
  String get errorNoHospitalAddress;

  /// No description provided for @errorNoDoctorPhone.
  ///
  /// In en, this message translates to:
  /// **'No doctor phone set in Settings'**
  String get errorNoDoctorPhone;

  /// No description provided for @commonMinutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get commonMinutes;

  /// No description provided for @commonSeconds.
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get commonSeconds;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get commonNext;

  /// No description provided for @onboardingNameTitle.
  ///
  /// In en, this message translates to:
  /// **'How should we call you?'**
  String get onboardingNameTitle;

  /// No description provided for @jumpToWeek.
  ///
  /// In en, this message translates to:
  /// **'JUMP TO WEEK'**
  String get jumpToWeek;

  /// No description provided for @growthSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'How Baby Is Growing'**
  String get growthSectionTitle;

  /// No description provided for @growthSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A smooth visual growth journey through pregnancy'**
  String get growthSectionSubtitle;

  /// No description provided for @growthStage.
  ///
  /// In en, this message translates to:
  /// **'Stage {stage}'**
  String growthStage(int stage);

  /// No description provided for @weightPersonalizeTitle.
  ///
  /// In en, this message translates to:
  /// **'Personalize Tracker'**
  String get weightPersonalizeTitle;

  /// No description provided for @weightPersonalizeDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap to set your pre-pregnancy weight and height to get personalized insights.'**
  String get weightPersonalizeDesc;

  /// No description provided for @weightHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get weightHeightLabel;

  /// No description provided for @weightPrePregnancyLabel.
  ///
  /// In en, this message translates to:
  /// **'Pre-pregnancy Weight (kg)'**
  String get weightPrePregnancyLabel;

  /// No description provided for @weightTotalGain.
  ///
  /// In en, this message translates to:
  /// **'Total Gain'**
  String get weightTotalGain;

  /// No description provided for @weightRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get weightRecommended;

  /// No description provided for @pdfPatient.
  ///
  /// In en, this message translates to:
  /// **'Patient: '**
  String get pdfPatient;

  /// No description provided for @pdfDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date: '**
  String get pdfDueDate;

  /// No description provided for @pdfDueDateNotSet.
  ///
  /// In en, this message translates to:
  /// **'Due Date: Not set'**
  String get pdfDueDateNotSet;

  /// No description provided for @pdfReportDate.
  ///
  /// In en, this message translates to:
  /// **'Report Date:'**
  String get pdfReportDate;

  /// No description provided for @pdfHealthSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'30-Day Health Summary'**
  String get pdfHealthSummaryTitle;

  /// No description provided for @pdfNoHealthData.
  ///
  /// In en, this message translates to:
  /// **'No health data recorded in the last 30 days.'**
  String get pdfNoHealthData;

  /// No description provided for @pdfColDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get pdfColDate;

  /// No description provided for @pdfColWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get pdfColWeight;

  /// No description provided for @pdfColSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get pdfColSymptoms;

  /// No description provided for @pdfColKicks.
  ///
  /// In en, this message translates to:
  /// **'Kicks'**
  String get pdfColKicks;

  /// No description provided for @pdfColWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get pdfColWater;

  /// No description provided for @pdfNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get pdfNone;

  /// No description provided for @pdfContractionsHistory.
  ///
  /// In en, this message translates to:
  /// **'Contractions History'**
  String get pdfContractionsHistory;

  /// No description provided for @pdfNoContractions.
  ///
  /// In en, this message translates to:
  /// **'No contractions recorded.'**
  String get pdfNoContractions;

  /// No description provided for @pdfFooter.
  ///
  /// In en, this message translates to:
  /// **'Confidential Medical Report - Generated by Elpis Premium'**
  String get pdfFooter;

  /// No description provided for @paywallProTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Elpis PRO'**
  String get paywallProTitle;

  /// No description provided for @paywallProSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Give yourself peace of mind. Unlock all premium features for a healthy, stress-free pregnancy.'**
  String get paywallProSubtitle;

  /// No description provided for @paywallFeatBabyTitle.
  ///
  /// In en, this message translates to:
  /// **'3D Realistic Baby'**
  String get paywallFeatBabyTitle;

  /// No description provided for @paywallFeatBabyDesc.
  ///
  /// In en, this message translates to:
  /// **'Watch development in real-time'**
  String get paywallFeatBabyDesc;

  /// No description provided for @paywallFeatReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor Reports'**
  String get paywallFeatReportTitle;

  /// No description provided for @paywallFeatReportDesc.
  ///
  /// In en, this message translates to:
  /// **'Export contractions & kicks to PDF'**
  String get paywallFeatReportDesc;

  /// No description provided for @paywallFeatAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Deep Health Analytics'**
  String get paywallFeatAnalyticsTitle;

  /// No description provided for @paywallFeatAnalyticsDesc.
  ///
  /// In en, this message translates to:
  /// **'Smart weight & symptom tracking'**
  String get paywallFeatAnalyticsDesc;

  /// No description provided for @paywallFeatGalleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Bump Gallery'**
  String get paywallFeatGalleryTitle;

  /// No description provided for @paywallFeatGalleryDesc.
  ///
  /// In en, this message translates to:
  /// **'Save every week as a memory'**
  String get paywallFeatGalleryDesc;

  /// No description provided for @paywallMonth.
  ///
  /// In en, this message translates to:
  /// **'1 MONTH'**
  String get paywallMonth;

  /// No description provided for @paywallYear.
  ///
  /// In en, this message translates to:
  /// **'1 YEAR'**
  String get paywallYear;

  /// No description provided for @paywallSaveBadge.
  ///
  /// In en, this message translates to:
  /// **'SAVE 50%'**
  String get paywallSaveBadge;

  /// No description provided for @paywallContinue.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get paywallContinue;

  /// No description provided for @paywallTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get paywallTerms;

  /// No description provided for @paywallRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get paywallRestore;

  /// No description provided for @paywallError.
  ///
  /// In en, this message translates to:
  /// **'Failed to unlock. Try again.'**
  String get paywallError;

  /// No description provided for @paywallTrialBadge.
  ///
  /// In en, this message translates to:
  /// **'3 DAYS FREE'**
  String get paywallTrialBadge;

  /// No description provided for @paywallStartTrial.
  ///
  /// In en, this message translates to:
  /// **'START FREE TRIAL'**
  String get paywallStartTrial;

  /// No description provided for @paywallCancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime. No commitment.'**
  String get paywallCancelAnytime;

  /// No description provided for @greetingNight.
  ///
  /// In en, this message translates to:
  /// **'Good night 🌙'**
  String get greetingNight;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning ☀️'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon 🌸'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening 🌷'**
  String get greetingEvening;

  /// No description provided for @trimesterFirst.
  ///
  /// In en, this message translates to:
  /// **'Trimester I'**
  String get trimesterFirst;

  /// No description provided for @trimesterSecond.
  ///
  /// In en, this message translates to:
  /// **'Trimester II'**
  String get trimesterSecond;

  /// No description provided for @trimesterThird.
  ///
  /// In en, this message translates to:
  /// **'Trimester III'**
  String get trimesterThird;

  /// No description provided for @letterStateDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get letterStateDraft;

  /// No description provided for @letterStateSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get letterStateSaving;

  /// No description provided for @letterStateSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get letterStateSaved;

  /// No description provided for @letterStateError.
  ///
  /// In en, this message translates to:
  /// **'Not saved'**
  String get letterStateError;

  /// No description provided for @insightBabyDevTitle.
  ///
  /// In en, this message translates to:
  /// **'Baby Development'**
  String get insightBabyDevTitle;

  /// No description provided for @insightYourBodyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Body'**
  String get insightYourBodyTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCare.
  ///
  /// In en, this message translates to:
  /// **'Care'**
  String get navCare;

  /// No description provided for @navDiary.
  ///
  /// In en, this message translates to:
  /// **'Diary'**
  String get navDiary;

  /// No description provided for @phaseBeginning.
  ///
  /// In en, this message translates to:
  /// **'Gentle Beginning'**
  String get phaseBeginning;

  /// No description provided for @phaseGrowing.
  ///
  /// In en, this message translates to:
  /// **'Growing Together'**
  String get phaseGrowing;

  /// No description provided for @phaseAlmostTime.
  ///
  /// In en, this message translates to:
  /// **'Almost Time To Meet'**
  String get phaseAlmostTime;

  /// No description provided for @insightTagForYou.
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get insightTagForYou;

  /// No description provided for @insightTagFeelings.
  ///
  /// In en, this message translates to:
  /// **'Feelings'**
  String get insightTagFeelings;

  /// No description provided for @insightTagTip.
  ///
  /// In en, this message translates to:
  /// **'Gentle Tip'**
  String get insightTagTip;

  /// No description provided for @insightTagBaby.
  ///
  /// In en, this message translates to:
  /// **'About Baby'**
  String get insightTagBaby;

  /// No description provided for @weekNavLabel.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy Weeks'**
  String get weekNavLabel;

  /// No description provided for @weekNavLaborMode.
  ///
  /// In en, this message translates to:
  /// **'Labor Mode'**
  String get weekNavLaborMode;

  /// No description provided for @weekNavGrowth.
  ///
  /// In en, this message translates to:
  /// **'Growth'**
  String get weekNavGrowth;

  /// No description provided for @weekNavNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get weekNavNow;

  /// No description provided for @snapshotStage.
  ///
  /// In en, this message translates to:
  /// **'Stage'**
  String get snapshotStage;

  /// No description provided for @snapshotNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get snapshotNow;

  /// No description provided for @quickDiary.
  ///
  /// In en, this message translates to:
  /// **'Diary'**
  String get quickDiary;

  /// No description provided for @quickCare.
  ///
  /// In en, this message translates to:
  /// **'Care'**
  String get quickCare;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotifyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly Growth'**
  String get settingsNotifyWeekly;

  /// No description provided for @settingsNotifyVitamins.
  ///
  /// In en, this message translates to:
  /// **'Habit: Vitamins (09:00)'**
  String get settingsNotifyVitamins;

  /// No description provided for @settingsNotifyWater.
  ///
  /// In en, this message translates to:
  /// **'Habit: Water (18:00)'**
  String get settingsNotifyWater;

  /// No description provided for @onboardingStep1Title2.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get onboardingStep1Title2;

  /// No description provided for @onboardingEddTitle.
  ///
  /// In en, this message translates to:
  /// **'Expected Due Date'**
  String get onboardingEddTitle;

  /// No description provided for @onboardingLmpTitle.
  ///
  /// In en, this message translates to:
  /// **'First day of\nyour last period'**
  String get onboardingLmpTitle;

  /// No description provided for @onboardingEddSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Did your doctor give you a due date?'**
  String get onboardingEddSubtitle;

  /// No description provided for @onboardingLmpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll calculate your due date automatically'**
  String get onboardingLmpSubtitle;

  /// No description provided for @onboardingLanguagePrompt.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get onboardingLanguagePrompt;

  /// No description provided for @onboardingLanguageBody.
  ///
  /// In en, this message translates to:
  /// **'Set your language now. You can change it later in Settings.'**
  String get onboardingLanguageBody;

  /// No description provided for @onboardingProfileBody.
  ///
  /// In en, this message translates to:
  /// **'A few gentle details help us shape the journey around you.'**
  String get onboardingProfileBody;

  /// No description provided for @onboardingDateBody.
  ///
  /// In en, this message translates to:
  /// **'Choose the option you know best. We\'ll calculate the timeline for you.'**
  String get onboardingDateBody;

  /// No description provided for @onboardingReadyBody.
  ///
  /// In en, this message translates to:
  /// **'Your space is ready. You can adjust names, reminders, and labor prep any time.'**
  String get onboardingReadyBody;

  /// No description provided for @privacyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy has not been added to the app yet.'**
  String get privacyUnavailable;

  /// No description provided for @paywallOffersLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load offers right now.'**
  String get paywallOffersLoadError;

  /// No description provided for @paywallProBadge.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get paywallProBadge;

  /// No description provided for @paywallMockTitle.
  ///
  /// In en, this message translates to:
  /// **'Test PRO access'**
  String get paywallMockTitle;

  /// No description provided for @paywallMockBody.
  ///
  /// In en, this message translates to:
  /// **'You are in a development build. Use the button below to simulate Premium and verify locked flows.'**
  String get paywallMockBody;

  /// No description provided for @paywallMockCta.
  ///
  /// In en, this message translates to:
  /// **'ENABLE TEST PRO'**
  String get paywallMockCta;

  /// No description provided for @reportGenerationError.
  ///
  /// In en, this message translates to:
  /// **'Error generating report:\n{error}'**
  String reportGenerationError(Object error);

  /// No description provided for @pdfFilePrefix.
  ///
  /// In en, this message translates to:
  /// **'Bloom_Report'**
  String get pdfFilePrefix;

  /// No description provided for @pdfHealthFilePrefix.
  ///
  /// In en, this message translates to:
  /// **'elpis_health_report'**
  String get pdfHealthFilePrefix;

  /// No description provided for @pdfFallbackPatientName.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get pdfFallbackPatientName;

  /// No description provided for @pdfBmiValue.
  ///
  /// In en, this message translates to:
  /// **' | BMI: {value}'**
  String pdfBmiValue(Object value);

  /// No description provided for @laborHelpFallbackName.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get laborHelpFallbackName;

  /// No description provided for @laborPartnerNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Alex'**
  String get laborPartnerNameHint;

  /// No description provided for @laborPartnerPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+1 234 ...'**
  String get laborPartnerPhoneHint;

  /// No description provided for @laborDoctorPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact'**
  String get laborDoctorPhoneHint;

  /// No description provided for @laborHospitalAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Street, Building...'**
  String get laborHospitalAddressHint;

  /// No description provided for @settingsOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Everything in one calm place'**
  String get settingsOverviewTitle;

  /// No description provided for @settingsOverviewBody.
  ///
  /// In en, this message translates to:
  /// **'Update your names, due date, reminders, and emergency details without hunting through the app.'**
  String get settingsOverviewBody;

  /// No description provided for @settingsProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settingsProfileTitle;

  /// No description provided for @settingsProfileBody.
  ///
  /// In en, this message translates to:
  /// **'Names and due date used across your journey.'**
  String get settingsProfileBody;

  /// No description provided for @settingsPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'App preferences'**
  String get settingsPreferencesTitle;

  /// No description provided for @settingsPreferencesBody.
  ///
  /// In en, this message translates to:
  /// **'Language, reminders, and the way your baby is shown.'**
  String get settingsPreferencesBody;

  /// No description provided for @settingsAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccountTitle;

  /// No description provided for @settingsAccountBody.
  ///
  /// In en, this message translates to:
  /// **'Stay in guest mode or connect an account whenever you're ready.'**
  String get settingsAccountBody;

  /// No description provided for @settingsLaborPrepTitle.
  ///
  /// In en, this message translates to:
  /// **'Labor & emergency prep'**
  String get settingsLaborPrepTitle;

  /// No description provided for @settingsLaborPrepBody.
  ///
  /// In en, this message translates to:
  /// **'Keep important contacts ready and leave the labor shortcut visible only if you want it.'**
  String get settingsLaborPrepBody;

  /// No description provided for @settingsDocsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports & privacy'**
  String get settingsDocsTitle;

  /// No description provided for @settingsDocsBody.
  ///
  /// In en, this message translates to:
  /// **'Export a PDF, review the medical disclaimer, and check privacy information.'**
  String get settingsDocsBody;

  /// No description provided for @settingsDangerTitle.
  ///
  /// In en, this message translates to:
  /// **'Danger zone'**
  String get settingsDangerTitle;

  /// No description provided for @settingsDangerBody.
  ///
  /// In en, this message translates to:
  /// **'Delete local data only if you truly want to start over.'**
  String get settingsDangerBody;

  /// No description provided for @settingsSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get settingsSaveChanges;

  /// No description provided for @settingsChangesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved'**
  String get settingsChangesSaved;

  /// No description provided for @settingsSaveHelper.
  ///
  /// In en, this message translates to:
  /// **'Toggles save instantly. Text fields save when you tap Save.'**
  String get settingsSaveHelper;

  /// No description provided for @settingsShowLaborButton.
  ///
  /// In en, this message translates to:
  /// **'Show labor shortcut on Home'**
  String get settingsShowLaborButton;

  /// No description provided for @settingsShowLaborButtonBody.
  ///
  /// In en, this message translates to:
  /// **'Keep the emergency entry point visible when you want faster access.'**
  String get settingsShowLaborButtonBody;

  /// No description provided for @todayForYouFootnote.
  ///
  /// In en, this message translates to:
  /// **'You can come back to this gentle focus anytime today.'**
  String get todayForYouFootnote;

  /// No description provided for @earlyWeek1Title.
  ///
  /// In en, this message translates to:
  /// **'Cycle Start'**
  String get earlyWeek1Title;

  /// No description provided for @earlyWeek1Description.
  ///
  /// In en, this message translates to:
  /// **'Your body is preparing for a possible miracle.'**
  String get earlyWeek1Description;

  /// No description provided for @earlyWeek2Title.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get earlyWeek2Title;

  /// No description provided for @earlyWeek2Description.
  ///
  /// In en, this message translates to:
  /// **'The crucial moment for creating new life.'**
  String get earlyWeek2Description;

  /// No description provided for @earlyWeek3Title.
  ///
  /// In en, this message translates to:
  /// **'Conception'**
  String get earlyWeek3Title;

  /// No description provided for @earlyWeek3Description.
  ///
  /// In en, this message translates to:
  /// **'A tiny cell begins its big journey.'**
  String get earlyWeek3Description;

  /// No description provided for @updatingData.
  ///
  /// In en, this message translates to:
  /// **'Updating data'**
  String get updatingData;

  /// No description provided for @updatingDataSentence.
  ///
  /// In en, this message translates to:
  /// **'Data updating.'**
  String get updatingDataSentence;

  /// No description provided for @weekDetailTakeCare.
  ///
  /// In en, this message translates to:
  /// **'Take care of yourself.'**
  String get weekDetailTakeCare;

  /// No description provided for @weekDetailBabyActive.
  ///
  /// In en, this message translates to:
  /// **'Baby is actively developing.'**
  String get weekDetailBabyActive;

  /// No description provided for @weekDetailBodyChanging.
  ///
  /// In en, this message translates to:
  /// **'Your body continues to change.'**
  String get weekDetailBodyChanging;

  /// No description provided for @weekDetailRest.
  ///
  /// In en, this message translates to:
  /// **'Rest and listen to your body.'**
  String get weekDetailRest;

  /// No description provided for @notificationBabyFallback.
  ///
  /// In en, this message translates to:
  /// **'baby'**
  String get notificationBabyFallback;

  /// No description provided for @notificationWeeklyTitleNamed.
  ///
  /// In en, this message translates to:
  /// **'{name}, happy new week! 🎉'**
  String notificationWeeklyTitleNamed(Object name);

  /// No description provided for @notificationWeeklyTitle.
  ///
  /// In en, this message translates to:
  /// **'Happy new week! 🎉'**
  String get notificationWeeklyTitle;

  /// No description provided for @notificationWeeklyBody.
  ///
  /// In en, this message translates to:
  /// **'You are on week {week}. Tap to see how {baby} has grown.'**
  String notificationWeeklyBody(Object week, Object baby);

  /// No description provided for @notificationVitaminsTitleNamed.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}! 💊'**
  String notificationVitaminsTitleNamed(Object name);

  /// No description provided for @notificationVitaminsTitle.
  ///
  /// In en, this message translates to:
  /// **'Vitamin time ☀️'**
  String get notificationVitaminsTitle;

  /// No description provided for @notificationVitaminsBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to take your vitamins.'**
  String get notificationVitaminsBody;

  /// No description provided for @notificationWaterTitleNamed.
  ///
  /// In en, this message translates to:
  /// **'{name}, hydration check! 💧'**
  String notificationWaterTitleNamed(Object name);

  /// No description provided for @notificationWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Hydration check 💧'**
  String get notificationWaterTitle;

  /// No description provided for @notificationWaterBody.
  ///
  /// In en, this message translates to:
  /// **'Time to drink a glass of water!'**
  String get notificationWaterBody;

  /// No description provided for @insightWeek1FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Invisible Pollen'**
  String get insightWeek1FruitTitle;

  /// No description provided for @insightWeek1FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Your body is just preparing to create a miracle.'**
  String get insightWeek1FruitDescription;

  /// No description provided for @insightWeek1RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Blank Canvas'**
  String get insightWeek1RealisticTitle;

  /// No description provided for @insightWeek1RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'The beginning of a beautiful new story.'**
  String get insightWeek1RealisticDescription;

  /// No description provided for @insightWeek1BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Physically, the baby doesn\'t exist yet. This is the start of your menstrual cycle, during which an egg matures.'**
  String get insightWeek1BabyDev;

  /// No description provided for @insightWeek1MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your body is updating the uterine lining, creating the perfect \'soil\' for the future embryo to attach.'**
  String get insightWeek1MomBody;

  /// No description provided for @insightWeek1Tip.
  ///
  /// In en, this message translates to:
  /// **'Start taking folic acid (400 mcg daily) and cut out any unhealthy habits.'**
  String get insightWeek1Tip;

  /// No description provided for @insightWeek1Milestone.
  ///
  /// In en, this message translates to:
  /// **'Start of the gestational clock'**
  String get insightWeek1Milestone;

  /// No description provided for @insightWeek1Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Preparation'**
  String get insightWeek1Insight1Title;

  /// No description provided for @insightWeek1Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Your body is starting a new cycle. Hormones are working to mature the perfect egg.'**
  String get insightWeek1Insight1Content;

  /// No description provided for @insightWeek1Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Vitamins'**
  String get insightWeek1Insight2Title;

  /// No description provided for @insightWeek1Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Vitamin B9 (folic acid) is crucial right now to prevent neural tube defects.'**
  String get insightWeek1Insight2Content;

  /// No description provided for @insightWeek1Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Mindset'**
  String get insightWeek1Insight3Title;

  /// No description provided for @insightWeek1Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Minimize stress. It\'s the perfect time for positive thoughts and planning.'**
  String get insightWeek1Insight3Content;

  /// No description provided for @insightWeek2FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Tiny Spore'**
  String get insightWeek2FruitTitle;

  /// No description provided for @insightWeek2FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Hidden potential for the birth of a new life.'**
  String get insightWeek2FruitDescription;

  /// No description provided for @insightWeek2RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'A Spark'**
  String get insightWeek2RealisticTitle;

  /// No description provided for @insightWeek2RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'The moment when all the stars align.'**
  String get insightWeek2RealisticDescription;

  /// No description provided for @insightWeek2BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Ovulation happens at the end of this week. The strongest egg will meet the sperm.'**
  String get insightWeek2BabyDev;

  /// No description provided for @insightWeek2MomBody.
  ///
  /// In en, this message translates to:
  /// **'Estrogen levels are rising. You might feel a slight twinge in your lower abdomen — a sign of ovulation.'**
  String get insightWeek2MomBody;

  /// No description provided for @insightWeek2Tip.
  ///
  /// In en, this message translates to:
  /// **'The perfect time for romance and conception. Enjoy the process!'**
  String get insightWeek2Tip;

  /// No description provided for @insightWeek2Milestone.
  ///
  /// In en, this message translates to:
  /// **'Ovulation and fertilization'**
  String get insightWeek2Milestone;

  /// No description provided for @insightWeek2Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get insightWeek2Insight1Title;

  /// No description provided for @insightWeek2Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'The egg leaves the ovary and travels into the fallopian tube to meet its destiny.'**
  String get insightWeek2Insight1Content;

  /// No description provided for @insightWeek2Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get insightWeek2Insight2Title;

  /// No description provided for @insightWeek2Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Sperm can live in the female body for up to 5 days. It\'s time to act!'**
  String get insightWeek2Insight2Content;

  /// No description provided for @insightWeek2Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Intuition'**
  String get insightWeek2Insight3Title;

  /// No description provided for @insightWeek2Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Many women claim they intuitively feel the exact moment of conception.'**
  String get insightWeek2Insight3Content;

  /// No description provided for @insightWeek3FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Vanilla Seed'**
  String get insightWeek3FruitTitle;

  /// No description provided for @insightWeek3FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Less than a millimeter, but already an incredibly complex creation.'**
  String get insightWeek3FruitDescription;

  /// No description provided for @insightWeek3RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Grain of Sand'**
  String get insightWeek3RealisticTitle;

  /// No description provided for @insightWeek3RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A golden speck that has found its perfect place.'**
  String get insightWeek3RealisticDescription;

  /// No description provided for @insightWeek3BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The fertilized egg (zygote) is actively dividing and turns into a blastocyst as it travels to the uterus.'**
  String get insightWeek3BabyDev;

  /// No description provided for @insightWeek3MomBody.
  ///
  /// In en, this message translates to:
  /// **'The blastocyst implants itself into the uterine wall. You might notice light spotting.'**
  String get insightWeek3MomBody;

  /// No description provided for @insightWeek3Tip.
  ///
  /// In en, this message translates to:
  /// **'Avoid heavy physical exertion, hot baths, and X-ray exposure.'**
  String get insightWeek3Tip;

  /// No description provided for @insightWeek3Milestone.
  ///
  /// In en, this message translates to:
  /// **'Embryo implantation'**
  String get insightWeek3Milestone;

  /// No description provided for @insightWeek3Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'The Journey'**
  String get insightWeek3Insight1Title;

  /// No description provided for @insightWeek3Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'The baby makes a 7-day journey down the fallopian tube into the uterus.'**
  String get insightWeek3Insight1Content;

  /// No description provided for @insightWeek3Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Implantation'**
  String get insightWeek3Insight2Title;

  /// No description provided for @insightWeek3Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Mild cramping and a few drops of blood are common signs of successful attachment.'**
  String get insightWeek3Insight2Content;

  /// No description provided for @insightWeek3Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Take care'**
  String get insightWeek3Insight3Title;

  /// No description provided for @insightWeek3Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Your body is putting all its energy into supporting new life. Rest up.'**
  String get insightWeek3Insight3Content;

  /// No description provided for @insightWeek4FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Poppy Seed'**
  String get insightWeek4FruitTitle;

  /// No description provided for @insightWeek4FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'A tiny dot containing the entire universe of your future child.'**
  String get insightWeek4FruitDescription;

  /// No description provided for @insightWeek4RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Tiny Bead'**
  String get insightWeek4RealisticTitle;

  /// No description provided for @insightWeek4RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A tiny but precious detail of the huge picture you are starting to paint.'**
  String get insightWeek4RealisticDescription;

  /// No description provided for @insightWeek4GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'1–2 mm, <1 g'**
  String get insightWeek4GrowthTitle;

  /// No description provided for @insightWeek4GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a poppy seed. The embryo is forming.'**
  String get insightWeek4GrowthDescription;

  /// No description provided for @insightWeek4BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The embryo consists of two layers (epiblast and hypoblast) from which all organs and tissues will develop.'**
  String get insightWeek4BabyDev;

  /// No description provided for @insightWeek4MomBody.
  ///
  /// In en, this message translates to:
  /// **'hCG hormone levels are high enough for a pregnancy test to show those two lines.'**
  String get insightWeek4MomBody;

  /// No description provided for @insightWeek4Tip.
  ///
  /// In en, this message translates to:
  /// **'Schedule your first prenatal appointment for around week 7 or 8.'**
  String get insightWeek4Tip;

  /// No description provided for @insightWeek4Milestone.
  ///
  /// In en, this message translates to:
  /// **'Positive pregnancy test!'**
  String get insightWeek4Milestone;

  /// No description provided for @insightWeek4Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Silent Miracle'**
  String get insightWeek4Insight1Title;

  /// No description provided for @insightWeek4Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'A revolution of cell division is happening inside.'**
  String get insightWeek4Insight1Content;

  /// No description provided for @insightWeek4Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Vitamins'**
  String get insightWeek4Insight2Title;

  /// No description provided for @insightWeek4Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Folic acid is the main building block right now.'**
  String get insightWeek4Insight2Content;

  /// No description provided for @insightWeek4Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get insightWeek4Insight3Title;

  /// No description provided for @insightWeek4Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Avoid overheating. Saunas are best postponed.'**
  String get insightWeek4Insight3Content;

  /// No description provided for @insightWeek5FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Sesame Seed'**
  String get insightWeek5FruitTitle;

  /// No description provided for @insightWeek5FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'A small miracle opening doors to a huge world.'**
  String get insightWeek5FruitDescription;

  /// No description provided for @insightWeek5RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Pinhead'**
  String get insightWeek5RealisticTitle;

  /// No description provided for @insightWeek5RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Hidden in this seed is the power of a whole garden.'**
  String get insightWeek5RealisticDescription;

  /// No description provided for @insightWeek5GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'2–3 mm, <1 g'**
  String get insightWeek5GrowthTitle;

  /// No description provided for @insightWeek5GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a sesame seed. A tiny life inside you.'**
  String get insightWeek5GrowthDescription;

  /// No description provided for @insightWeek5BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The neural tube (future brain and spinal cord) and a tiny heart are beginning to form.'**
  String get insightWeek5BabyDev;

  /// No description provided for @insightWeek5MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your breasts may become tender. Early fatigue and frequent urination begin.'**
  String get insightWeek5MomBody;

  /// No description provided for @insightWeek5Tip.
  ///
  /// In en, this message translates to:
  /// **'Cut out raw fish (sushi), rare meat, and unpasteurized cheeses from your diet.'**
  String get insightWeek5Tip;

  /// No description provided for @insightWeek5Milestone.
  ///
  /// In en, this message translates to:
  /// **'The heart starts beating'**
  String get insightWeek5Milestone;

  /// No description provided for @insightWeek5Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Heartbeat'**
  String get insightWeek5Insight1Title;

  /// No description provided for @insightWeek5Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'A tiny engine starts working. It beats twice as fast as yours.'**
  String get insightWeek5Insight1Content;

  /// No description provided for @insightWeek5Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Emotions'**
  String get insightWeek5Insight2Title;

  /// No description provided for @insightWeek5Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Hormones are reshaping your world. Cry if you need to.'**
  String get insightWeek5Insight2Content;

  /// No description provided for @insightWeek5Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Diet'**
  String get insightWeek5Insight3Title;

  /// No description provided for @insightWeek5Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Avoid raw fish, soft cheeses, and alcohol.'**
  String get insightWeek5Insight3Content;

  /// No description provided for @insightWeek6FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Sweet Pea'**
  String get insightWeek6FruitTitle;

  /// No description provided for @insightWeek6FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Small and sweet. The baby is curled up.'**
  String get insightWeek6FruitDescription;

  /// No description provided for @insightWeek6RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Bright Bead'**
  String get insightWeek6RealisticTitle;

  /// No description provided for @insightWeek6RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'One day you will string such beads together.'**
  String get insightWeek6RealisticDescription;

  /// No description provided for @insightWeek6GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'4–6 mm, <1 g'**
  String get insightWeek6GrowthTitle;

  /// No description provided for @insightWeek6GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a lentil. Rapid growth is underway.'**
  String get insightWeek6GrowthDescription;

  /// No description provided for @insightWeek6BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Jaws, cheeks, and chin are forming, along with the beginnings of eyes and ears.'**
  String get insightWeek6BabyDev;

  /// No description provided for @insightWeek6MomBody.
  ///
  /// In en, this message translates to:
  /// **'Morning sickness may begin. Nausea is a faithful companion for many moms at this stage.'**
  String get insightWeek6MomBody;

  /// No description provided for @insightWeek6Tip.
  ///
  /// In en, this message translates to:
  /// **'Keep crackers or dry toast by your bed. Eat a couple before getting up in the morning.'**
  String get insightWeek6Tip;

  /// No description provided for @insightWeek6Milestone.
  ///
  /// In en, this message translates to:
  /// **'Facial features begin to form'**
  String get insightWeek6Milestone;

  /// No description provided for @insightWeek6Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Super Smell'**
  String get insightWeek6Insight1Title;

  /// No description provided for @insightWeek6Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Your sense of smell sharpens acting as a detector.'**
  String get insightWeek6Insight1Content;

  /// No description provided for @insightWeek6Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get insightWeek6Insight2Title;

  /// No description provided for @insightWeek6Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Your body spends colossal energy. Napping is normal.'**
  String get insightWeek6Insight2Content;

  /// No description provided for @insightWeek6Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get insightWeek6Insight3Title;

  /// No description provided for @insightWeek6Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Sip water frequently to help reduce nausea.'**
  String get insightWeek6Insight3Content;

  /// No description provided for @insightWeek7FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Blueberry'**
  String get insightWeek7FruitTitle;

  /// No description provided for @insightWeek7FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'A dark berry. The brain is actively forming.'**
  String get insightWeek7FruitDescription;

  /// No description provided for @insightWeek7RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Glass Marble'**
  String get insightWeek7RealisticTitle;

  /// No description provided for @insightWeek7RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Small and transparent. What allows him to feel this world is already forming.'**
  String get insightWeek7RealisticDescription;

  /// No description provided for @insightWeek7GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'10–13 mm, <1 g'**
  String get insightWeek7GrowthTitle;

  /// No description provided for @insightWeek7GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a blueberry. Almost a centimeter!'**
  String get insightWeek7GrowthDescription;

  /// No description provided for @insightWeek7BabyDev.
  ///
  /// In en, this message translates to:
  /// **'About 100 new nerve cells are generated every minute! Arm and leg buds appear.'**
  String get insightWeek7BabyDev;

  /// No description provided for @insightWeek7MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your uterus has grown to the size of a lemon. You might be running to the bathroom more often.'**
  String get insightWeek7MomBody;

  /// No description provided for @insightWeek7Tip.
  ///
  /// In en, this message translates to:
  /// **'Have your first ultrasound to confirm the heartbeat and rule out ectopic pregnancy.'**
  String get insightWeek7Tip;

  /// No description provided for @insightWeek7Milestone.
  ///
  /// In en, this message translates to:
  /// **'Umbilical cord formation'**
  String get insightWeek7Milestone;

  /// No description provided for @insightWeek7Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Morning Sickness'**
  String get insightWeek7Insight1Title;

  /// No description provided for @insightWeek7Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Nausea can happen at night too. Eat crackers.'**
  String get insightWeek7Insight1Content;

  /// No description provided for @insightWeek7Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Secret'**
  String get insightWeek7Insight2Title;

  /// No description provided for @insightWeek7Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'You carry a secret only you know. Enjoy this privacy.'**
  String get insightWeek7Insight2Content;

  /// No description provided for @insightWeek7Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Restroom Runs'**
  String get insightWeek7Insight3Title;

  /// No description provided for @insightWeek7Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'The uterus grows and presses on the bladder.'**
  String get insightWeek7Insight3Content;

  /// No description provided for @insightWeek8FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Raspberry'**
  String get insightWeek8FruitTitle;

  /// No description provided for @insightWeek8FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'A complex berry. First micro-movements begin.'**
  String get insightWeek8FruitDescription;

  /// No description provided for @insightWeek8RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Toy Brick'**
  String get insightWeek8RealisticTitle;

  /// No description provided for @insightWeek8RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'The first brick for building whole worlds.'**
  String get insightWeek8RealisticDescription;

  /// No description provided for @insightWeek8GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'14–20 mm, ~1 g'**
  String get insightWeek8GrowthTitle;

  /// No description provided for @insightWeek8GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a raspberry. Crossing the 1g milestone.'**
  String get insightWeek8GrowthDescription;

  /// No description provided for @insightWeek8BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The embryo loses its \'tail\'. Fingers and toes begin to take shape.'**
  String get insightWeek8BabyDev;

  /// No description provided for @insightWeek8MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your blood volume increases by 40-50%. Your heart is working for two.'**
  String get insightWeek8MomBody;

  /// No description provided for @insightWeek8Tip.
  ///
  /// In en, this message translates to:
  /// **'Buy a comfortable, wire-free bra — your breasts will continue to grow.'**
  String get insightWeek8Tip;

  /// No description provided for @insightWeek8Milestone.
  ///
  /// In en, this message translates to:
  /// **'First spontaneous movements'**
  String get insightWeek8Milestone;

  /// No description provided for @insightWeek8Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Movement'**
  String get insightWeek8Insight1Title;

  /// No description provided for @insightWeek8Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'He is already moving, though you don\'t feel it yet.'**
  String get insightWeek8Insight1Content;

  /// No description provided for @insightWeek8Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Cramping'**
  String get insightWeek8Insight2Title;

  /// No description provided for @insightWeek8Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'The uterus is the size of a grapefruit. Mild cramping is possible.'**
  String get insightWeek8Insight2Content;

  /// No description provided for @insightWeek8Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Walks'**
  String get insightWeek8Insight3Title;

  /// No description provided for @insightWeek8Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Fresh air is the best cure for fatigue.'**
  String get insightWeek8Insight3Content;

  /// No description provided for @insightWeek9FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Green Olive'**
  String get insightWeek9FruitTitle;

  /// No description provided for @insightWeek9FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Firm and strong. Muscles are strengthening.'**
  String get insightWeek9FruitDescription;

  /// No description provided for @insightWeek9RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'AAA Battery'**
  String get insightWeek9RealisticTitle;

  /// No description provided for @insightWeek9RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Juicy and full of life. The tail is gone.'**
  String get insightWeek9RealisticDescription;

  /// No description provided for @insightWeek9GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'2–3 cm, ~2 g'**
  String get insightWeek9GrowthTitle;

  /// No description provided for @insightWeek9GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of an olive. Proportions are changing.'**
  String get insightWeek9GrowthDescription;

  /// No description provided for @insightWeek9BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Tiny muscles form. The baby begins to bend arms at the elbows and wrists.'**
  String get insightWeek9BabyDev;

  /// No description provided for @insightWeek9MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your bump isn\'t visible yet, but your waist may thicken. Mood swings are common.'**
  String get insightWeek9MomBody;

  /// No description provided for @insightWeek9Tip.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget calcium (dairy, spinach) — it\'s essential for your baby\'s bones.'**
  String get insightWeek9Tip;

  /// No description provided for @insightWeek9Milestone.
  ///
  /// In en, this message translates to:
  /// **'Status upgrade: Now a fetus!'**
  String get insightWeek9Milestone;

  /// No description provided for @insightWeek9Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Muscles'**
  String get insightWeek9Insight1Title;

  /// No description provided for @insightWeek9Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Tiny muscles develop; he learns to bend his arms.'**
  String get insightWeek9Insight1Content;

  /// No description provided for @insightWeek9Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Dreams'**
  String get insightWeek9Insight2Title;

  /// No description provided for @insightWeek9Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Dreams can become vivid. Subconscious is processing fears.'**
  String get insightWeek9Insight2Content;

  /// No description provided for @insightWeek9Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Lingerie'**
  String get insightWeek9Insight3Title;

  /// No description provided for @insightWeek9Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Time to find a comfortable bra.'**
  String get insightWeek9Insight3Content;

  /// No description provided for @insightWeek10FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Kumquat'**
  String get insightWeek10FruitTitle;

  /// No description provided for @insightWeek10FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Golden citrus. Vital organs are functioning.'**
  String get insightWeek10FruitDescription;

  /// No description provided for @insightWeek10RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Bottle Cap'**
  String get insightWeek10RealisticTitle;

  /// No description provided for @insightWeek10RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A tough nut. His brain develops incredibly fast.'**
  String get insightWeek10RealisticDescription;

  /// No description provided for @insightWeek10GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'3–4 cm, ~4 g'**
  String get insightWeek10GrowthTitle;

  /// No description provided for @insightWeek10GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a prune. Active mass gaining begins.'**
  String get insightWeek10GrowthDescription;

  /// No description provided for @insightWeek10BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Kidneys begin to produce urine. The liver produces bile. Organs start functioning.'**
  String get insightWeek10BabyDev;

  /// No description provided for @insightWeek10MomBody.
  ///
  /// In en, this message translates to:
  /// **'Veins on your breasts and belly may become more noticeable due to increased blood flow.'**
  String get insightWeek10MomBody;

  /// No description provided for @insightWeek10Tip.
  ///
  /// In en, this message translates to:
  /// **'Schedule your first genetic screening ultrasound (between 11-13 weeks).'**
  String get insightWeek10Tip;

  /// No description provided for @insightWeek10Milestone.
  ///
  /// In en, this message translates to:
  /// **'Organs start working'**
  String get insightWeek10Milestone;

  /// No description provided for @insightWeek10Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Autonomy'**
  String get insightWeek10Insight1Title;

  /// No description provided for @insightWeek10Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Kidneys, liver, and brain are functioning independently.'**
  String get insightWeek10Insight1Content;

  /// No description provided for @insightWeek10Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get insightWeek10Insight2Title;

  /// No description provided for @insightWeek10Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Comfort is more important than fashion now.'**
  String get insightWeek10Insight2Content;

  /// No description provided for @insightWeek10Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Mood Swings'**
  String get insightWeek10Insight3Title;

  /// No description provided for @insightWeek10Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Euphoria to anxiety. Breathe deep.'**
  String get insightWeek10Insight3Content;

  /// No description provided for @insightWeek11FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Fig'**
  String get insightWeek11FruitTitle;

  /// No description provided for @insightWeek11FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Sweet fruit. Baby learns to open its mouth.'**
  String get insightWeek11FruitDescription;

  /// No description provided for @insightWeek11RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Golf Ball'**
  String get insightWeek11RealisticTitle;

  /// No description provided for @insightWeek11RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Dense and bouncy. Soon he will start playing inside.'**
  String get insightWeek11RealisticDescription;

  /// No description provided for @insightWeek11GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'4–5 cm, ~7 g'**
  String get insightWeek11GrowthTitle;

  /// No description provided for @insightWeek11GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Reaching 5 cm long from crown to rump.'**
  String get insightWeek11GrowthDescription;

  /// No description provided for @insightWeek11BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Fingers and toes have fully separated. Tooth buds and nail beds begin to form.'**
  String get insightWeek11BabyDev;

  /// No description provided for @insightWeek11MomBody.
  ///
  /// In en, this message translates to:
  /// **'Hair and nails may grow faster and stronger (a pregnancy bonus!).'**
  String get insightWeek11MomBody;

  /// No description provided for @insightWeek11Tip.
  ///
  /// In en, this message translates to:
  /// **'Avoid infections. Wash your hands frequently and avoid crowded places.'**
  String get insightWeek11Tip;

  /// No description provided for @insightWeek11Milestone.
  ///
  /// In en, this message translates to:
  /// **'Tooth buds formation'**
  String get insightWeek11Milestone;

  /// No description provided for @insightWeek11Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'First Scan'**
  String get insightWeek11Insight1Title;

  /// No description provided for @insightWeek11Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'You will hear the most important rhythm — the heartbeat.'**
  String get insightWeek11Insight1Content;

  /// No description provided for @insightWeek11Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Hair & Nails'**
  String get insightWeek11Insight2Title;

  /// No description provided for @insightWeek11Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'You may notice they grow faster.'**
  String get insightWeek11Insight2Content;

  /// No description provided for @insightWeek11Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get insightWeek11Insight3Title;

  /// No description provided for @insightWeek11Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Carry nuts or an apple for hunger.'**
  String get insightWeek11Insight3Content;

  /// No description provided for @insightWeek12FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Plum'**
  String get insightWeek12FruitTitle;

  /// No description provided for @insightWeek12FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Smooth and juicy. Skeleton is hardening.'**
  String get insightWeek12FruitDescription;

  /// No description provided for @insightWeek12RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Pacifier'**
  String get insightWeek12RealisticTitle;

  /// No description provided for @insightWeek12RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A symbol of calmness. One day it will help him sleep.'**
  String get insightWeek12RealisticDescription;

  /// No description provided for @insightWeek12GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'5–6 cm, ~14 g'**
  String get insightWeek12GrowthTitle;

  /// No description provided for @insightWeek12GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of an apricot. First trimester ends!'**
  String get insightWeek12GrowthDescription;

  /// No description provided for @insightWeek12BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Reflexes improve: the baby can clench fists, frown, and suck their thumb.'**
  String get insightWeek12BabyDev;

  /// No description provided for @insightWeek12MomBody.
  ///
  /// In en, this message translates to:
  /// **'The top of your uterus rises above your pubic bone. Morning sickness often fades.'**
  String get insightWeek12MomBody;

  /// No description provided for @insightWeek12Tip.
  ///
  /// In en, this message translates to:
  /// **'This is the perfect time to officially announce your pregnancy to family and friends!'**
  String get insightWeek12Tip;

  /// No description provided for @insightWeek12Milestone.
  ///
  /// In en, this message translates to:
  /// **'End of the first trimester'**
  String get insightWeek12Milestone;

  /// No description provided for @insightWeek12Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Second Wind'**
  String get insightWeek12Insight1Title;

  /// No description provided for @insightWeek12Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'The placenta takes over. Energy returns.'**
  String get insightWeek12Insight1Content;

  /// No description provided for @insightWeek12Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Realization'**
  String get insightWeek12Insight2Title;

  /// No description provided for @insightWeek12Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'The risk of loss drops sharply.'**
  String get insightWeek12Insight2Content;

  /// No description provided for @insightWeek12Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get insightWeek12Insight3Title;

  /// No description provided for @insightWeek12Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Start moisturizing your belly.'**
  String get insightWeek12Insight3Content;

  /// No description provided for @insightWeek13FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Lemon'**
  String get insightWeek13FruitTitle;

  /// No description provided for @insightWeek13FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Bright and sunny. Fingerprints are appearing.'**
  String get insightWeek13FruitDescription;

  /// No description provided for @insightWeek13RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Baby Soap'**
  String get insightWeek13RealisticTitle;

  /// No description provided for @insightWeek13RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'The scent of purity and a soft towel.'**
  String get insightWeek13RealisticDescription;

  /// No description provided for @insightWeek13GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'7–8 cm, ~23 g'**
  String get insightWeek13GrowthTitle;

  /// No description provided for @insightWeek13GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a peach. Weighing over 20 grams.'**
  String get insightWeek13GrowthDescription;

  /// No description provided for @insightWeek13BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Vocal cords form. Intestines move from the umbilical cord into the baby\'s abdomen.'**
  String get insightWeek13BabyDev;

  /// No description provided for @insightWeek13MomBody.
  ///
  /// In en, this message translates to:
  /// **'You are entering the \'golden period\' of pregnancy. You feel much better.'**
  String get insightWeek13MomBody;

  /// No description provided for @insightWeek13Tip.
  ///
  /// In en, this message translates to:
  /// **'If you exercised before pregnancy, you can return to light workouts (yoga, swimming).'**
  String get insightWeek13Tip;

  /// No description provided for @insightWeek13Milestone.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint formation'**
  String get insightWeek13Milestone;

  /// No description provided for @insightWeek13Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Uniqueness'**
  String get insightWeek13Insight1Title;

  /// No description provided for @insightWeek13Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Fingerprints have formed.'**
  String get insightWeek13Insight1Content;

  /// No description provided for @insightWeek13Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Sharing News'**
  String get insightWeek13Insight2Title;

  /// No description provided for @insightWeek13Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Many choose this time to tell friends.'**
  String get insightWeek13Insight2Content;

  /// No description provided for @insightWeek13Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Ligaments'**
  String get insightWeek13Insight3Title;

  /// No description provided for @insightWeek13Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Pain on the sides is normal — ligaments are stretching.'**
  String get insightWeek13Insight3Content;

  /// No description provided for @insightWeek14FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Nectarine'**
  String get insightWeek14FruitTitle;

  /// No description provided for @insightWeek14FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Rosy fruit. Baby learns facial expressions.'**
  String get insightWeek14FruitDescription;

  /// No description provided for @insightWeek14RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Christmas Bauble'**
  String get insightWeek14RealisticTitle;

  /// No description provided for @insightWeek14RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A fragile miracle that makes the holiday special.'**
  String get insightWeek14RealisticDescription;

  /// No description provided for @insightWeek14GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'8–9 cm, ~43 g'**
  String get insightWeek14GrowthTitle;

  /// No description provided for @insightWeek14GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a lemon. The second trimester is in full swing.'**
  String get insightWeek14GrowthDescription;

  /// No description provided for @insightWeek14BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The baby practices facial expressions: frowning, squinting, and even swallowing.'**
  String get insightWeek14BabyDev;

  /// No description provided for @insightWeek14MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your bump begins to round out. Your energy is at its peak right now.'**
  String get insightWeek14MomBody;

  /// No description provided for @insightWeek14Tip.
  ///
  /// In en, this message translates to:
  /// **'Visit your dentist for a routine checkup. Gums are especially vulnerable now.'**
  String get insightWeek14Tip;

  /// No description provided for @insightWeek14Milestone.
  ///
  /// In en, this message translates to:
  /// **'Start of the second trimester'**
  String get insightWeek14Milestone;

  /// No description provided for @insightWeek14Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Grimaces'**
  String get insightWeek14Insight1Title;

  /// No description provided for @insightWeek14Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'The baby learns to frown and smile.'**
  String get insightWeek14Insight1Content;

  /// No description provided for @insightWeek14Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Golden Time'**
  String get insightWeek14Insight2Title;

  /// No description provided for @insightWeek14Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'The second trimester is the calmest.'**
  String get insightWeek14Insight2Content;

  /// No description provided for @insightWeek14Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get insightWeek14Insight3Title;

  /// No description provided for @insightWeek14Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Best time to visit a doctor.'**
  String get insightWeek14Insight3Content;

  /// No description provided for @insightWeek15FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get insightWeek15FruitTitle;

  /// No description provided for @insightWeek15FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'A ripe apple. Baby reacts to light.'**
  String get insightWeek15FruitDescription;

  /// No description provided for @insightWeek15RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Teacup'**
  String get insightWeek15RealisticTitle;

  /// No description provided for @insightWeek15RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'For warm cocoa. He can already hear your heartbeat from the inside.'**
  String get insightWeek15RealisticDescription;

  /// No description provided for @insightWeek15GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'10–11 cm, ~70 g'**
  String get insightWeek15GrowthTitle;

  /// No description provided for @insightWeek15GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of an apple. Over 10 cm in length!'**
  String get insightWeek15GrowthDescription;

  /// No description provided for @insightWeek15BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Baby\'s skin is very thin, with visible blood vessels. Hearing begins to develop.'**
  String get insightWeek15BabyDev;

  /// No description provided for @insightWeek15MomBody.
  ///
  /// In en, this message translates to:
  /// **'You might experience a stuffy nose (\'pregnancy rhinitis\') due to increased blood volume.'**
  String get insightWeek15MomBody;

  /// No description provided for @insightWeek15Tip.
  ///
  /// In en, this message translates to:
  /// **'Start sleeping on your side. Sleeping on your back can compress the vena cava.'**
  String get insightWeek15Tip;

  /// No description provided for @insightWeek15Milestone.
  ///
  /// In en, this message translates to:
  /// **'Hearing develops'**
  String get insightWeek15Milestone;

  /// No description provided for @insightWeek15Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Hearing'**
  String get insightWeek15Insight1Title;

  /// No description provided for @insightWeek15Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Ear bones have hardened.'**
  String get insightWeek15Insight1Content;

  /// No description provided for @insightWeek15Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Immunity'**
  String get insightWeek15Insight2Title;

  /// No description provided for @insightWeek15Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'You may get \'pregnancy rhinitis\'.'**
  String get insightWeek15Insight2Content;

  /// No description provided for @insightWeek15Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get insightWeek15Insight3Title;

  /// No description provided for @insightWeek15Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Read aloud or sing.'**
  String get insightWeek15Insight3Content;

  /// No description provided for @insightWeek16FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Avocado'**
  String get insightWeek16FruitTitle;

  /// No description provided for @insightWeek16FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Nutritious and soft. Baby holds head up.'**
  String get insightWeek16FruitDescription;

  /// No description provided for @insightWeek16RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Rubber Duckie'**
  String get insightWeek16RealisticTitle;

  /// No description provided for @insightWeek16RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Your future companion for fun baths.'**
  String get insightWeek16RealisticDescription;

  /// No description provided for @insightWeek16GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'11–12 cm, ~100 g'**
  String get insightWeek16GrowthTitle;

  /// No description provided for @insightWeek16GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of an avocado. The baby is now 100 grams!'**
  String get insightWeek16GrowthDescription;

  /// No description provided for @insightWeek16BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Proportions align: legs are longer than arms. The heart pumps about 25 liters of blood a day.'**
  String get insightWeek16BabyDev;

  /// No description provided for @insightWeek16MomBody.
  ///
  /// In en, this message translates to:
  /// **'Some moms already feel the first light flutters of their baby at this stage.'**
  String get insightWeek16MomBody;

  /// No description provided for @insightWeek16Tip.
  ///
  /// In en, this message translates to:
  /// **'Buy a U or C-shaped pregnancy pillow — it will save your sleep.'**
  String get insightWeek16Tip;

  /// No description provided for @insightWeek16Milestone.
  ///
  /// In en, this message translates to:
  /// **'Proportions become human'**
  String get insightWeek16Milestone;

  /// No description provided for @insightWeek16Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Proportions'**
  String get insightWeek16Insight1Title;

  /// No description provided for @insightWeek16Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Legs are now longer than arms.'**
  String get insightWeek16Insight1Content;

  /// No description provided for @insightWeek16Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy Brain'**
  String get insightWeek16Insight2Title;

  /// No description provided for @insightWeek16Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Forgetful? Brain focuses on the main thing.'**
  String get insightWeek16Insight2Content;

  /// No description provided for @insightWeek16Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get insightWeek16Insight3Title;

  /// No description provided for @insightWeek16Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Learn to sleep on your side.'**
  String get insightWeek16Insight3Content;

  /// No description provided for @insightWeek17FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Pomegranate'**
  String get insightWeek17FruitTitle;

  /// No description provided for @insightWeek17FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Full of treasures. Cartilage turning to bone.'**
  String get insightWeek17FruitDescription;

  /// No description provided for @insightWeek17RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Game Controller'**
  String get insightWeek17RealisticTitle;

  /// No description provided for @insightWeek17RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'He learns to control his body like in a game.'**
  String get insightWeek17RealisticDescription;

  /// No description provided for @insightWeek17GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'13–14 cm, ~140 g'**
  String get insightWeek17GrowthTitle;

  /// No description provided for @insightWeek17GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a large onion. Bones are getting stronger.'**
  String get insightWeek17GrowthDescription;

  /// No description provided for @insightWeek17BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Subcutaneous fat starts accumulating. Sweat glands are forming.'**
  String get insightWeek17BabyDev;

  /// No description provided for @insightWeek17MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your belly changes your center of gravity. Lower back pain is possible.'**
  String get insightWeek17MomBody;

  /// No description provided for @insightWeek17Tip.
  ///
  /// In en, this message translates to:
  /// **'Do some light stretching or prenatal yoga to relieve back spasms.'**
  String get insightWeek17Tip;

  /// No description provided for @insightWeek17Milestone.
  ///
  /// In en, this message translates to:
  /// **'Fat accumulation begins'**
  String get insightWeek17Milestone;

  /// No description provided for @insightWeek17Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Bones'**
  String get insightWeek17Insight1Title;

  /// No description provided for @insightWeek17Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Soft cartilage turns into hard bone.'**
  String get insightWeek17Insight1Content;

  /// No description provided for @insightWeek17Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Umbilical Cord'**
  String get insightWeek17Insight2Title;

  /// No description provided for @insightWeek17Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'It becomes thicker and stronger.'**
  String get insightWeek17Insight2Content;

  /// No description provided for @insightWeek17Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Shoes'**
  String get insightWeek17Insight3Title;

  /// No description provided for @insightWeek17Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Ditch heels for stable shoes.'**
  String get insightWeek17Insight3Content;

  /// No description provided for @insightWeek18FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Bell Pepper'**
  String get insightWeek18FruitTitle;

  /// No description provided for @insightWeek18FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Voluminous and light. Nerves get protection.'**
  String get insightWeek18FruitDescription;

  /// No description provided for @insightWeek18RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Paper Plane'**
  String get insightWeek18RealisticTitle;

  /// No description provided for @insightWeek18RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Dreams launched into flight.'**
  String get insightWeek18RealisticDescription;

  /// No description provided for @insightWeek18GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~14 cm, ~190 g'**
  String get insightWeek18GrowthTitle;

  /// No description provided for @insightWeek18GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a bell pepper. Rapidly putting on weight.'**
  String get insightWeek18GrowthDescription;

  /// No description provided for @insightWeek18BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Nerves are coated in myelin (a protective sheath). Ears move to their final position.'**
  String get insightWeek18BabyDev;

  /// No description provided for @insightWeek18MomBody.
  ///
  /// In en, this message translates to:
  /// **'Many women clearly feel the baby\'s kicks this week.'**
  String get insightWeek18MomBody;

  /// No description provided for @insightWeek18Tip.
  ///
  /// In en, this message translates to:
  /// **'Schedule your mid-pregnancy anatomy scan (weeks 18-21) to check organs in detail.'**
  String get insightWeek18Tip;

  /// No description provided for @insightWeek18Milestone.
  ///
  /// In en, this message translates to:
  /// **'First clear kicks'**
  String get insightWeek18Milestone;

  /// No description provided for @insightWeek18Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'First Kicks'**
  String get insightWeek18Insight1Title;

  /// No description provided for @insightWeek18Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Like a butterfly wing. The first hellos.'**
  String get insightWeek18Insight1Content;

  /// No description provided for @insightWeek18Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Dad'**
  String get insightWeek18Insight2Title;

  /// No description provided for @insightWeek18Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Let him put his hand on your belly too.'**
  String get insightWeek18Insight2Content;

  /// No description provided for @insightWeek18Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Ultrasound'**
  String get insightWeek18Insight3Title;

  /// No description provided for @insightWeek18Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Scheduled scan soon.'**
  String get insightWeek18Insight3Content;

  /// No description provided for @insightWeek19FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Mango'**
  String get insightWeek19FruitTitle;

  /// No description provided for @insightWeek19FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Sweet and exotic. Vernix protects the skin.'**
  String get insightWeek19FruitDescription;

  /// No description provided for @insightWeek19RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Kids Sunglasses'**
  String get insightWeek19RealisticTitle;

  /// No description provided for @insightWeek19RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Protection for the most curious eyes.'**
  String get insightWeek19RealisticDescription;

  /// No description provided for @insightWeek19GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~15 cm, ~240 g'**
  String get insightWeek19GrowthTitle;

  /// No description provided for @insightWeek19GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a mango. Fat tissue is accumulating.'**
  String get insightWeek19GrowthDescription;

  /// No description provided for @insightWeek19BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The skin gets coated with vernix caseosa to prevent it from wrinkling in the amniotic fluid.'**
  String get insightWeek19BabyDev;

  /// No description provided for @insightWeek19MomBody.
  ///
  /// In en, this message translates to:
  /// **'You might notice dark spots or a dark line down your belly (linea nigra). It\'s temporary.'**
  String get insightWeek19MomBody;

  /// No description provided for @insightWeek19Tip.
  ///
  /// In en, this message translates to:
  /// **'Wear sunscreen when going outside; your skin is prone to pigmentation right now.'**
  String get insightWeek19Tip;

  /// No description provided for @insightWeek19Milestone.
  ///
  /// In en, this message translates to:
  /// **'Vernix caseosa appears'**
  String get insightWeek19Milestone;

  /// No description provided for @insightWeek19Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Vernix'**
  String get insightWeek19Insight1Title;

  /// No description provided for @insightWeek19Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Skin is covered with a cheese-like coating.'**
  String get insightWeek19Insight1Content;

  /// No description provided for @insightWeek19Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Hair'**
  String get insightWeek19Insight2Title;

  /// No description provided for @insightWeek19Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'First hairs appear on the head.'**
  String get insightWeek19Insight2Content;

  /// No description provided for @insightWeek19Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get insightWeek19Insight3Title;

  /// No description provided for @insightWeek19Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Start making a list of names.'**
  String get insightWeek19Insight3Content;

  /// No description provided for @insightWeek20FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get insightWeek20FruitTitle;

  /// No description provided for @insightWeek20FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Long and curved. Equator! Halfway there.'**
  String get insightWeek20FruitDescription;

  /// No description provided for @insightWeek20RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Baby Bottle'**
  String get insightWeek20RealisticTitle;

  /// No description provided for @insightWeek20RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A symbol of care. You are needed most.'**
  String get insightWeek20RealisticDescription;

  /// No description provided for @insightWeek20GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~25 cm, ~300 g'**
  String get insightWeek20GrowthTitle;

  /// No description provided for @insightWeek20GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'From this week, height is measured from crown to heel!'**
  String get insightWeek20GrowthDescription;

  /// No description provided for @insightWeek20BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The baby starts swallowing amniotic fluid, practicing digestion and kidney function.'**
  String get insightWeek20BabyDev;

  /// No description provided for @insightWeek20MomBody.
  ///
  /// In en, this message translates to:
  /// **'Happy halfway point! Your uterus has reached the level of your belly button.'**
  String get insightWeek20MomBody;

  /// No description provided for @insightWeek20Tip.
  ///
  /// In en, this message translates to:
  /// **'Check your iron levels. Your doctor may prescribe supplements if needed.'**
  String get insightWeek20Tip;

  /// No description provided for @insightWeek20Milestone.
  ///
  /// In en, this message translates to:
  /// **'Halfway mark!'**
  String get insightWeek20Milestone;

  /// No description provided for @insightWeek20Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Equator'**
  String get insightWeek20Insight1Title;

  /// No description provided for @insightWeek20Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'The uterus has risen to the navel.'**
  String get insightWeek20Insight1Content;

  /// No description provided for @insightWeek20Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Boy or Girl?'**
  String get insightWeek20Insight2Title;

  /// No description provided for @insightWeek20Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Knowing gender can strengthen the bond.'**
  String get insightWeek20Insight2Content;

  /// No description provided for @insightWeek20Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Iron'**
  String get insightWeek20Insight3Title;

  /// No description provided for @insightWeek20Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Blood volume increased. Eat beef or buckwheat.'**
  String get insightWeek20Insight3Content;

  /// No description provided for @insightWeek21FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Carrot'**
  String get insightWeek21FruitTitle;

  /// No description provided for @insightWeek21FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Bright root vegetable. Baby trains digestion.'**
  String get insightWeek21FruitDescription;

  /// No description provided for @insightWeek21RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Pencil Case'**
  String get insightWeek21RealisticTitle;

  /// No description provided for @insightWeek21RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'First drawings and scribbles.'**
  String get insightWeek21RealisticDescription;

  /// No description provided for @insightWeek21GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~26 cm, ~360 g'**
  String get insightWeek21GrowthTitle;

  /// No description provided for @insightWeek21GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The size of a carrot. Weight continues to soar.'**
  String get insightWeek21GrowthDescription;

  /// No description provided for @insightWeek21BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Taste buds are formed. The taste of the fluid changes depending on what mom eats.'**
  String get insightWeek21BabyDev;

  /// No description provided for @insightWeek21MomBody.
  ///
  /// In en, this message translates to:
  /// **'Back strain can cause muscle spasms. Leg cramps at night are common.'**
  String get insightWeek21MomBody;

  /// No description provided for @insightWeek21Tip.
  ///
  /// In en, this message translates to:
  /// **'Eat magnesium and potassium-rich foods (bananas, nuts) to avoid leg cramps.'**
  String get insightWeek21Tip;

  /// No description provided for @insightWeek21Milestone.
  ///
  /// In en, this message translates to:
  /// **'Baby tastes the food'**
  String get insightWeek21Milestone;

  /// No description provided for @insightWeek21Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Tastes'**
  String get insightWeek21Insight1Title;

  /// No description provided for @insightWeek21Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'He swallows fluid and tastes your food.'**
  String get insightWeek21Insight1Content;

  /// No description provided for @insightWeek21Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Dancing'**
  String get insightWeek21Insight2Title;

  /// No description provided for @insightWeek21Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Kicks become strong.'**
  String get insightWeek21Insight2Content;

  /// No description provided for @insightWeek21Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Varicose Veins'**
  String get insightWeek21Insight3Title;

  /// No description provided for @insightWeek21Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Rest with legs raised.'**
  String get insightWeek21Insight3Content;

  /// No description provided for @insightWeek22FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Papaya'**
  String get insightWeek22FruitTitle;

  /// No description provided for @insightWeek22FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Soft tropical fruit. Baby explores itself.'**
  String get insightWeek22FruitDescription;

  /// No description provided for @insightWeek22RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Teddy Bear'**
  String get insightWeek22RealisticTitle;

  /// No description provided for @insightWeek22RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'The faithful friend for sleeping.'**
  String get insightWeek22RealisticDescription;

  /// No description provided for @insightWeek22GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~27 cm, ~430 g'**
  String get insightWeek22GrowthTitle;

  /// No description provided for @insightWeek22GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Weighing nearly half a kilo! The size of a papaya.'**
  String get insightWeek22GrowthDescription;

  /// No description provided for @insightWeek22BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Sense of touch improves. The baby touches their face, pulls the cord, and sucks their thumb.'**
  String get insightWeek22BabyDev;

  /// No description provided for @insightWeek22MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your uterus continues to grow, stretching the skin. Your belly might itch.'**
  String get insightWeek22MomBody;

  /// No description provided for @insightWeek22Tip.
  ///
  /// In en, this message translates to:
  /// **'If your belly itches, slather it with stretch mark oil or a moisturizing lotion.'**
  String get insightWeek22Tip;

  /// No description provided for @insightWeek22Milestone.
  ///
  /// In en, this message translates to:
  /// **'Sense of touch develops'**
  String get insightWeek22Milestone;

  /// No description provided for @insightWeek22Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Touch'**
  String get insightWeek22Insight1Title;

  /// No description provided for @insightWeek22Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'He touches his face, legs, and cord.'**
  String get insightWeek22Insight1Content;

  /// No description provided for @insightWeek22Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Photoshoot'**
  String get insightWeek22Insight2Title;

  /// No description provided for @insightWeek22Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Perfect time for memory photos.'**
  String get insightWeek22Insight2Content;

  /// No description provided for @insightWeek22Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Emotions'**
  String get insightWeek22Insight3Title;

  /// No description provided for @insightWeek22Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'He feels your mood.'**
  String get insightWeek22Insight3Content;

  /// No description provided for @insightWeek23FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Grapefruit'**
  String get insightWeek23FruitTitle;

  /// No description provided for @insightWeek23FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Large citrus. Baby hears external sounds.'**
  String get insightWeek23FruitDescription;

  /// No description provided for @insightWeek23RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'First Sneaker'**
  String get insightWeek23RealisticTitle;

  /// No description provided for @insightWeek23RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'For those very first unsure steps.'**
  String get insightWeek23RealisticDescription;

  /// No description provided for @insightWeek23GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~28 cm, ~500 g'**
  String get insightWeek23GrowthTitle;

  /// No description provided for @insightWeek23GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'A major milestone: the baby reached 500 grams.'**
  String get insightWeek23GrowthDescription;

  /// No description provided for @insightWeek23BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Lungs begin to produce surfactant — a substance that keeps air sacs from collapsing after birth.'**
  String get insightWeek23BabyDev;

  /// No description provided for @insightWeek23MomBody.
  ///
  /// In en, this message translates to:
  /// **'You might experience Braxton Hicks contractions (painless tightening of the belly).'**
  String get insightWeek23MomBody;

  /// No description provided for @insightWeek23Tip.
  ///
  /// In en, this message translates to:
  /// **'Start doing Kegel exercises. They help avoid tearing during labor and speed up recovery.'**
  String get insightWeek23Tip;

  /// No description provided for @insightWeek23Milestone.
  ///
  /// In en, this message translates to:
  /// **'Surfactant production in lungs'**
  String get insightWeek23Milestone;

  /// No description provided for @insightWeek23Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get insightWeek23Insight1Title;

  /// No description provided for @insightWeek23Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'He \'inhales\' fluid, training lungs.'**
  String get insightWeek23Insight1Content;

  /// No description provided for @insightWeek23Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Rhythm'**
  String get insightWeek23Insight2Title;

  /// No description provided for @insightWeek23Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Baby moves to the beat of music.'**
  String get insightWeek23Insight2Content;

  /// No description provided for @insightWeek23Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get insightWeek23Insight3Title;

  /// No description provided for @insightWeek23Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Swelling may worsen. Drink clean water.'**
  String get insightWeek23Insight3Content;

  /// No description provided for @insightWeek24FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Ear of Corn'**
  String get insightWeek24FruitTitle;

  /// No description provided for @insightWeek24FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Golden and ripe. Face is fully formed.'**
  String get insightWeek24FruitDescription;

  /// No description provided for @insightWeek24RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'School Ruler'**
  String get insightWeek24RealisticTitle;

  /// No description provided for @insightWeek24RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'He grows and gathers strength.'**
  String get insightWeek24RealisticDescription;

  /// No description provided for @insightWeek24GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~30 cm, ~600 g'**
  String get insightWeek24GrowthTitle;

  /// No description provided for @insightWeek24GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Length has reached 30 cm (size of corn).'**
  String get insightWeek24GrowthDescription;

  /// No description provided for @insightWeek24BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The baby\'s face is formed: eyelashes, eyebrows, hair. The body is still quite thin.'**
  String get insightWeek24BabyDev;

  /// No description provided for @insightWeek24MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your belly button might pop out. Uterine pressure can cause heartburn.'**
  String get insightWeek24MomBody;

  /// No description provided for @insightWeek24Tip.
  ///
  /// In en, this message translates to:
  /// **'Between weeks 24 and 28, it\'s crucial to take the glucose tolerance test for gestational diabetes.'**
  String get insightWeek24Tip;

  /// No description provided for @insightWeek24Milestone.
  ///
  /// In en, this message translates to:
  /// **'Age of viability'**
  String get insightWeek24Milestone;

  /// No description provided for @insightWeek24Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Viability'**
  String get insightWeek24Insight1Title;

  /// No description provided for @insightWeek24Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Important milestone. Baby can survive outside.'**
  String get insightWeek24Insight1Content;

  /// No description provided for @insightWeek24Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Face'**
  String get insightWeek24Insight2Title;

  /// No description provided for @insightWeek24Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Eyelashes, brows, nose — all in place.'**
  String get insightWeek24Insight2Content;

  /// No description provided for @insightWeek24Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Glucose Test'**
  String get insightWeek24Insight3Title;

  /// No description provided for @insightWeek24Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Important to check sugar levels.'**
  String get insightWeek24Insight3Content;

  /// No description provided for @insightWeek25FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Cauliflower'**
  String get insightWeek25FruitTitle;

  /// No description provided for @insightWeek25FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Lush floret. Skin smooths out.'**
  String get insightWeek25FruitDescription;

  /// No description provided for @insightWeek25RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Baseball Glove'**
  String get insightWeek25RealisticTitle;

  /// No description provided for @insightWeek25RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Being part of a team with mom and dad.'**
  String get insightWeek25RealisticDescription;

  /// No description provided for @insightWeek25GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~34 cm, ~660 g'**
  String get insightWeek25GrowthTitle;

  /// No description provided for @insightWeek25GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Gaining mass quickly, skin is smoothing out.'**
  String get insightWeek25GrowthDescription;

  /// No description provided for @insightWeek25BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Blood vessels form in the lungs. The baby gains fat, and the skin turns pink.'**
  String get insightWeek25BabyDev;

  /// No description provided for @insightWeek25MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your hair looks amazing! It barely falls out thanks to high estrogen levels.'**
  String get insightWeek25MomBody;

  /// No description provided for @insightWeek25Tip.
  ///
  /// In en, this message translates to:
  /// **'If you get restless leg syndrome before bed, have your iron (ferritin) checked.'**
  String get insightWeek25Tip;

  /// No description provided for @insightWeek25Milestone.
  ///
  /// In en, this message translates to:
  /// **'Fat accumulation'**
  String get insightWeek25Milestone;

  /// No description provided for @insightWeek25Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Capillaries'**
  String get insightWeek25Insight1Title;

  /// No description provided for @insightWeek25Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Skin turns pink.'**
  String get insightWeek25Insight1Content;

  /// No description provided for @insightWeek25Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Hair'**
  String get insightWeek25Insight2Title;

  /// No description provided for @insightWeek25Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Your hair becomes thick and shiny.'**
  String get insightWeek25Insight2Content;

  /// No description provided for @insightWeek25Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get insightWeek25Insight3Title;

  /// No description provided for @insightWeek25Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Center of gravity shifted. Yoga helps.'**
  String get insightWeek25Insight3Content;

  /// No description provided for @insightWeek26FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Zucchini'**
  String get insightWeek26FruitTitle;

  /// No description provided for @insightWeek26FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Smooth and growing. Eyes open!'**
  String get insightWeek26FruitDescription;

  /// No description provided for @insightWeek26RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Folded Umbrella'**
  String get insightWeek26RealisticTitle;

  /// No description provided for @insightWeek26RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Protection from weather and fun jumps.'**
  String get insightWeek26RealisticDescription;

  /// No description provided for @insightWeek26GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~35 cm, ~760 g'**
  String get insightWeek26GrowthTitle;

  /// No description provided for @insightWeek26GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Surpassed 700 grams. The baby is getting rounder.'**
  String get insightWeek26GrowthDescription;

  /// No description provided for @insightWeek26BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The baby opens their eyes for the first time! Irises are blue/grey; color will change later.'**
  String get insightWeek26BabyDev;

  /// No description provided for @insightWeek26MomBody.
  ///
  /// In en, this message translates to:
  /// **'The bump is growing fast. You might feel breathless even walking up short stairs.'**
  String get insightWeek26MomBody;

  /// No description provided for @insightWeek26Tip.
  ///
  /// In en, this message translates to:
  /// **'It\'s time to start researching hospitals and doctors if you plan to hire a private team.'**
  String get insightWeek26Tip;

  /// No description provided for @insightWeek26Milestone.
  ///
  /// In en, this message translates to:
  /// **'Baby opens their eyes'**
  String get insightWeek26Milestone;

  /// No description provided for @insightWeek26Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Eyes'**
  String get insightWeek26Insight1Title;

  /// No description provided for @insightWeek26Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Eyelids open. He blinks.'**
  String get insightWeek26Insight1Content;

  /// No description provided for @insightWeek26Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get insightWeek26Insight2Title;

  /// No description provided for @insightWeek26Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'He remembers voices.'**
  String get insightWeek26Insight2Content;

  /// No description provided for @insightWeek26Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Rings'**
  String get insightWeek26Insight3Title;

  /// No description provided for @insightWeek26Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Fingers may swell. Remove rings.'**
  String get insightWeek26Insight3Content;

  /// No description provided for @insightWeek27FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Cabbage'**
  String get insightWeek27FruitTitle;

  /// No description provided for @insightWeek27FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Many layers. Brain develops actively.'**
  String get insightWeek27FruitDescription;

  /// No description provided for @insightWeek27RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Lunchbox'**
  String get insightWeek27RealisticTitle;

  /// No description provided for @insightWeek27RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Care you will pack for him to school.'**
  String get insightWeek27RealisticDescription;

  /// No description provided for @insightWeek27GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~36 cm, ~870 g'**
  String get insightWeek27GrowthTitle;

  /// No description provided for @insightWeek27GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Approaching the 1 kilogram mark!'**
  String get insightWeek27GrowthDescription;

  /// No description provided for @insightWeek27BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The brain gets its grooves. The baby dreams and might rhythmically hiccup.'**
  String get insightWeek27BabyDev;

  /// No description provided for @insightWeek27MomBody.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the third trimester! The uterus pushes up against your ribcage.'**
  String get insightWeek27MomBody;

  /// No description provided for @insightWeek27Tip.
  ///
  /// In en, this message translates to:
  /// **'Start learning breathing techniques for labor — it\'s your best natural pain relief.'**
  String get insightWeek27Tip;

  /// No description provided for @insightWeek27Milestone.
  ///
  /// In en, this message translates to:
  /// **'Start of the third trimester'**
  String get insightWeek27Milestone;

  /// No description provided for @insightWeek27Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Home Stretch'**
  String get insightWeek27Insight1Title;

  /// No description provided for @insightWeek27Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the third trimester!'**
  String get insightWeek27Insight1Content;

  /// No description provided for @insightWeek27Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Dreams'**
  String get insightWeek27Insight2Title;

  /// No description provided for @insightWeek27Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Anxious dreams are normal rehearsal.'**
  String get insightWeek27Insight2Content;

  /// No description provided for @insightWeek27Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Hiccups'**
  String get insightWeek27Insight3Title;

  /// No description provided for @insightWeek27Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Rhythmic twitching? Baby is hiccuping.'**
  String get insightWeek27Insight3Content;

  /// No description provided for @insightWeek28FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Eggplant'**
  String get insightWeek28FruitTitle;

  /// No description provided for @insightWeek28FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Glossy and dark. Getting tight.'**
  String get insightWeek28FruitDescription;

  /// No description provided for @insightWeek28RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Drawing Tablet'**
  String get insightWeek28RealisticTitle;

  /// No description provided for @insightWeek28RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A space for fantasy.'**
  String get insightWeek28RealisticDescription;

  /// No description provided for @insightWeek28GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~37 cm, ~1000 g'**
  String get insightWeek28GrowthTitle;

  /// No description provided for @insightWeek28GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Hit 1 kilogram! A highly significant milestone.'**
  String get insightWeek28GrowthDescription;

  /// No description provided for @insightWeek28BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Weight crosses 1 kilogram (2.2 lbs). Eyelashes appear. They distinguish light and shadows.'**
  String get insightWeek28BabyDev;

  /// No description provided for @insightWeek28MomBody.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure might rise slightly. Your doctor will watch for protein in your urine.'**
  String get insightWeek28MomBody;

  /// No description provided for @insightWeek28Tip.
  ///
  /// In en, this message translates to:
  /// **'Start counting kicks daily. Use the Kick Counter in our Care Center.'**
  String get insightWeek28Tip;

  /// No description provided for @insightWeek28Milestone.
  ///
  /// In en, this message translates to:
  /// **'Weight crosses 1 kilogram'**
  String get insightWeek28Milestone;

  /// No description provided for @insightWeek28Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get insightWeek28Insight1Title;

  /// No description provided for @insightWeek28Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Baby weighs over 1 kg.'**
  String get insightWeek28Insight1Content;

  /// No description provided for @insightWeek28Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Rh Factor'**
  String get insightWeek28Insight2Title;

  /// No description provided for @insightWeek28Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Doctor may prescribe immunoglobulin.'**
  String get insightWeek28Insight2Content;

  /// No description provided for @insightWeek28Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Kick Counter'**
  String get insightWeek28Insight3Title;

  /// No description provided for @insightWeek28Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Start tracking activity.'**
  String get insightWeek28Insight3Content;

  /// No description provided for @insightWeek29FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Butternut Squash'**
  String get insightWeek29FruitTitle;

  /// No description provided for @insightWeek29FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Firm and sweet. Heat regulation starts.'**
  String get insightWeek29FruitDescription;

  /// No description provided for @insightWeek29RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Ukulele'**
  String get insightWeek29RealisticTitle;

  /// No description provided for @insightWeek29RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A small instrument for big songs.'**
  String get insightWeek29RealisticDescription;

  /// No description provided for @insightWeek29GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~38 cm, ~1150 g'**
  String get insightWeek29GrowthTitle;

  /// No description provided for @insightWeek29GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Around 38 cm long. Space is getting tight.'**
  String get insightWeek29GrowthDescription;

  /// No description provided for @insightWeek29BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The baby starts producing their own immunity. Bones get harder.'**
  String get insightWeek29BabyDev;

  /// No description provided for @insightWeek29MomBody.
  ///
  /// In en, this message translates to:
  /// **'The growing uterus can press on veins, causing hemorrhoids or varicose veins. Eat fiber.'**
  String get insightWeek29MomBody;

  /// No description provided for @insightWeek29Tip.
  ///
  /// In en, this message translates to:
  /// **'Prepare a baby first-aid kit and a basic newborn care set.'**
  String get insightWeek29Tip;

  /// No description provided for @insightWeek29Milestone.
  ///
  /// In en, this message translates to:
  /// **'Thermoregulation starts'**
  String get insightWeek29Milestone;

  /// No description provided for @insightWeek29Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Warmth'**
  String get insightWeek29Insight1Title;

  /// No description provided for @insightWeek29Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Brain learns to regulate temperature.'**
  String get insightWeek29Insight1Content;

  /// No description provided for @insightWeek29Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Calcium'**
  String get insightWeek29Insight2Title;

  /// No description provided for @insightWeek29Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Baby takes calcium for bones.'**
  String get insightWeek29Insight2Content;

  /// No description provided for @insightWeek29Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get insightWeek29Insight3Title;

  /// No description provided for @insightWeek29Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Desire to nap returned?'**
  String get insightWeek29Insight3Content;

  /// No description provided for @insightWeek30FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Cantaloupe'**
  String get insightWeek30FruitTitle;

  /// No description provided for @insightWeek30FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Fragrant melon. Lanugo disappears.'**
  String get insightWeek30FruitDescription;

  /// No description provided for @insightWeek30RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Winter Hat'**
  String get insightWeek30RealisticTitle;

  /// No description provided for @insightWeek30RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Warmth for long walks.'**
  String get insightWeek30RealisticDescription;

  /// No description provided for @insightWeek30GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~39 cm, ~1300 g'**
  String get insightWeek30GrowthTitle;

  /// No description provided for @insightWeek30GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Weighs 1.3 kg (the size of a large cabbage).'**
  String get insightWeek30GrowthDescription;

  /// No description provided for @insightWeek30BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The fine hair (lanugo) begins to shed. Skin gets smoother and lighter.'**
  String get insightWeek30BabyDev;

  /// No description provided for @insightWeek30MomBody.
  ///
  /// In en, this message translates to:
  /// **'Maternity leave is near! Back and leg fatigue by evening becomes the usual.'**
  String get insightWeek30MomBody;

  /// No description provided for @insightWeek30Tip.
  ///
  /// In en, this message translates to:
  /// **'Time to pack your hospital bag. Go through the checklist in our app.'**
  String get insightWeek30Tip;

  /// No description provided for @insightWeek30Milestone.
  ///
  /// In en, this message translates to:
  /// **'Lanugo shedding'**
  String get insightWeek30Milestone;

  /// No description provided for @insightWeek30Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Skin'**
  String get insightWeek30Insight1Title;

  /// No description provided for @insightWeek30Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Body fuzz (lanugo) disappears.'**
  String get insightWeek30Insight1Content;

  /// No description provided for @insightWeek30Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Nesting'**
  String get insightWeek30Insight2Title;

  /// No description provided for @insightWeek30Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Urge to clean is an instinct.'**
  String get insightWeek30Insight2Content;

  /// No description provided for @insightWeek30Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Shoes'**
  String get insightWeek30Insight3Title;

  /// No description provided for @insightWeek30Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Feet might grow a size due to swelling.'**
  String get insightWeek30Insight3Content;

  /// No description provided for @insightWeek31FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Pineapple'**
  String get insightWeek31FruitTitle;

  /// No description provided for @insightWeek31FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Brain works at full capacity.'**
  String get insightWeek31FruitDescription;

  /// No description provided for @insightWeek31RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Soccer Ball'**
  String get insightWeek31RealisticTitle;

  /// No description provided for @insightWeek31RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'First goal and pride of a winner.'**
  String get insightWeek31RealisticDescription;

  /// No description provided for @insightWeek31GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~41 cm, ~1500 g'**
  String get insightWeek31GrowthTitle;

  /// No description provided for @insightWeek31GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'1.5 kilograms! Active growth continues unabated.'**
  String get insightWeek31GrowthDescription;

  /// No description provided for @insightWeek31BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Brain volume increases, neural connections form at lightning speed. They react to light and dark.'**
  String get insightWeek31BabyDev;

  /// No description provided for @insightWeek31MomBody.
  ///
  /// In en, this message translates to:
  /// **'Breasts begin producing colostrum (a yellowish fluid). Breathing is harder.'**
  String get insightWeek31MomBody;

  /// No description provided for @insightWeek31Tip.
  ///
  /// In en, this message translates to:
  /// **'If you experience severe shortness of breath, try sleeping propped up on a few pillows.'**
  String get insightWeek31Tip;

  /// No description provided for @insightWeek31Milestone.
  ///
  /// In en, this message translates to:
  /// **'Brain development leap'**
  String get insightWeek31Milestone;

  /// No description provided for @insightWeek31Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Brain'**
  String get insightWeek31Insight1Title;

  /// No description provided for @insightWeek31Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Neural connections form at huge speed.'**
  String get insightWeek31Insight1Content;

  /// No description provided for @insightWeek31Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Breathing'**
  String get insightWeek31Insight2Title;

  /// No description provided for @insightWeek31Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Shortness of breath may occur.'**
  String get insightWeek31Insight2Content;

  /// No description provided for @insightWeek31Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Colostrum'**
  String get insightWeek31Insight3Title;

  /// No description provided for @insightWeek31Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Liquid may leak from breasts.'**
  String get insightWeek31Insight3Content;

  /// No description provided for @insightWeek32FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Napa Cabbage'**
  String get insightWeek32FruitTitle;

  /// No description provided for @insightWeek32FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Soft leaves. Baby turns head down.'**
  String get insightWeek32FruitDescription;

  /// No description provided for @insightWeek32RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Thick Storybook'**
  String get insightWeek32RealisticTitle;

  /// No description provided for @insightWeek32RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Stories teaching kindness.'**
  String get insightWeek32RealisticDescription;

  /// No description provided for @insightWeek32GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~42 cm, ~1700 g'**
  String get insightWeek32GrowthTitle;

  /// No description provided for @insightWeek32GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'From crown to heel, length is about 42 cm.'**
  String get insightWeek32GrowthDescription;

  /// No description provided for @insightWeek32BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Most babies settle into the starting position by now — head down.'**
  String get insightWeek32BabyDev;

  /// No description provided for @insightWeek32MomBody.
  ///
  /// In en, this message translates to:
  /// **'Circulation is slow. Foot swelling by the evening is your new normal.'**
  String get insightWeek32MomBody;

  /// No description provided for @insightWeek32Tip.
  ///
  /// In en, this message translates to:
  /// **'If the baby is still breech, your doctor might recommend special exercises.'**
  String get insightWeek32Tip;

  /// No description provided for @insightWeek32Milestone.
  ///
  /// In en, this message translates to:
  /// **'Head-down position'**
  String get insightWeek32Milestone;

  /// No description provided for @insightWeek32Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get insightWeek32Insight1Title;

  /// No description provided for @insightWeek32Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Most likely, he turned head down.'**
  String get insightWeek32Insight1Content;

  /// No description provided for @insightWeek32Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get insightWeek32Insight2Title;

  /// No description provided for @insightWeek32Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Learn breathing techniques.'**
  String get insightWeek32Insight2Content;

  /// No description provided for @insightWeek32Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Visits'**
  String get insightWeek32Insight3Title;

  /// No description provided for @insightWeek32Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Doctor visits become more frequent.'**
  String get insightWeek32Insight3Content;

  /// No description provided for @insightWeek33FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Durian'**
  String get insightWeek33FruitTitle;

  /// No description provided for @insightWeek33FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'King of fruits. Immunity is strong.'**
  String get insightWeek33FruitDescription;

  /// No description provided for @insightWeek33RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleeping Bag'**
  String get insightWeek33RealisticTitle;

  /// No description provided for @insightWeek33RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Camping and starry skies.'**
  String get insightWeek33RealisticDescription;

  /// No description provided for @insightWeek33GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~43 cm, ~1900 g'**
  String get insightWeek33GrowthTitle;

  /// No description provided for @insightWeek33GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Nearly 2 kilograms. The size of a pineapple.'**
  String get insightWeek33GrowthDescription;

  /// No description provided for @insightWeek33BabyDev.
  ///
  /// In en, this message translates to:
  /// **'The baby receives your antibodies through the placenta. Bones are fully hardened, except the skull.'**
  String get insightWeek33BabyDev;

  /// No description provided for @insightWeek33MomBody.
  ///
  /// In en, this message translates to:
  /// **'Insomnia might peak. It\'s hard to find a comfy position with a huge belly.'**
  String get insightWeek33MomBody;

  /// No description provided for @insightWeek33Tip.
  ///
  /// In en, this message translates to:
  /// **'Finish all major purchases. Wash and iron the baby clothes.'**
  String get insightWeek33Tip;

  /// No description provided for @insightWeek33Milestone.
  ///
  /// In en, this message translates to:
  /// **'Immune system ready'**
  String get insightWeek33Milestone;

  /// No description provided for @insightWeek33Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Immunity'**
  String get insightWeek33Insight1Title;

  /// No description provided for @insightWeek33Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'You pass your antibodies to him.'**
  String get insightWeek33Insight1Content;

  /// No description provided for @insightWeek33Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Hospital Bag'**
  String get insightWeek33Insight2Title;

  /// No description provided for @insightWeek33Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Start packing.'**
  String get insightWeek33Insight2Content;

  /// No description provided for @insightWeek33Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Heartburn'**
  String get insightWeek33Insight3Title;

  /// No description provided for @insightWeek33Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Eat often but in small portions.'**
  String get insightWeek33Insight3Content;

  /// No description provided for @insightWeek34FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Muscat Squash'**
  String get insightWeek34FruitTitle;

  /// No description provided for @insightWeek34FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Ribbed squash. Lungs are ready.'**
  String get insightWeek34FruitDescription;

  /// No description provided for @insightWeek34RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Violin'**
  String get insightWeek34RealisticTitle;

  /// No description provided for @insightWeek34RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'A subtle soul and persistence.'**
  String get insightWeek34RealisticDescription;

  /// No description provided for @insightWeek34GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~45 cm, ~2100 g'**
  String get insightWeek34GrowthTitle;

  /// No description provided for @insightWeek34GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The baby weighs over 2 kilograms!'**
  String get insightWeek34GrowthDescription;

  /// No description provided for @insightWeek34BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Central nervous system is mature. Lungs have enough surfactant to breathe.'**
  String get insightWeek34BabyDev;

  /// No description provided for @insightWeek34MomBody.
  ///
  /// In en, this message translates to:
  /// **'Eyes might feel dry or vision slightly blurry. It will pass after birth.'**
  String get insightWeek34MomBody;

  /// No description provided for @insightWeek34Tip.
  ///
  /// In en, this message translates to:
  /// **'Discuss your birth plan with your doctor: pain relief, interventions, and cord clamping.'**
  String get insightWeek34Tip;

  /// No description provided for @insightWeek34Milestone.
  ///
  /// In en, this message translates to:
  /// **'Lungs can breathe independently'**
  String get insightWeek34Milestone;

  /// No description provided for @insightWeek34Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Lungs'**
  String get insightWeek34Insight1Title;

  /// No description provided for @insightWeek34Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'They are almost mature.'**
  String get insightWeek34Insight1Content;

  /// No description provided for @insightWeek34Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Slow Down'**
  String get insightWeek34Insight2Title;

  /// No description provided for @insightWeek34Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Allow yourself to be lazy.'**
  String get insightWeek34Insight2Content;

  /// No description provided for @insightWeek34Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Vision'**
  String get insightWeek34Insight3Title;

  /// No description provided for @insightWeek34Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Pupils react to light.'**
  String get insightWeek34Insight3Content;

  /// No description provided for @insightWeek35FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Honeydew Melon'**
  String get insightWeek35FruitTitle;

  /// No description provided for @insightWeek35FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Smooth and sweet. Rounding out.'**
  String get insightWeek35FruitDescription;

  /// No description provided for @insightWeek35RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Bicycle Helmet'**
  String get insightWeek35RealisticTitle;

  /// No description provided for @insightWeek35RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Safety in first adventures.'**
  String get insightWeek35RealisticDescription;

  /// No description provided for @insightWeek35GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~46 cm, ~2300 g'**
  String get insightWeek35GrowthTitle;

  /// No description provided for @insightWeek35GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Rapid mass gain—about 200 grams per week.'**
  String get insightWeek35GrowthDescription;

  /// No description provided for @insightWeek35BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Gaining 200-300 grams a week. Arms and legs are getting chubby.'**
  String get insightWeek35BabyDev;

  /// No description provided for @insightWeek35MomBody.
  ///
  /// In en, this message translates to:
  /// **'Bladder is so squished that bathroom trips every 30 mins are not a joke.'**
  String get insightWeek35MomBody;

  /// No description provided for @insightWeek35Tip.
  ///
  /// In en, this message translates to:
  /// **'Install the car seat. Adjusting straps with a crying newborn in your arms is tough.'**
  String get insightWeek35Tip;

  /// No description provided for @insightWeek35Milestone.
  ///
  /// In en, this message translates to:
  /// **'Active fat accumulation'**
  String get insightWeek35Milestone;

  /// No description provided for @insightWeek35Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Chubby'**
  String get insightWeek35Insight1Title;

  /// No description provided for @insightWeek35Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'He gains 200-300 grams a week.'**
  String get insightWeek35Insight1Content;

  /// No description provided for @insightWeek35Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Birth Plan'**
  String get insightWeek35Insight2Title;

  /// No description provided for @insightWeek35Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Discuss your wishes with the doctor.'**
  String get insightWeek35Insight2Content;

  /// No description provided for @insightWeek35Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Restroom'**
  String get insightWeek35Insight3Title;

  /// No description provided for @insightWeek35Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Frequent runs? Baby presses on bladder.'**
  String get insightWeek35Insight3Content;

  /// No description provided for @insightWeek36FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Romaine Lettuce'**
  String get insightWeek36FruitTitle;

  /// No description provided for @insightWeek36FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Large and fresh. Belly drops.'**
  String get insightWeek36FruitDescription;

  /// No description provided for @insightWeek36RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Keyboard'**
  String get insightWeek36RealisticTitle;

  /// No description provided for @insightWeek36RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'First written stories or code.'**
  String get insightWeek36RealisticDescription;

  /// No description provided for @insightWeek36GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~47 cm, ~2600 g'**
  String get insightWeek36GrowthTitle;

  /// No description provided for @insightWeek36GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Almost ready! Very plump and adorable.'**
  String get insightWeek36GrowthDescription;

  /// No description provided for @insightWeek36BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Digestive system is fully ready for mom\'s milk. The skull remains soft.'**
  String get insightWeek36BabyDev;

  /// No description provided for @insightWeek36MomBody.
  ///
  /// In en, this message translates to:
  /// **'Your belly might \'drop\' as baby moves into the pelvis. Breathing gets easier, walking gets harder.'**
  String get insightWeek36MomBody;

  /// No description provided for @insightWeek36Tip.
  ///
  /// In en, this message translates to:
  /// **'Ensure all documents (ID, medical records) are in your bag. From this week on, be ready.'**
  String get insightWeek36Tip;

  /// No description provided for @insightWeek36Milestone.
  ///
  /// In en, this message translates to:
  /// **'Belly dropping'**
  String get insightWeek36Milestone;

  /// No description provided for @insightWeek36Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Dropping'**
  String get insightWeek36Insight1Title;

  /// No description provided for @insightWeek36Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Breathing gets easier, walking harder.'**
  String get insightWeek36Insight1Content;

  /// No description provided for @insightWeek36Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Skull Bones'**
  String get insightWeek36Insight2Title;

  /// No description provided for @insightWeek36Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Skull remains soft for birth.'**
  String get insightWeek36Insight2Content;

  /// No description provided for @insightWeek36Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'CTG'**
  String get insightWeek36Insight3Title;

  /// No description provided for @insightWeek36Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Weekly heartbeat checks.'**
  String get insightWeek36Insight3Content;

  /// No description provided for @insightWeek37FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Beetroot'**
  String get insightWeek37FruitTitle;

  /// No description provided for @insightWeek37FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Strong root. Fully ready for life.'**
  String get insightWeek37FruitDescription;

  /// No description provided for @insightWeek37RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get insightWeek37RealisticTitle;

  /// No description provided for @insightWeek37RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Capturing the best moments.'**
  String get insightWeek37RealisticDescription;

  /// No description provided for @insightWeek37GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~48 cm, ~2800 g'**
  String get insightWeek37GrowthTitle;

  /// No description provided for @insightWeek37GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy is officially full term.'**
  String get insightWeek37GrowthDescription;

  /// No description provided for @insightWeek37BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy is officially full-term! All systems are ready for independent life.'**
  String get insightWeek37BabyDev;

  /// No description provided for @insightWeek37MomBody.
  ///
  /// In en, this message translates to:
  /// **'The mucus plug might pass. Practice contractions become more regular.'**
  String get insightWeek37MomBody;

  /// No description provided for @insightWeek37Tip.
  ///
  /// In en, this message translates to:
  /// **'Remove nail polish or use clear gloss — doctors need to see your nail beds during labor.'**
  String get insightWeek37Tip;

  /// No description provided for @insightWeek37Milestone.
  ///
  /// In en, this message translates to:
  /// **'Full-term pregnancy'**
  String get insightWeek37Milestone;

  /// No description provided for @insightWeek37Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Full Term'**
  String get insightWeek37Insight1Title;

  /// No description provided for @insightWeek37Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Congrats! You can give birth anytime.'**
  String get insightWeek37Insight1Content;

  /// No description provided for @insightWeek37Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Plug'**
  String get insightWeek37Insight2Title;

  /// No description provided for @insightWeek37Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Loss of mucus plug is a sign.'**
  String get insightWeek37Insight2Content;

  /// No description provided for @insightWeek37Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get insightWeek37Insight3Title;

  /// No description provided for @insightWeek37Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Check route to hospital.'**
  String get insightWeek37Insight3Content;

  /// No description provided for @insightWeek38FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Leek'**
  String get insightWeek38FruitTitle;

  /// No description provided for @insightWeek38FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Long stalk. Learning patience.'**
  String get insightWeek38FruitDescription;

  /// No description provided for @insightWeek38RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Skateboard'**
  String get insightWeek38RealisticTitle;

  /// No description provided for @insightWeek38RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Courage to fall and get back up.'**
  String get insightWeek38RealisticDescription;

  /// No description provided for @insightWeek38GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~49 cm, ~3000 g'**
  String get insightWeek38GrowthTitle;

  /// No description provided for @insightWeek38GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'The crucial 3 kilogram milestone has been passed!'**
  String get insightWeek38GrowthDescription;

  /// No description provided for @insightWeek38BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Intestines are filled with meconium (first stool). The head is deep in the pelvis.'**
  String get insightWeek38BabyDev;

  /// No description provided for @insightWeek38MomBody.
  ///
  /// In en, this message translates to:
  /// **'Hard to stand, lie down, or sit. The wait drives you crazy. \'Nesting\' cleaning bursts happen.'**
  String get insightWeek38MomBody;

  /// No description provided for @insightWeek38Tip.
  ///
  /// In en, this message translates to:
  /// **'Rest in advance. Sleep as if it\'s your last week of sleep (it might well be).'**
  String get insightWeek38Tip;

  /// No description provided for @insightWeek38Milestone.
  ///
  /// In en, this message translates to:
  /// **'Meconium accumulation'**
  String get insightWeek38Milestone;

  /// No description provided for @insightWeek38Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Contractions'**
  String get insightWeek38Insight1Title;

  /// No description provided for @insightWeek38Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Braxton Hicks may get stronger.'**
  String get insightWeek38Insight1Content;

  /// No description provided for @insightWeek38Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get insightWeek38Insight2Title;

  /// No description provided for @insightWeek38Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Turn off notifications about \'when?\'.'**
  String get insightWeek38Insight2Content;

  /// No description provided for @insightWeek38Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Eye Color'**
  String get insightWeek38Insight3Title;

  /// No description provided for @insightWeek38Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Most babies born with blue/gray eyes.'**
  String get insightWeek38Insight3Content;

  /// No description provided for @insightWeek39FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Watermelon'**
  String get insightWeek39FruitTitle;

  /// No description provided for @insightWeek39FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Heavy and ripe. Quieting down.'**
  String get insightWeek39FruitDescription;

  /// No description provided for @insightWeek39RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Globe'**
  String get insightWeek39RealisticTitle;

  /// No description provided for @insightWeek39RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'The whole world at his feet.'**
  String get insightWeek39RealisticDescription;

  /// No description provided for @insightWeek39GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~50 cm, ~3200 g'**
  String get insightWeek39GrowthTitle;

  /// No description provided for @insightWeek39GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Half a meter long. Ideal proportions of a newborn.'**
  String get insightWeek39GrowthDescription;

  /// No description provided for @insightWeek39BabyDev.
  ///
  /// In en, this message translates to:
  /// **'No room to move. Kicks are replaced by poking out a bum or elbow.'**
  String get insightWeek39BabyDev;

  /// No description provided for @insightWeek39MomBody.
  ///
  /// In en, this message translates to:
  /// **'The cervix begins to efface (shorten) and soften, preparing to dilate.'**
  String get insightWeek39MomBody;

  /// No description provided for @insightWeek39Tip.
  ///
  /// In en, this message translates to:
  /// **'Review signs of true labor: regular, intensifying contractions <5 mins apart, or water breaking.'**
  String get insightWeek39Tip;

  /// No description provided for @insightWeek39Milestone.
  ///
  /// In en, this message translates to:
  /// **'Cervix preparation'**
  String get insightWeek39Milestone;

  /// No description provided for @insightWeek39Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Quiet'**
  String get insightWeek39Insight1Title;

  /// No description provided for @insightWeek39Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Baby saves energy for birth.'**
  String get insightWeek39Insight1Content;

  /// No description provided for @insightWeek39Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get insightWeek39Insight2Title;

  /// No description provided for @insightWeek39Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Sleep, read, watch movies.'**
  String get insightWeek39Insight2Content;

  /// No description provided for @insightWeek39Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Cervix'**
  String get insightWeek39Insight3Title;

  /// No description provided for @insightWeek39Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Cervix is thinning and dilating.'**
  String get insightWeek39Insight3Content;

  /// No description provided for @insightWeek40FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Pumpkin'**
  String get insightWeek40FruitTitle;

  /// No description provided for @insightWeek40FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Festive and huge. Ready for D-Day.'**
  String get insightWeek40FruitDescription;

  /// No description provided for @insightWeek40RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'First Onesie'**
  String get insightWeek40RealisticTitle;

  /// No description provided for @insightWeek40RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Soon you will hug him for real.'**
  String get insightWeek40RealisticDescription;

  /// No description provided for @insightWeek40GrowthTitle.
  ///
  /// In en, this message translates to:
  /// **'~51 cm, ~3400+ g'**
  String get insightWeek40GrowthTitle;

  /// No description provided for @insightWeek40GrowthDescription.
  ///
  /// In en, this message translates to:
  /// **'Average size of a fully developed newborn baby.'**
  String get insightWeek40GrowthDescription;

  /// No description provided for @insightWeek40BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Weight can reach 3.5 kg or more. Fully formed and waiting for the signal to be born.'**
  String get insightWeek40BabyDev;

  /// No description provided for @insightWeek40MomBody.
  ///
  /// In en, this message translates to:
  /// **'Due date is here! If nothing is happening — don\'t panic. Only 5% of babies arrive exactly on their due date.'**
  String get insightWeek40MomBody;

  /// No description provided for @insightWeek40Tip.
  ///
  /// In en, this message translates to:
  /// **'Launch our contraction timer. We\'ll tell you when to head to the hospital based on the 5-1-1 rule.'**
  String get insightWeek40Tip;

  /// No description provided for @insightWeek40Milestone.
  ///
  /// In en, this message translates to:
  /// **'Estimated Due Date (EDD)'**
  String get insightWeek40Milestone;

  /// No description provided for @insightWeek40Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'D-Day'**
  String get insightWeek40Insight1Title;

  /// No description provided for @insightWeek40Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Due date is just a guide.'**
  String get insightWeek40Insight1Content;

  /// No description provided for @insightWeek40Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get insightWeek40Insight2Title;

  /// No description provided for @insightWeek40Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Soon you\'ll look into his eyes.'**
  String get insightWeek40Insight2Content;

  /// No description provided for @insightWeek40Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Water Breaking'**
  String get insightWeek40Insight3Title;

  /// No description provided for @insightWeek40Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'If water breaks — go to hospital.'**
  String get insightWeek40Insight3Content;

  /// No description provided for @insightWeek41FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Ripe Melon'**
  String get insightWeek41FruitTitle;

  /// No description provided for @insightWeek41FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'Perfectly ripe. The wait drags on.'**
  String get insightWeek41FruitDescription;

  /// No description provided for @insightWeek41RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Packed Suitcase'**
  String get insightWeek41RealisticTitle;

  /// No description provided for @insightWeek41RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'Tickets in hand, luggage checked, but the flight is slightly delayed.'**
  String get insightWeek41RealisticDescription;

  /// No description provided for @insightWeek41BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Continues to grow and gain weight. Skin might get a bit dry as vernix decreases.'**
  String get insightWeek41BabyDev;

  /// No description provided for @insightWeek41MomBody.
  ///
  /// In en, this message translates to:
  /// **'Waiting fatigue is at its peak. Doctor might suggest induction or close monitoring (NST & Ultrasound).'**
  String get insightWeek41MomBody;

  /// No description provided for @insightWeek41Tip.
  ///
  /// In en, this message translates to:
  /// **'Try natural induction methods (after consulting your doctor): long walks, spicy food, or romance.'**
  String get insightWeek41Tip;

  /// No description provided for @insightWeek41Milestone.
  ///
  /// In en, this message translates to:
  /// **'Post-term pregnancy'**
  String get insightWeek41Milestone;

  /// No description provided for @insightWeek41Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Stay Calm'**
  String get insightWeek41Insight1Title;

  /// No description provided for @insightWeek41Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Many babies just aren\'t in a rush. Your job right now is to trust your doctors and relax.'**
  String get insightWeek41Insight1Content;

  /// No description provided for @insightWeek41Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'Induction'**
  String get insightWeek41Insight2Title;

  /// No description provided for @insightWeek41Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'Walking stairs and taking a warm shower can help gently jumpstart the process.'**
  String get insightWeek41Insight2Content;

  /// No description provided for @insightWeek41Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Monitoring'**
  String get insightWeek41Insight3Title;

  /// No description provided for @insightWeek41Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Doctors will check placental blood flow and amniotic fluid levels more frequently.'**
  String get insightWeek41Insight3Content;

  /// No description provided for @insightWeek42FruitTitle.
  ///
  /// In en, this message translates to:
  /// **'Juicy Jackfruit'**
  String get insightWeek42FruitTitle;

  /// No description provided for @insightWeek42FruitDescription.
  ///
  /// In en, this message translates to:
  /// **'The biggest and most anticipated. Time to meet.'**
  String get insightWeek42FruitDescription;

  /// No description provided for @insightWeek42RealisticTitle.
  ///
  /// In en, this message translates to:
  /// **'Clock Hand'**
  String get insightWeek42RealisticTitle;

  /// No description provided for @insightWeek42RealisticDescription.
  ///
  /// In en, this message translates to:
  /// **'That crucial moment has finally arrived.'**
  String get insightWeek42RealisticDescription;

  /// No description provided for @insightWeek42BabyDev.
  ///
  /// In en, this message translates to:
  /// **'Nails are very long, head hair is thick. Absolutely no room left.'**
  String get insightWeek42BabyDev;

  /// No description provided for @insightWeek42MomBody.
  ///
  /// In en, this message translates to:
  /// **'This is the absolute limit. If labor hasn\'t started, you\'ll be admitted for medical induction.'**
  String get insightWeek42MomBody;

  /// No description provided for @insightWeek42Tip.
  ///
  /// In en, this message translates to:
  /// **'Don\'t be upset if you need a medical induction. The most important thing is a healthy mom and baby.'**
  String get insightWeek42Tip;

  /// No description provided for @insightWeek42Milestone.
  ///
  /// In en, this message translates to:
  /// **'Hospital admission'**
  String get insightWeek42Milestone;

  /// No description provided for @insightWeek42Insight1Title.
  ///
  /// In en, this message translates to:
  /// **'Induction'**
  String get insightWeek42Insight1Title;

  /// No description provided for @insightWeek42Insight1Content.
  ///
  /// In en, this message translates to:
  /// **'Doctors will help your body start the process using medical methods.'**
  String get insightWeek42Insight1Content;

  /// No description provided for @insightWeek42Insight2Title.
  ///
  /// In en, this message translates to:
  /// **'End of the Road'**
  String get insightWeek42Insight2Title;

  /// No description provided for @insightWeek42Insight2Content.
  ///
  /// In en, this message translates to:
  /// **'This is your last week of pregnancy, 100%. The finish line is right here.'**
  String get insightWeek42Insight2Content;

  /// No description provided for @insightWeek42Insight3Title.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get insightWeek42Insight3Title;

  /// No description provided for @insightWeek42Insight3Content.
  ///
  /// In en, this message translates to:
  /// **'Post-term babies are born without vernix or lanugo, with eyes wide open and very alert.'**
  String get insightWeek42Insight3Content;

  /// No description provided for @symptom1Title.
  ///
  /// In en, this message translates to:
  /// **'Morning Sickness'**
  String get symptom1Title;

  /// No description provided for @symptom1ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Nausea and vomiting, usually in early pregnancy.'**
  String get symptom1ShortDescription;

  /// No description provided for @symptom1FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Nausea is very common due to rising hormones (hCG). Usually fades by week 16. \n\nTips: Eat small meals, ginger tea, stay hydrated.'**
  String get symptom1FullDescription;

  /// No description provided for @symptom2Title.
  ///
  /// In en, this message translates to:
  /// **'Round Ligament Pain'**
  String get symptom2Title;

  /// No description provided for @symptom2ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Sharp pain in lower belly or groin.'**
  String get symptom2ShortDescription;

  /// No description provided for @symptom2FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Sharp jabbing pain felt in the lower abdomen or groin area on one or both sides. Caused by the stretching of ligaments supporting the uterus.'**
  String get symptom2FullDescription;

  /// No description provided for @symptom3Title.
  ///
  /// In en, this message translates to:
  /// **'Bleeding / Spotting'**
  String get symptom3Title;

  /// No description provided for @symptom3ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Any vaginal bleeding.'**
  String get symptom3ShortDescription;

  /// No description provided for @symptom3FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Light spotting can happen after sex or an exam, but bright red blood or heavy flow is NOT normal. \n\nAction: Call your doctor immediately.'**
  String get symptom3FullDescription;

  /// No description provided for @symptom4Title.
  ///
  /// In en, this message translates to:
  /// **'Swelling (Edema)'**
  String get symptom4Title;

  /// No description provided for @symptom4ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Swollen feet and ankles.'**
  String get symptom4ShortDescription;

  /// No description provided for @symptom4FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Mild swelling is normal. However, sudden swelling in face or hands combined with headache could be Preeclampsia.'**
  String get symptom4FullDescription;

  /// No description provided for @symptom5Title.
  ///
  /// In en, this message translates to:
  /// **'Headaches'**
  String get symptom5Title;

  /// No description provided for @symptom5ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Mild to severe head pain.'**
  String get symptom5ShortDescription;

  /// No description provided for @symptom5FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Common due to hormones/dehydration. \n\nWarning: Severe headache that won\'t go away could be a sign of high blood pressure.'**
  String get symptom5FullDescription;

  /// No description provided for @symptom6Title.
  ///
  /// In en, this message translates to:
  /// **'Braxton Hicks'**
  String get symptom6Title;

  /// No description provided for @symptom6ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice contractions.'**
  String get symptom6ShortDescription;

  /// No description provided for @symptom6FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Irregular, non-painful tightening of the belly. They go away if you move or drink water. \n\nIf they become regular/painful -> Call doctor.'**
  String get symptom6FullDescription;

  /// No description provided for @symptom7Title.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get symptom7Title;

  /// No description provided for @symptom7ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Extreme tiredness.'**
  String get symptom7ShortDescription;

  /// No description provided for @symptom7FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Very common due to hormonal changes and increased energy demands. Rest when possible.'**
  String get symptom7FullDescription;

  /// No description provided for @symptom8Title.
  ///
  /// In en, this message translates to:
  /// **'Breast Tenderness'**
  String get symptom8Title;

  /// No description provided for @symptom8ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Sore or sensitive breasts.'**
  String get symptom8ShortDescription;

  /// No description provided for @symptom8FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Caused by rising hormones. Usually improves after the first trimester.'**
  String get symptom8FullDescription;

  /// No description provided for @symptom9Title.
  ///
  /// In en, this message translates to:
  /// **'Frequent Urination'**
  String get symptom9Title;

  /// No description provided for @symptom9ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Needing to pee more often.'**
  String get symptom9ShortDescription;

  /// No description provided for @symptom9FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Pressure on the bladder and hormonal changes cause frequent urination. Normal unless painful.'**
  String get symptom9FullDescription;

  /// No description provided for @symptom10Title.
  ///
  /// In en, this message translates to:
  /// **'Constipation'**
  String get symptom10Title;

  /// No description provided for @symptom10ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Difficulty passing stools.'**
  String get symptom10ShortDescription;

  /// No description provided for @symptom10FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Hormones slow digestion. Increase fiber, fluids, and gentle movement.'**
  String get symptom10FullDescription;

  /// No description provided for @symptom11Title.
  ///
  /// In en, this message translates to:
  /// **'Heartburn'**
  String get symptom11Title;

  /// No description provided for @symptom11ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Burning sensation in chest or throat.'**
  String get symptom11ShortDescription;

  /// No description provided for @symptom11FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Caused by relaxed digestive muscles and pressure from the uterus.'**
  String get symptom11FullDescription;

  /// No description provided for @symptom12Title.
  ///
  /// In en, this message translates to:
  /// **'Shortness of Breath'**
  String get symptom12Title;

  /// No description provided for @symptom12ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Feeling out of breath.'**
  String get symptom12ShortDescription;

  /// No description provided for @symptom12FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Mild breathlessness is normal. Sudden or severe shortness of breath needs medical attention.'**
  String get symptom12FullDescription;

  /// No description provided for @symptom13Title.
  ///
  /// In en, this message translates to:
  /// **'Lower Back Pain'**
  String get symptom13Title;

  /// No description provided for @symptom13ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Aching lower back.'**
  String get symptom13ShortDescription;

  /// No description provided for @symptom13FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Caused by posture changes and extra weight. Gentle stretching may help.'**
  String get symptom13FullDescription;

  /// No description provided for @symptom14Title.
  ///
  /// In en, this message translates to:
  /// **'Leg Cramps'**
  String get symptom14Title;

  /// No description provided for @symptom14ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Painful cramps, usually at night.'**
  String get symptom14ShortDescription;

  /// No description provided for @symptom14FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Common in later pregnancy. Stretching and hydration may reduce cramps.'**
  String get symptom14FullDescription;

  /// No description provided for @symptom15Title.
  ///
  /// In en, this message translates to:
  /// **'Dizziness'**
  String get symptom15Title;

  /// No description provided for @symptom15ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Feeling lightheaded.'**
  String get symptom15ShortDescription;

  /// No description provided for @symptom15FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Often caused by low blood pressure or dehydration. Sit or lie down if dizzy.'**
  String get symptom15FullDescription;

  /// No description provided for @symptom16Title.
  ///
  /// In en, this message translates to:
  /// **'Nasal Congestion'**
  String get symptom16Title;

  /// No description provided for @symptom16ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Stuffy or runny nose.'**
  String get symptom16ShortDescription;

  /// No description provided for @symptom16FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Pregnancy hormones increase blood flow to nasal passages. Normal and common.'**
  String get symptom16FullDescription;

  /// No description provided for @symptom17Title.
  ///
  /// In en, this message translates to:
  /// **'Mood Swings'**
  String get symptom17Title;

  /// No description provided for @symptom17ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Rapid emotional changes.'**
  String get symptom17ShortDescription;

  /// No description provided for @symptom17FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Hormonal changes can affect mood. Support and rest are important.'**
  String get symptom17FullDescription;

  /// No description provided for @symptom18Title.
  ///
  /// In en, this message translates to:
  /// **'Increased Vaginal Discharge'**
  String get symptom18Title;

  /// No description provided for @symptom18ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Thin, milky discharge.'**
  String get symptom18ShortDescription;

  /// No description provided for @symptom18FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Normal if odorless and not itchy. Helps prevent infections.'**
  String get symptom18FullDescription;

  /// No description provided for @symptom19Title.
  ///
  /// In en, this message translates to:
  /// **'Pelvic Pressure'**
  String get symptom19Title;

  /// No description provided for @symptom19ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Feeling of heaviness in pelvis.'**
  String get symptom19ShortDescription;

  /// No description provided for @symptom19FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Common as baby grows. Sudden pressure with pain could indicate preterm labor.'**
  String get symptom19FullDescription;

  /// No description provided for @symptom20Title.
  ///
  /// In en, this message translates to:
  /// **'Itching'**
  String get symptom20Title;

  /// No description provided for @symptom20ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Mild skin itching.'**
  String get symptom20ShortDescription;

  /// No description provided for @symptom20FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Stretching skin can itch. Severe itching (especially hands/feet) needs evaluation.'**
  String get symptom20FullDescription;

  /// No description provided for @symptom21Title.
  ///
  /// In en, this message translates to:
  /// **'Fever'**
  String get symptom21Title;

  /// No description provided for @symptom21ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Elevated body temperature.'**
  String get symptom21ShortDescription;

  /// No description provided for @symptom21FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Fever during pregnancy is NOT normal. Contact a healthcare provider.'**
  String get symptom21FullDescription;

  /// No description provided for @symptom22Title.
  ///
  /// In en, this message translates to:
  /// **'Severe Abdominal Pain'**
  String get symptom22Title;

  /// No description provided for @symptom22ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Intense belly pain.'**
  String get symptom22ShortDescription;

  /// No description provided for @symptom22FullDescription.
  ///
  /// In en, this message translates to:
  /// **'Strong or persistent abdominal pain is NOT normal. Seek medical care.'**
  String get symptom22FullDescription;

  /// No description provided for @symptom23Title.
  ///
  /// In en, this message translates to:
  /// **'Reduced Baby Movements'**
  String get symptom23Title;

  /// No description provided for @symptom23ShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Baby moving less than usual.'**
  String get symptom23ShortDescription;

  /// No description provided for @symptom23FullDescription.
  ///
  /// In en, this message translates to:
  /// **'A noticeable decrease in movements requires immediate medical attention.'**
  String get symptom23FullDescription;

  /// No description provided for @authEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to begin'**
  String get authEntryTitle;

  /// No description provided for @authEntryBody.
  ///
  /// In en, this message translates to:
  /// **'Use Apple or Google if you want your journey tied to an account, or continue without an account and keep everything gently on this device for now.'**
  String get authEntryBody;

  /// No description provided for @authEntryHint.
  ///
  /// In en, this message translates to:
  /// **'You can stay in guest mode now and connect an account later from Settings without losing your local progress.'**
  String get authEntryHint;

  /// No description provided for @authGoogleContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authGoogleContinue;

  /// No description provided for @authAppleContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authAppleContinue;

  /// No description provided for @authGuestContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue without account'**
  String get authGuestContinue;

  /// No description provided for @authSignInError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t complete sign in'**
  String get authSignInError;

  /// No description provided for @authConflictTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose which data to keep'**
  String get authConflictTitle;

  /// No description provided for @authConflictBody.
  ///
  /// In en, this message translates to:
  /// **'We found saved data for this account on this device, and there is also progress in your current guest mode. Pick which version should stay with this account.'**
  String get authConflictBody;

  /// No description provided for @authConflictUseAccount.
  ///
  /// In en, this message translates to:
  /// **'Keep account data'**
  String get authConflictUseAccount;

  /// No description provided for @authConflictUseDevice.
  ///
  /// In en, this message translates to:
  /// **'Keep this device data'**
  String get authConflictUseDevice;

  /// No description provided for @authSettingsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get authSettingsSectionTitle;

  /// No description provided for @authGuestModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest mode'**
  String get authGuestModeTitle;

  /// No description provided for @authGuestModeBody.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on this device. Connect an account whenever you want a more stable long-term home for your journey.'**
  String get authGuestModeBody;

  /// No description provided for @authSignedInTitle.
  ///
  /// In en, this message translates to:
  /// **'Connected with {provider}'**
  String authSignedInTitle(String provider);

  /// No description provided for @authSignedInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your local progress is attached to this account on this device.'**
  String get authSignedInSubtitle;

  /// No description provided for @authSwitchToGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'Switch to guest mode?'**
  String get authSwitchToGuestTitle;

  /// No description provided for @authSwitchToGuestBody.
  ///
  /// In en, this message translates to:
  /// **'Your current account data will stay safely on this device. We will open a fresh guest space for you after sign out.'**
  String get authSwitchToGuestBody;

  /// No description provided for @authSwitchToGuestAction.
  ///
  /// In en, this message translates to:
  /// **'Switch to guest mode'**
  String get authSwitchToGuestAction;

  /// No description provided for @authGoogleProvider.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get authGoogleProvider;

  /// No description provided for @authAppleProvider.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get authAppleProvider;

  /// No description provided for @authGuestProvider.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get authGuestProvider;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
