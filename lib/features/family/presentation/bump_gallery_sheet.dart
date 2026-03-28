import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../l10n/app_localizations.dart';
import '../data/bump_repository.dart';
import '../domain/bump_snapshot.dart';

class BumpGallerySheet extends ConsumerWidget {
  const BumpGallerySheet({super.key});

  void _showError(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.errorGeneric)),
    );
  }

  Future<void> _savePhoto(
    BuildContext context,
    WidgetRef ref,
    int week,
    String path,
  ) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await ref.read(bumpRepositoryProvider).savePhoto(week, path);
    } catch (_) {
      if (context.mounted) {
        _showError(context);
      }
    } finally {
      if (context.mounted) {
        final navigator = Navigator.of(context, rootNavigator: true);
        if (navigator.mounted) {
          navigator.pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshotsStream = ref.watch(bumpRepositoryProvider).watchSnapshots();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;

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
          const SizedBox(height: 24),
          Text(
            l10n.galleryTitle,
            style: theme.textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.gallerySubtitle,
            style: theme.textTheme.bodyMedium?.copyWith(color: mutedColor),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<List<BumpSnapshot>>(
              stream: snapshotsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final existingPhotos = {
                  for (final item in snapshot.data ?? <BumpSnapshot>[])
                    item.week: item,
                };

                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 42 - 8 + 1,
                  itemBuilder: (context, index) {
                    final week = 8 + index;
                    final photo = existingPhotos[week];
                    return _buildPhotoCard(context, ref, week, photo, l10n);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard(
    BuildContext context,
    WidgetRef ref,
    int week,
    BumpSnapshot? photo,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final mutedColor = theme.textTheme.labelSmall?.color ?? Colors.grey;
    final isTaken = photo != null;

    return GestureDetector(
      onTap: () => _pickImage(context, ref, week),
      onLongPress: isTaken ? () => _confirmDelete(context, ref, photo) : null,
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            if (theme.brightness == Brightness.light)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: isTaken
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(photo.tempFullFilePath ?? ''),
                    fit: BoxFit.cover,
                    cacheWidth: 400,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: theme.hoverColor,
                      child:
                          Icon(Icons.broken_image_outlined, color: mutedColor),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        l10n.galleryWeek(week),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: primaryColor.withValues(alpha: 0.5),
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.galleryWeek(week),
                    style: TextStyle(
                      color: mutedColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, WidgetRef ref, int week) async {
    final picker = ImagePicker();
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(l10n.galleryCamera),
              onTap: () async {
                Navigator.pop(sheetContext);
                final xFile = await picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 1200,
                );
                if (xFile != null && context.mounted) {
                  await _savePhoto(context, ref, week, xFile.path);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.galleryPick),
              onTap: () async {
                Navigator.pop(sheetContext);
                final xFile = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 1200,
                );
                if (xFile != null && context.mounted) {
                  await _savePhoto(context, ref, week, xFile.path);
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, BumpSnapshot photo) {
    final l10n = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        var isDeleting = false;

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(l10n.galleryDeleteTitle),
            content: Text(l10n.galleryDeleteBody),
            actions: [
              TextButton(
                onPressed:
                    isDeleting ? null : () => Navigator.pop(dialogContext),
                child: Text(
                  l10n.commonCancel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: isDeleting
                    ? null
                    : () async {
                        setState(() => isDeleting = true);
                        try {
                          await ref
                              .read(bumpRepositoryProvider)
                              .deletePhoto(photo.id);
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          }
                        } catch (_) {
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          }
                          if (context.mounted) {
                            _showError(context);
                          }
                        }
                      },
                child: isDeleting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        l10n.commonDelete,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
