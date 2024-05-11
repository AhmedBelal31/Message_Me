import 'package:flutter/material.dart';
import 'package:message_me/screens/chat_screen.dart';
import 'package:message_me/widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  static const screenRoute = 'registeration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 180,
              child: Image.asset('images/logo.png'),
            ),
            const SizedBox(height: 50),
            // ignore: prefer_const_constructors
            CustomTextFormField(hint: "Enter your Email "),
            const SizedBox(height: 8),
            CustomTextFormField(
              hint: "Enter your Password ",
              obscureText: true,
            ),
            const SizedBox(height: 10),
            CustomButton(
              title: 'Register',
              backgroundColor: Colors.blue[800]!,
              onPressed: () {
                    Navigator.of(context)
                    .pushReplacementNamed(ChatScreen.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
