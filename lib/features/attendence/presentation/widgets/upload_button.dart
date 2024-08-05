import 'package:excel_converter/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  const CustomButton(
      {required this.buttonText, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.gradient1,
          fixedSize: Size(screenWidth * 0.4, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
