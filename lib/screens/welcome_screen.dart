import 'package:flutter/material.dart';
import 'package:message_me/screens/registration_screen.dart';
import 'package:message_me/screens/sign_in_screen.dart';

import '../widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
    static const screenRoute = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Image.asset('images/logo.png'),
                ),
                const Text(
                  'Message Me',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    color: Color(0xff2e386b),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomButton(
                title: 'Sign In',
                backgroundColor: Colors.yellow[900]!,
                onPressed: () {
                    Navigator.of(context).pushNamed(SignInScreen.screenRoute);
                },
              ),
            ),
            CustomButton(
              title: 'Register',
              backgroundColor: Colors.blue[800]!,
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.screenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
