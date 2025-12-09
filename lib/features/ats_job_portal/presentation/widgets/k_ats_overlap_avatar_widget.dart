import 'package:flutter/material.dart';

class OverlapCirclesAuto extends StatelessWidget {
  final List<String> items; // Dynamic list: ["M", "A", "LM"]
  final Color circleColor;
  final Color textColor;
  final double circleSize;
  final double overlapValue; // How much circles overlap

  const OverlapCirclesAuto({
    super.key,
    required this.items,
    this.circleColor = const Color(0xffD6F2E6),
    this.textColor = const Color(0xff1A8C6C),
    this.circleSize = 30,
    this.overlapValue = 13,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data

    return SizedBox(
      width: circleSize + (items.length - 1) * (circleSize - overlapValue),
      height: circleSize,
      child: Stack(
        children: [
          for (int i = 0; i < items.length; i++)
            Positioned(
              left: i * (circleSize - overlapValue),
              child: _circle(items[i], context),
            ),
        ],
      ),
    );
  }

  Widget _circle(String value, BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: circleSize,
      width: circleSize,
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF064E3B) : Color(0xFFECFDF3),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.35)
                : Colors.grey.withValues(alpha: 0.15),
            blurRadius: 2,
            spreadRadius: 0.1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
