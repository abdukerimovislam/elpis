import re

ru_f = 'lib/features/pregnancy/data/locales/ru_insights.dart'
en_f = 'lib/features/pregnancy/data/locales/en_insights.dart'

ru_data = {
    4: ("Рост 1–2 мм, Вес <1 г", "Размером с маковое зернышко. Эмбрион только формируется."),
    5: ("Рост 2–3 мм, Вес <1 г", "Размером с кунжутное семя. Крошечная жизнь внутри вас."),
    6: ("Рост 4–6 мм, Вес <1 г", "Размером с чечевицу. Малыш стремительно растет."),
    7: ("Рост 10–13 мм, Вес <1 г", "Размером с чернику. Почти сантиметр!"),
    8: ("Рост 14–20 мм, Вес ~1 г", "Размером с малину. Вес перешел за 1 грамм."),
    9: ("Рост 2–3 см, Вес ~2 г", "Размером с оливку. Пропорции быстро меняются."),
    10: ("Рост 3–4 см, Вес ~4 г", "Размером со сливу. Плод активно набирает массу."),
    11: ("Рост 4–5 см, Вес ~7 г", "Малыш достигает 5 сантиметров от темени до копчика."),
    12: ("Рост 5–6 см, Вес ~14 г", "Размером со средний абрикос. Первый триместр почти завершен!"),
    13: ("Рост 7–8 см, Вес ~23 г", "Размером с персик. Малыш весит больше 20 граммов."),
    14: ("Рост 8–9 см, Вес ~43 г", "Размером с лимон. Второй триместр начался активно."),
    15: ("Рост 10–11 см, Вес ~70 г", "Размером с яблоко. Рост уже превысил 10 см!"),
    16: ("Рост 11–12 см, Вес ~100 г", "Размером с авокадо. Малыш весит уже 100 граммов!"),
    17: ("Рост 13–14 см, Вес ~140 г", "Размером с крупную луковицу. Кости крепчают."),
    18: ("Рост ~14 см, Вес ~190 г", "Размером со сладкий перец. Малыш быстро тяжелеет."),
    19: ("Рост ~15 см, Вес ~240 г", "Размером с манго. Накопление жировой ткани идет полным ходом."),
    20: ("Рост ~25 см, Вес ~300 г", "С этой недели рост измеряется от макушки до пяточек!"),
    21: ("Рост ~26 см, Вес ~360 г", "Размером с морковь. Вес продолжает быстро расти."),
    22: ("Рост ~27 см, Вес ~430 г", "Малыш весит почти полкило! Размеры папайи."),
    23: ("Рост ~28 см, Вес ~500 г", "Важная отметка: малыш достиг веса в 500 граммов."),
    24: ("Рост ~30 см, Вес ~600 г", "Длина достигла 30 см (размер кукурузного початка)."),
    25: ("Рост ~34 см, Вес ~660 г", "Малыш набирает массу, кожа постепенно разглаживается."),
    26: ("Рост ~35 см, Вес ~760 г", "Размером с цуккини. Малыш становится все круглее."),
    27: ("Рост ~36 см, Вес ~870 г", "Приближаемся к отметке в 1 килограмм!"),
    28: ("Рост ~37 см, Вес ~1000 г", "Малыш достиг 1 килограмма! Значимая веха развития."),
    29: ("Рост ~38 см, Вес ~1150 г", "В матке остается все меньше свободного места."),
    30: ("Рост ~39 см, Вес ~1300 г", "Размером с крупный кочан капусты."),
    31: ("Рост ~41 см, Вес ~1500 г", "Полтора килограмма! Рост активно продолжается."),
    32: ("Рост ~42 см, Вес ~1700 г", "Длина от макушки до пят уже около 42 см."),
    33: ("Рост ~43 см, Вес ~1900 г", "Почти 2 килограмма. Размером с ананас."),
    34: ("Рост ~45 см, Вес ~2100 г", "Малыш весит больше двух килограммов!"),
    35: ("Рост ~46 см, Вес ~2300 г", "Стремительный набор массы — по 200 граммов в неделю."),
    36: ("Рост ~47 см, Вес ~2600 г", "Почти готовы! Малыш очень пухлый и милый."),
    37: ("Рост ~48 см, Вес ~2800 г", "Беременность доношена. Роды могут начаться скоро."),
    38: ("Рост ~49 см, Вес ~3000 г", "Отметка в 3 килограмма успешно пройдена!"),
    39: ("Рост ~50 см, Вес ~3200 г", "Длина полметра. Идеальные пропорции новорожденного."),
    40: ("Рост ~51 см, Вес ~3400+ г", "Средний размер доношенного новорожденного малыша.")
}

