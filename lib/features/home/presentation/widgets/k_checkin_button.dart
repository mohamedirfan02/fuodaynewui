import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class KCheckInButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadiusGeometry borderRadius;

  const KCheckInButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 48,
    this.width = double.infinity,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  State<KCheckInButton> createState() => _KCheckInButtonState();
}

class _KCheckInButtonState extends State<KCheckInButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    HapticFeedback.lightImpact();
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed ? 0.96 : 1.0;
    final offsetY = _isPressed ? 2.0 : 0.0;

    return GestureDetector(
      onTapDown: widget.isLoading ? null : _handleTapDown,
      onTapUp: widget.isLoading ? null : _handleTapUp,
      onTapCancel: widget.isLoading ? null : _handleTapCancel,
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInOut,
        height: widget.height.h,
        width: widget.width.w,
        transform: Matrix4.identity()
          ..translate(0.0, offsetY)
          ..scale(scale),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
          boxShadow: _isPressed
              ? []
              : [
            BoxShadow(
              color: widget.backgroundColor.withOpacity(0.5),
              offset: const Offset(0, 6),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
            height: 18.h,
            width: 18.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
            ),
          )
              : Text(
            widget.text,
            style: GoogleFonts.sora(
              color: widget.textColor,
              fontSize: widget.fontSize.sp,
              fontWeight: widget.fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
