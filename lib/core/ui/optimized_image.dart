import 'package:flutter/material.dart';

class OptimizedImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Ширина для кеша в памяти.
  /// Для миниатюр ставь 150-300. Для полных экранов 800-1000.
  final int memCacheWidth;

  const OptimizedImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.memCacheWidth = 400, // Дефолт для списков и небольших карточек
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,

      // ГЛАВНАЯ ОПТИМИЗАЦИЯ:
      // Декодируем картинку сразу в маленький размер.
      cacheWidth: memCacheWidth,

      // Убирает белое мигание при перерисовке/скролле
      gaplessPlayback: true,

      // Асинхронное декодирование, чтобы не фризить UI поток
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: child,
        );
      },

      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey.withValues(alpha: 0.1),
          child: const Center(
            child:
                Icon(Icons.broken_image_rounded, color: Colors.grey, size: 24),
          ),
        );
      },
    );
  }
}
