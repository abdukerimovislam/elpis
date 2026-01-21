import 'package:flutter_riverpod/flutter_riverpod.dart';

// Уровни "нормальности"
enum SymptomSeverity {
  common,    // Зеленый: Частая жалоба, вариант нормы
  monitor,   // Желтый: Стоит следить, может быть нормой или нет
  urgent     // Красный: Требует звонка врачу
}

class Symptom {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final SymptomSeverity severity;
  final List<int> trimesters; // [1, 2, 3] - в каких триместрах актуально

  const Symptom({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.severity,
    required this.trimesters,
  });
}

// Провайдер репозитория
final symptomsRepositoryProvider = Provider((ref) => SymptomsRepository());

class SymptomsRepository {

  // Метод поиска теперь требует код языка
  List<Symptom> search(String query, String languageCode) {
    // Получаем список для нужного языка (или английский по умолчанию)
    final list = _data[languageCode] ?? _data['en']!;

    if (query.isEmpty) return list;

    return list.where((s) =>
        s.title.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // --- БАЗА ДАННЫХ СИМПТОМОВ ---

  static final Map<String, List<Symptom>> _data = {
    'en': [
      // 1-6 (Базовые)
      const Symptom(
        id: '1',
        title: 'Morning Sickness',
        shortDescription: 'Nausea and vomiting, usually in early pregnancy.',
        fullDescription: 'Nausea is very common due to rising hormones (hCG). Usually fades by week 16. \n\nTips: Eat small meals, ginger tea, stay hydrated.',
        severity: SymptomSeverity.common,
        trimesters: [1],
      ),
      const Symptom(
        id: '2',
        title: 'Round Ligament Pain',
        shortDescription: 'Sharp pain in lower belly or groin.',
        fullDescription: 'Sharp jabbing pain felt in the lower abdomen or groin area on one or both sides. Caused by the stretching of ligaments supporting the uterus.',
        severity: SymptomSeverity.common,
        trimesters: [2],
      ),
      const Symptom(
        id: '3',
        title: 'Bleeding / Spotting',
        shortDescription: 'Any vaginal bleeding.',
        fullDescription: 'Light spotting can happen after sex or an exam, but bright red blood or heavy flow is NOT normal. \n\nAction: Call your doctor immediately.',
        severity: SymptomSeverity.urgent,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '4',
        title: 'Swelling (Edema)',
        shortDescription: 'Swollen feet and ankles.',
        fullDescription: 'Mild swelling is normal. However, sudden swelling in face or hands combined with headache could be Preeclampsia.',
        severity: SymptomSeverity.monitor,
        trimesters: [3],
      ),
      const Symptom(
        id: '5',
        title: 'Headaches',
        shortDescription: 'Mild to severe head pain.',
        fullDescription: 'Common due to hormones/dehydration. \n\nWarning: Severe headache that won\'t go away could be a sign of high blood pressure.',
        severity: SymptomSeverity.monitor,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '6',
        title: 'Braxton Hicks',
        shortDescription: 'Practice contractions.',
        fullDescription: 'Irregular, non-painful tightening of the belly. They go away if you move or drink water. \n\nIf they become regular/painful -> Call doctor.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      // 7-23 (Новые)
      const Symptom(
        id: '7',
        title: 'Fatigue',
        shortDescription: 'Extreme tiredness.',
        fullDescription: 'Very common due to hormonal changes and increased energy demands. Rest when possible.',
        severity: SymptomSeverity.common,
        trimesters: [1, 3],
      ),
      const Symptom(
        id: '8',
        title: 'Breast Tenderness',
        shortDescription: 'Sore or sensitive breasts.',
        fullDescription: 'Caused by rising hormones. Usually improves after the first trimester.',
        severity: SymptomSeverity.common,
        trimesters: [1],
      ),
      const Symptom(
        id: '9',
        title: 'Frequent Urination',
        shortDescription: 'Needing to pee more often.',
        fullDescription: 'Pressure on the bladder and hormonal changes cause frequent urination. Normal unless painful.',
        severity: SymptomSeverity.common,
        trimesters: [1, 3],
      ),
      const Symptom(
        id: '10',
        title: 'Constipation',
        shortDescription: 'Difficulty passing stools.',
        fullDescription: 'Hormones slow digestion. Increase fiber, fluids, and gentle movement.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '11',
        title: 'Heartburn',
        shortDescription: 'Burning sensation in chest or throat.',
        fullDescription: 'Caused by relaxed digestive muscles and pressure from the uterus.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '12',
        title: 'Shortness of Breath',
        shortDescription: 'Feeling out of breath.',
        fullDescription: 'Mild breathlessness is normal. Sudden or severe shortness of breath needs medical attention.',
        severity: SymptomSeverity.monitor,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '13',
        title: 'Lower Back Pain',
        shortDescription: 'Aching lower back.',
        fullDescription: 'Caused by posture changes and extra weight. Gentle stretching may help.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '14',
        title: 'Leg Cramps',
        shortDescription: 'Painful cramps, usually at night.',
        fullDescription: 'Common in later pregnancy. Stretching and hydration may reduce cramps.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '15',
        title: 'Dizziness',
        shortDescription: 'Feeling lightheaded.',
        fullDescription: 'Often caused by low blood pressure or dehydration. Sit or lie down if dizzy.',
        severity: SymptomSeverity.monitor,
        trimesters: [1, 2],
      ),
      const Symptom(
        id: '16',
        title: 'Nasal Congestion',
        shortDescription: 'Stuffy or runny nose.',
        fullDescription: 'Pregnancy hormones increase blood flow to nasal passages. Normal and common.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '17',
        title: 'Mood Swings',
        shortDescription: 'Rapid emotional changes.',
        fullDescription: 'Hormonal changes can affect mood. Support and rest are important.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '18',
        title: 'Increased Vaginal Discharge',
        shortDescription: 'Thin, milky discharge.',
        fullDescription: 'Normal if odorless and not itchy. Helps prevent infections.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '19',
        title: 'Pelvic Pressure',
        shortDescription: 'Feeling of heaviness in pelvis.',
        fullDescription: 'Common as baby grows. Sudden pressure with pain could indicate preterm labor.',
        severity: SymptomSeverity.monitor,
        trimesters: [3],
      ),
      const Symptom(
        id: '20',
        title: 'Itching',
        shortDescription: 'Mild skin itching.',
        fullDescription: 'Stretching skin can itch. Severe itching (especially hands/feet) needs evaluation.',
        severity: SymptomSeverity.monitor,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '21',
        title: 'Fever',
        shortDescription: 'Elevated body temperature.',
        fullDescription: 'Fever during pregnancy is NOT normal. Contact a healthcare provider.',
        severity: SymptomSeverity.urgent,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '22',
        title: 'Severe Abdominal Pain',
        shortDescription: 'Intense belly pain.',
        fullDescription: 'Strong or persistent abdominal pain is NOT normal. Seek medical care.',
        severity: SymptomSeverity.urgent,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '23',
        title: 'Reduced Baby Movements',
        shortDescription: 'Baby moving less than usual.',
        fullDescription: 'A noticeable decrease in movements requires immediate medical attention.',
        severity: SymptomSeverity.urgent,
        trimesters: [3],
      ),
    ],

    // --- РУССКИЙ ПЕРЕВОД ---
    'ru': [
      // 1-6
      const Symptom(
        id: '1',
        title: 'Токсикоз (Тошнота)',
        shortDescription: 'Тошнота и рвота, обычно в начале беременности.',
        fullDescription: 'Тошнота очень распространена из-за роста гормонов (ХГЧ). Обычно проходит к 16 неделе. \n\nСоветы: Ешьте часто и понемногу, пейте имбирный чай и воду.',
        severity: SymptomSeverity.common,
        trimesters: [1],
      ),
      const Symptom(
        id: '2',
        title: 'Боль в круглых связках',
        shortDescription: 'Резкая боль внизу живота или в паху.',
        fullDescription: 'Острая колющая боль в нижней части живота или в паху с одной или обеих сторон. Вызвана растяжением связок, поддерживающих матку.',
        severity: SymptomSeverity.common,
        trimesters: [2],
      ),
      const Symptom(
        id: '3',
        title: 'Кровотечение',
        shortDescription: 'Любые кровянистые выделения.',
        fullDescription: 'Легкие мажущие выделения могут быть после секса или осмотра, но ярко-красная кровь НЕ является нормой. \n\nДействие: Немедленно позвоните врачу.',
        severity: SymptomSeverity.urgent,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '4',
        title: 'Отеки',
        shortDescription: 'Отекшие ступни и лодыжки.',
        fullDescription: 'Легкая отечность нормальна. Однако внезапный отек лица или рук в сочетании с головной болью может быть признаком преэклампсии.',
        severity: SymptomSeverity.monitor,
        trimesters: [3],
      ),
      const Symptom(
        id: '5',
        title: 'Головные боли',
        shortDescription: 'От легкой до сильной боли.',
        fullDescription: 'Часто возникают из-за гормонов или обезвоживания. \n\nВажно: Сильная головная боль, которая не проходит, может быть признаком высокого давления.',
        severity: SymptomSeverity.monitor,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '6',
        title: 'Схватки Брэкстона-Хикса',
        shortDescription: 'Тренировочные схватки.',
        fullDescription: 'Нерегулярное, безболезненное напряжение живота. Проходит при движении или после воды. \n\nЕсли они становятся регулярными и болезненными -> Звоните врачу.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      // 7-23
      const Symptom(
        id: '7',
        title: 'Усталость',
        shortDescription: 'Сильная утомляемость.',
        fullDescription: 'Очень часто встречается из-за гормональных изменений и повышенных затрат энергии. Отдыхайте при любой возможности.',
        severity: SymptomSeverity.common,
        trimesters: [1, 3],
      ),
      const Symptom(
        id: '8',
        title: 'Чувствительность груди',
        shortDescription: 'Болезненность или чувствительность.',
        fullDescription: 'Вызвана ростом гормонов. Обычно состояние улучшается после первого триместра.',
        severity: SymptomSeverity.common,
        trimesters: [1],
      ),
      const Symptom(
        id: '9',
        title: 'Частое мочеиспускание',
        shortDescription: 'Частые позывы в туалет.',
        fullDescription: 'Давление матки на мочевой пузырь и гормоны вызывают частые позывы. Это норма, если нет боли.',
        severity: SymptomSeverity.common,
        trimesters: [1, 3],
      ),
      const Symptom(
        id: '10',
        title: 'Запор',
        shortDescription: 'Трудности с пищеварением.',
        fullDescription: 'Гормоны замедляют пищеварение. Увеличьте количество клетчатки, пейте больше воды и двигайтесь.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '11',
        title: 'Изжога',
        shortDescription: 'Жжение в груди или горле.',
        fullDescription: 'Вызвана расслаблением мышц пищевода и давлением матки на желудок.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '12',
        title: 'Одышка',
        shortDescription: 'Нехватка воздуха.',
        fullDescription: 'Легкая одышка нормальна. Внезапная или сильная нехватка воздуха требует медицинской помощи.',
        severity: SymptomSeverity.monitor,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '13',
        title: 'Боль в пояснице',
        shortDescription: 'Ноющая боль в спине.',
        fullDescription: 'Вызвана изменением осанки и лишним весом. Помогает легкая растяжка и правильная обувь.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '14',
        title: 'Судороги ног',
        shortDescription: 'Болезненные спазмы, обычно ночью.',
        fullDescription: 'Часто встречаются на поздних сроках. Растяжка икр и достаточное питье могут помочь.',
        severity: SymptomSeverity.common,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '15',
        title: 'Головокружение',
        shortDescription: 'Чувство дурноты.',
        fullDescription: 'Часто вызвано низким давлением или обезвоживанием. Сядьте или лягте, если чувствуете головокружение.',
        severity: SymptomSeverity.monitor,
        trimesters: [1, 2],
      ),
      const Symptom(
        id: '16',
        title: 'Заложенность носа',
        shortDescription: 'Ринит беременных.',
        fullDescription: 'Гормоны беременности усиливают приток крови к слизистой носа. Это нормально и часто встречается.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '17',
        title: 'Перепады настроения',
        shortDescription: 'Быстрая смена эмоций.',
        fullDescription: 'Гормональные штормы влияют на настроение. Поддержка близких и отдых очень важны.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '18',
        title: 'Выделения',
        shortDescription: 'Жидкие, молочные выделения.',
        fullDescription: 'Нормально, если они без запаха и не вызывают зуда. Помогают защитить от инфекций.',
        severity: SymptomSeverity.common,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '19',
        title: 'Давление в тазу',
        shortDescription: 'Чувство тяжести внизу.',
        fullDescription: 'Обычное явление при росте ребенка. Внезапное сильное давление с болью может указывать на преждевременные роды.',
        severity: SymptomSeverity.monitor,
        trimesters: [3],
      ),
      const Symptom(
        id: '20',
        title: 'Зуд',
        shortDescription: 'Легкий зуд кожи.',
        fullDescription: 'Растягивающаяся кожа может чесаться. Сильный зуд (особенно ладоней и стоп) требует проверки у врача.',
        severity: SymptomSeverity.monitor,
        trimesters: [2, 3],
      ),
      const Symptom(
        id: '21',
        title: 'Температура (Жар)',
        shortDescription: 'Повышенная температура тела.',
        fullDescription: 'Лихорадка во время беременности НЕ является нормой. Свяжитесь с врачом.',
        severity: SymptomSeverity.urgent,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '22',
        title: 'Сильная боль в животе',
        shortDescription: 'Острая боль.',
        fullDescription: 'Сильная или постоянная боль в животе НЕ нормальна. Требуется медицинская помощь.',
        severity: SymptomSeverity.urgent,
        trimesters: [1, 2, 3],
      ),
      const Symptom(
        id: '23',
        title: 'Малыш меньше шевелится',
        shortDescription: 'Снижение активности ребенка.',
        fullDescription: 'Заметное снижение количества шевелений требует немедленного внимания врача.',
        severity: SymptomSeverity.urgent,
        trimesters: [3],
      ),
    ],
  };
}