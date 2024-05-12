import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final bool isLoading;
  final Color loadingColor;

   const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    required this.backgroundColor,
    this.isLoading = false,
     this.loadingColor = Colors.yellow,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 200,
      height: 42,
      color: backgroundColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      onPressed: onPressed,
      child: isLoading
          ? SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: loadingColor,
              ),
            )
          : Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