en_data = {
    4: ("1–2 mm, <1 g", "The size of a poppy seed. The embryo is forming."),
    5: ("2–3 mm, <1 g", "The size of a sesame seed. A tiny life inside you."),
    6: ("4–6 mm, <1 g", "The size of a lentil. Rapid growth is underway."),
    7: ("10–13 mm, <1 g", "The size of a blueberry. Almost a centimeter!"),
    8: ("14–20 mm, ~1 g", "The size of a raspberry. Crossing the 1g milestone."),
    9: ("2–3 cm, ~2 g", "The size of an olive. Proportions are changing."),
    10: ("3–4 cm, ~4 g", "The size of a prune. Active mass gaining begins."),
    11: ("4–5 cm, ~7 g", "Reaching 5 cm long from crown to rump."),
    12: ("5–6 cm, ~14 g", "The size of an apricot. First trimester ends!"),
    13: ("7–8 cm, ~23 g", "The size of a peach. Weighing over 20 grams."),
    14: ("8–9 cm, ~43 g", "The size of a lemon. The second trimester is in full swing."),
    15: ("10–11 cm, ~70 g", "The size of an apple. Over 10 cm in length!"),
    16: ("11–12 cm, ~100 g", "The size of an avocado. The baby is now 100 grams!"),
    17: ("13–14 cm, ~140 g", "The size of a large onion. Bones are getting stronger."),
    18: ("~14 cm, ~190 g", "The size of a bell pepper. Rapidly putting on weight."),
    19: ("~15 cm, ~240 g", "The size of a mango. Fat tissue is accumulating."),
    20: ("~25 cm, ~300 g", "From this week, height is measured from crown to heel!"),
    21: ("~26 cm, ~360 g", "The size of a carrot. Weight continues to soar."),
    22: ("~27 cm, ~430 g", "Weighing nearly half a kilo! The size of a papaya."),
    23: ("~28 cm, ~500 g", "A major milestone: the baby reached 500 grams."),
    24: ("~30 cm, ~600 g", "Length has reached 30 cm (size of corn)."),
    25: ("~34 cm, ~660 g", "Gaining mass quickly, skin is smoothing out."),
    26: ("~35 cm, ~760 g", "Surpassed 700 grams. The baby is getting rounder."),
    27: ("~36 cm, ~870 g", "Approaching the 1 kilogram mark!"),
    28: ("~37 cm, ~1000 g", "Hit 1 kilogram! A highly significant milestone."),
    29: ("~38 cm, ~1150 g", "Around 38 cm long. Space is getting tight."),
    30: ("~39 cm, ~1300 g", "Weighs 1.3 kg (the size of a large cabbage)."),
    31: ("~41 cm, ~1500 g", "1.5 kilograms! Active growth continues unabated."),
    32: ("~42 cm, ~1700 g", "From crown to heel, length is about 42 cm."),
    33: ("~43 cm, ~1900 g", "Nearly 2 kilograms. The size of a pineapple."),
    34: ("~45 cm, ~2100 g", "The baby weighs over 2 kilograms!"),
    35: ("~46 cm, ~2300 g", "Rapid mass gain—about 200 grams per week."),
    36: ("~47 cm, ~2600 g", "Almost ready! Very plump and adorable."),
    37: ("~48 cm, ~2800 g", "Pregnancy is officially full term."),
    38: ("~49 cm, ~3000 g", "The crucial 3 kilogram milestone has been passed!"),
    39: ("~50 cm, ~3200 g", "Half a meter long. Ideal proportions of a newborn."),
    40: ("~51 cm, ~3400+ g", "Average size of a fully developed newborn baby.")
}

def inject(filepath, dt):
    # Читаем файл локализации
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Регулярное выражение для поиска блока "realistic" внутри каждой недели
    # Оно найдет строку "realistic": { ... }, и вставит после нее "growth": { ... },
    pattern = re.compile(
        r'(\s+)("realistic":\s*\{\s*"title":\s*"[^"]*",\s*"description":\s*"[^"]*"\s*\},\n)',
        re.MULTILINE
    )
    
    def replacer(match):
        # Чтобы определить неделю, надо найти ближайший номер недели сверху. 
        # Но мы можем пойти проще: найдём неделю через смещение строки 
        # (в данном случае мы полагаемся на то, что скрипт обрабатывает структуру последовательно).
        pass

    # Раз уж регулярками можно ошибиться с номерами недель, пойдем построчно:
    lines = content.split('\n')
    out = []
    in_week = None
    ok = 0
    
    for i, line in enumerate(lines):
        # Ищем открытие недели "  4: {"
        week_match = re.search(r'^  (\d+): \{', line)
        if week_match:
            in_week = int(week_match.group(1))
            
        out.append(line)
        
        # Если находим конец блока realistic — это }, с нужным отступом
        if '    },' in line and in_week and in_week in dt:
            # Проверяем, что это именно realistic (смотрим на пару строк выше)
            if '"realistic":' in lines[i-3] or '"realistic":' in lines[i-4]:
                if '"growth"' not in ''.join(lines[i:i+5]): # Защита от двойного добавления
                    t, d = dt[in_week]
                    # Добавляем growth
                    out.append(f'    "growth": {{')
                    out.append(f'      "title": "{t}",')
                    out.append(f'      "description": "{d}"')
                    out.append(f'    }},')
                    ok += 1
                    in_week = None # Сбрасываем до следующей недели
                    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write('\n'.join(out))
    
    print(f"Обновлен файл {filepath}: добавлено категорий growth -> {ok}")

inject(ru_f, ru_data)
inject(en_f, en_data)
