import 'package:flutter/material.dart';

import '../models/message_model.dart';

class MyMessage extends StatelessWidget {
  final MessageModel myMessages;
  const MyMessage({super.key, required this.myMessages});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: Text(
                myMessages.email,
                style: TextStyle(
                  color: Colors.orange[900],
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(14.0),
                  topLeft: Radius.circular(14.0),
                  bottomLeft: Radius.circular(14.0),
                ),
              ),
              child: Text(
                myMessages.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}