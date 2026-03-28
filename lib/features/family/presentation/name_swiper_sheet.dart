import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../pregnancy/data/pregnancy_repository.dart';
import '../data/name_repository.dart';
import '../domain/baby_name.dart';

class NameSwiperSheet extends ConsumerStatefulWidget {
  const NameSwiperSheet({super.key});

  @override
  ConsumerState<NameSwiperSheet> createState() => _NameSwiperSheetState();
}

class _NameSwiperSheetState extends ConsumerState<NameSwiperSheet>
    with SingleTickerProviderStateMixin {
  final List<BabyName> _queue = [];
  final List<String> _selectedNations = [];

  late TabController _tabController;
  NameGender? _selectedGender;
  bool _isLoading = true;
  bool _isVoting = false;
  bool _isEndOfList = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    try {
      await ref.read(isarDatabaseProvider.future);
      await ref.read(nameRepositoryProvider).ensureInitialized();
      await _loadNames();
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() => _isLoading = false);
      _showError();
    }
  }

  Future<void> _loadNames() async {
    if (_isEndOfList || !mounted) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final names = await ref.read(nameRepositoryProvider).getNamesToSwipe(
            gender: _selectedGender,
            nationalities: _selectedNations.isEmpty ? null : _selectedNations,
          );

      if (!mounted) {
        return;
      }

      setState(() {
        if (names.isEmpty) {
          _isEndOfList = true;
        } else {
          _queue.addAll(names);
        }
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() => _isLoading = false);
      _showError();
    }
  }

  void _resetAndReload() {
    setState(() {
      _queue.clear();
      _isEndOfList = false;
      _isLoading = true;
    });
    _loadNames();
  }

  Future<void> _onSwipe(BabyName name, NameVote vote) async {
    if (_isVoting) {
      return;
    }

    setState(() {
      _isVoting = true;
      _queue.remove(name);
    });

    final didSave =
        await ref.read(nameRepositoryProvider).voteName(name.id, vote);

    if (!mounted) {
      return;
    }

    if (!didSave) {
      setState(() {
        _queue.insert(0, name);
        _isVoting = false;
      });
      _showError();
      return;
    }

    setState(() => _isVoting = false);

    if (_queue.length < 3 && !_isEndOfList) {
      await _loadNames();
    }
  }

  Future<void> _removeFromFavorites(BabyName item) async {
    final didSave = await ref
        .read(nameRepositoryProvider)
        .voteName(item.id, NameVote.disliked);

    if (!mounted || didSave) {
      return;
    }

    _showError();
  }

  void _showError() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.errorGeneric)),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showFilterSheet() async {
    final allNations =
        await ref.read(nameRepositoryProvider).getAvailableNationalities();
    if (!mounted) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        final theme = Theme.of(context);
        final primaryColor = theme.primaryColor;
        final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
        final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: mutedColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.nameTitle,
                        style: theme.textTheme.displayLarge
                            ?.copyWith(fontSize: 24),
                      ),
                      TextButton(
                        onPressed: () {
                          setSheetState(() {
                            _selectedGender = null;
                            _selectedNations.clear();
                          });
                        },
                        child: Text(
                          l10n.nameReset,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    l10n.nameGenderLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: mutedColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildGenderChip(
                        l10n.nameGenderAny,
                        null,
                        setSheetState,
                        theme,
                      ),
                      const SizedBox(width: 8),
                      _buildGenderChip(
                        l10n.nameGenderBoy,
                        NameGender.boy,
                        setSheetState,
                        theme,
                      ),
                      const SizedBox(width: 8),
                      _buildGenderChip(
                        l10n.nameGenderGirl,
                        NameGender.girl,
                        setSheetState,
                        theme,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: allNations.map((code) {
                          final isSelected = _selectedNations.contains(code);
                          return FilterChip(
                            label: Text(_formatCountry(code, l10n)),
                            selected: isSelected,
                            selectedColor: primaryColor.withValues(alpha: 0.2),
                            checkmarkColor: primaryColor,
                            backgroundColor: theme.cardColor,
                            labelStyle: TextStyle(
                              color: isSelected ? primaryColor : mainTextColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? Colors.transparent
                                    : mutedColor.withValues(alpha: 0.1),
                              ),
                            ),
                            onSelected: (selected) {
                              setSheetState(() {
                                if (selected) {
                                  _selectedNations.add(code);
                                } else {
                                  _selectedNations.remove(code);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _resetAndReload();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.nameActionShow,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGenderChip(
    String label,
    NameGender? value,
    StateSetter setSheetState,
    ThemeData theme,
  ) {
    final primaryColor = theme.primaryColor;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final isSelected = _selectedGender == value;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: primaryColor.withValues(alpha: 0.2),
      backgroundColor: theme.cardColor,
      side: BorderSide(
        color: isSelected ? Colors.transparent : theme.dividerColor,
      ),
      labelStyle: TextStyle(
        color: isSelected ? primaryColor : mainTextColor,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onSelected: (selected) {
        if (selected) {
          setSheetState(() => _selectedGender = value);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: mutedColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: _showFilterSheet,
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (_selectedNations.isNotEmpty ||
                              _selectedGender != null)
                          ? primaryColor
                          : theme.cardColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: (_selectedNations.isNotEmpty ||
                              _selectedGender != null)
                          ? Colors.white
                          : mainTextColor,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: primaryColor,
                    unselectedLabelColor: mutedColor,
                    indicatorColor: primaryColor,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: l10n.nameTabSearch),
                      Tab(text: l10n.nameTabFavorites),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSwiperTab(l10n, theme),
                _buildLikedTab(l10n, theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwiperTab(AppLocalizations l10n, ThemeData theme) {
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final primaryColor = theme.primaryColor;

    if (_isLoading && _queue.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_queue.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: mutedColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.nameEmptyTitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.nameEmptyBody,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: mutedColor),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: _showFilterSheet,
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                side: BorderSide(color: primaryColor),
              ),
              child: Text(l10n.nameEmptyAction),
            ),
          ],
        ),
      );
    }

    final topCard = _queue.first;
    final nextCard = _queue.length > 1 ? _queue[1] : null;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 480,
            child: Stack(
              children: [
                if (nextCard != null)
                  Transform.scale(
                    scale: 0.95,
                    child: Opacity(
                      opacity: 0.6,
                      child: _buildNameCard(nextCard, l10n, theme),
                    ),
                  ),
                Dismissible(
                  key: ValueKey(topCard.id),
                  direction: _isVoting
                      ? DismissDirection.none
                      : DismissDirection.horizontal,
                  onDismissed: (direction) {
                    final vote = direction == DismissDirection.endToStart
                        ? NameVote.disliked
                        : NameVote.liked;
                    _onSwipe(topCard, vote);
                  },
                  background:
                      _bg(Colors.green, Icons.favorite, Alignment.centerLeft),
                  secondaryBackground:
                      _bg(Colors.redAccent, Icons.close, Alignment.centerRight),
                  child: _buildNameCard(topCard, l10n, theme),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _btn(
                Icons.close,
                Colors.redAccent,
                _isVoting ? null : () => _onSwipe(topCard, NameVote.disliked),
                theme,
              ),
              const SizedBox(width: 40),
              _btn(
                Icons.favorite,
                Colors.green,
                _isVoting ? null : () => _onSwipe(topCard, NameVote.liked),
                theme,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNameCard(BabyName name, AppLocalizations l10n, ThemeData theme) {
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return Container(
      width: double.infinity,
      height: 480,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          if (theme.brightness == Brightness.light)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            name.gender == NameGender.boy ? Icons.male : Icons.female,
            size: 40,
            color: name.gender == NameGender.boy
                ? Colors.blueAccent
                : Colors.pinkAccent,
          ),
          const SizedBox(height: 16),
          Text(
            name.name,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 42),
            textAlign: TextAlign.center,
          ),
          if (name.script != null) ...[
            const SizedBox(height: 4),
            Text(
              name.script!,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 24,
                color: mutedColor.withValues(alpha: 0.5),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildTag(
                _formatCountry(name.nationality, l10n),
                name.origin.toUpperCase(),
                theme,
              ),
              if (name.language != null)
                _buildTag(Icons.translate, name.language!, theme),
              if (name.era != null) _buildTag(Icons.history, name.era!, theme),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              name.meaning,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                color: mutedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bg(Color color, IconData icon, Alignment alignment) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Icon(icon, color: Colors.white, size: 48),
    );
  }

  Widget _btn(
      IconData icon, Color color, VoidCallback? onTap, ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: theme.cardColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: onTap == null ? 0.1 : 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: onTap == null ? color.withValues(alpha: 0.4) : color,
          size: 32,
        ),
      ),
    ).animate().scale(duration: 200.ms);
  }

  Widget _buildTag(dynamic iconOrText, String label, ThemeData theme) {
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final mainTextColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bg = theme.hoverColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconOrText is IconData)
            Icon(iconOrText, size: 12, color: mutedColor),
          if (iconOrText is String)
            Text(iconOrText, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: mainTextColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCountry(String code, AppLocalizations l10n) {
    switch (code.toLowerCase()) {
      case 'ru':
        return l10n.countryRU;
      case 'us':
        return l10n.countryUS;
      case 'tr':
        return l10n.countryTR;
      case 'kz':
        return l10n.countryKZ;
      case 'ua':
        return l10n.countryUA;
      case 'pl':
        return l10n.countryPL;
      case 'de':
        return l10n.countryDE;
      case 'fr':
        return l10n.countryFR;
      case 'it':
        return l10n.countryIT;
      case 'es':
        return l10n.countryES;
      case 'gb':
        return l10n.countryGB;
      case 'ca':
        return l10n.countryCA;
      case 'br':
        return l10n.countryBR;
      case 'ae':
        return l10n.countryAE;
      case 'sa':
        return l10n.countrySA;
      case 'eg':
        return l10n.countryEG;
      case 'ma':
        return l10n.countryMA;
      case 'nl':
        return l10n.countryNL;
      case 'cz':
        return l10n.countryCZ;
      case 'ro':
        return l10n.countryRO;
      case 'ar':
        return l10n.countryAR;
      case 'mx':
        return l10n.countryMX;
      case 'jp':
        return l10n.countryJP;
      case 'cn':
        return l10n.countryCN;
      case 'kr':
        return l10n.countryKR;
      case 'in':
        return l10n.countryIN;
      case 'il':
        return l10n.countryIL;
      case 'gr':
        return l10n.countryGR;
      case 'ie':
        return l10n.countryIE;
      case 'pt':
        return l10n.countryPT;
      case 'au':
        return l10n.countryAU;
      default:
        return code.toUpperCase();
    }
  }

  Widget _buildLikedTab(AppLocalizations l10n, ThemeData theme) {
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

    return StreamBuilder<List<BabyName>>(
      stream: ref.watch(nameRepositoryProvider).watchLikedNames(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 48,
                  color: mutedColor.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 16),
                Text(l10n.nameFavEmpty, style: TextStyle(color: mutedColor)),
              ],
            ),
          );
        }

        final names = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: names.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = names[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(
                    _formatCountry(item.nationality, l10n).split(' ')[0],
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${item.origin} • ${item.meaning}',
                          style: TextStyle(fontSize: 12, color: mutedColor),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: mutedColor),
                    onPressed: () => _removeFromFavorites(item),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
