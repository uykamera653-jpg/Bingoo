import 'package:flutter/material.dart';

class DarkButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const DarkButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0F172A),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed ?? () {},
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
