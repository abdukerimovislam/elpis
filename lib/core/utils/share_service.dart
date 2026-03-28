import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  /// Захватывает виджет, обернутый в [RepaintBoundary] с указанным [key],
  /// сохраняет его и вызывает нативное окно "Поделиться".
  static Future<void> captureAndShare(GlobalKey key, String text) async {
    try {
      // 1. Даем движку один кадр, чтобы убедиться, что всё отрисовано
      await Future.delayed(const Duration(milliseconds: 20));

      final RenderRepaintBoundary? boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        debugPrint(
            "Share error: boundary is null. Проверьте, что RepaintBoundary установлен.");
        return;
      }

      // 2. Проверяем, не идет ли сейчас перерисовка (isComplex/willChange)
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 50));
      }

      // 3. Рендерим в ui.Image. 3.0 дает отличное качество (Retina-ready)
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // 4. Конвертируем в байты
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // 5. Сохраняем во временную директорию
      final directory = await getTemporaryDirectory();
      final String fileName =
          'bloom_${DateTime.now().millisecondsSinceEpoch}.png';
      final File file = File('${directory.path}/$fileName');

      await file.writeAsBytes(pngBytes);

      // 6. Шарим файл
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: text,
        ),
      );

      // Освобождаем память от объекта изображения
      image.dispose();
    } catch (e) {
      debugPrint("❌ Share error: $e");
    }
  }
}
