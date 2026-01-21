import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class OrganicSphere extends StatefulWidget {
  final Color colorCore;
  final Color colorMid;
  final Color colorEdge;

  const OrganicSphere({
    super.key,
    required this.colorCore,
    required this.colorMid,
    required this.colorEdge,
  });

  @override
  State<OrganicSphere> createState() => _OrganicSphereState();
}

class _OrganicSphereState extends State<OrganicSphere> with SingleTickerProviderStateMixin {
  ui.FragmentProgram? _program;
  late Ticker _ticker;
  double _time = 0.0;
  bool _hasError = false; // Флаг ошибки

  @override
  void initState() {
    super.initState();
    _initShader();
    _ticker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
          _time = elapsed.inMilliseconds / 1000.0;
        });
      }
    })..start();
  }

  Future<void> _initShader() async {
    try {
      // Пытаемся загрузить шейдер
      final program = await ui.FragmentProgram.fromAsset('assets/shaders/organic_cell.frag');
      if (mounted) {
        setState(() {
          _program = program;
        });
      }
    } catch (e) {
      // Если ошибка (например, файл не найден или пустой), включаем Fallback режим
      debugPrint("Shader load error: $e");
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Если ошибка загрузки шейдера — показываем красивый градиент (Fallback)
    if (_hasError) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [widget.colorCore, widget.colorMid, widget.colorEdge],
            stops: const [0.2, 0.6, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: widget.colorEdge.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            )
          ],
        ),
      );
    }

    // 2. Если шейдер еще грузится — прозрачная заглушка
    if (_program == null) {
      return const SizedBox();
    }

    // 3. Если всё ок — рисуем шейдер
    return CustomPaint(
      painter: _OrganicShaderPainter(
        shader: _program!.fragmentShader(),
        time: _time,
        c1: widget.colorCore,
        c2: widget.colorMid,
        c3: widget.colorEdge,
      ),
      child: Container(),
    );
  }
}

class _OrganicShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;
  final Color c1;
  final Color c2;
  final Color c3;

  _OrganicShaderPainter({
    required this.shader,
    required this.time,
    required this.c1,
    required this.c2,
    required this.c3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, time);
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);
    shader.setFloat(3, c1.red / 255);
    shader.setFloat(4, c1.green / 255);
    shader.setFloat(5, c1.blue / 255);
    shader.setFloat(6, c2.red / 255);
    shader.setFloat(7, c2.green / 255);
    shader.setFloat(8, c2.blue / 255);
    shader.setFloat(9, c3.red / 255);
    shader.setFloat(10, c3.green / 255);
    shader.setFloat(11, c3.blue / 255);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _OrganicShaderPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}