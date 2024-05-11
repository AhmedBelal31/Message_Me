import 'package:flutter/material.dart';
import 'package:message_me/screens/chat_screen.dart';
import 'package:message_me/widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  static const screenRoute = 'signin_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              title: 'Sign In',
              backgroundColor: Colors.yellow[900]!,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ChatScreen.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
