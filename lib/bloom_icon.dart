import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BloomIcon extends StatelessWidget {
  final String assetPath;
  final Color color;
  final double size;

  const BloomIcon(this.assetPath,
      {super.key, required this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      // ColorFilter позволяет перекрашивать SVG в любой цвет (Sage/Grey)
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
