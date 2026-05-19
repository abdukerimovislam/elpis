import os

files_to_fix = [
    'lib/features/home/presentation/widgets/home_mini_calendar.dart',
    'lib/features/home/presentation/widgets/home_today_card.dart',
    'lib/features/home/presentation/living_orbit_screen.dart'
]

for file_path in files_to_fix:
    with open(file_path, 'r') as f:
        text = f.read()
    
    text = text.replace(
        "import 'package:flutter_gen/gen_l10n/app_localizations.dart';",
        "import '../../../../l10n/app_localizations.dart';"
    )
    if 'living_orbit_screen.dart' in file_path:
        text = text.replace(
            "import '../../../../l10n/app_localizations.dart';",
            "import '../../../../l10n/app_localizations.dart';" # wait, in living_orbit_screen.dart it is 4 levels deep? lib/features/home/presentation/living_orbit_screen.dart. 3 levels!
        )
        text = text.replace("import '../../../../l10n/app_localizations.dart';", "import '../../../l10n/app_localizations.dart';")
    
    with open(file_path, 'w') as f:
        f.write(text)
