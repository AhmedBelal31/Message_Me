import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final bool isLoading;

  const CustomButton(
      {super.key,
      required this.title,
      this.onPressed,
      required this.backgroundColor,
      this.isLoading = false});

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
                color: Colors.yellow[900],
              
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
