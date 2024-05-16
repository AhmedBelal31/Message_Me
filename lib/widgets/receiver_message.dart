import 'package:flutter/material.dart';

import '../models/message_model.dart';

class RecieverMessage extends StatelessWidget {
  final MessageModel receiverMessages;
  const RecieverMessage({super.key, required this.receiverMessages});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Text(
                receiverMessages.email,
                style: TextStyle(
                  color: Colors.orange[900],
                ),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(14.0),
                  topLeft: Radius.circular(14.0),
                  bottomLeft: Radius.circular(14.0),
                ),
              ),
              child: Text(
                receiverMessages.message,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
