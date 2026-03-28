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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
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
  /// **'Bloom Mama Report'**
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
