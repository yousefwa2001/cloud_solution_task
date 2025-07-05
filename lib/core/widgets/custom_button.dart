import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isOutlined;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 15,
    this.height,
    this.width,
    this.textColor,
    this.backgroundColor,
    this.isOutlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height ?? 60;
    final double buttonWidth = width ?? 300;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? Colors.red),
          foregroundColor: textColor ?? Colors.white,
          side: isOutlined
              ? BorderSide(color: backgroundColor ?? Colors.red, width: 2)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isOutlined ? 0 : 2,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 18), SizedBox(width: 8)],
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isOutlined
                    ? (backgroundColor ?? Colors.red)
                    : (textColor ?? Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
