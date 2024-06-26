import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me/controller/registeration_cubit/registeration_cubit.dart';
import 'package:message_me/controller/registeration_cubit/registeration_states.dart';
import 'package:message_me/screens/chat_screen.dart';
import 'package:message_me/widgets/custom_button.dart';
import '../methods/validate_email.dart';
import '../methods/validate_password.dart';
import '../widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  static const screenRoute = 'signin_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String email;
  late String password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
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
                CustomTextFormField(
                  hint: "Enter your Email ",
                autovalidateMode: autovalidateMode,
                  keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  hint: "Enter your Password ",
                  autovalidateMode: autovalidateMode,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: validatePassword,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 10),
                BlocConsumer<RegistrationCubit, RegistrationStates>(
                  listener: (context, state) {
                    if (state is LoginFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                    if (state is LoginSuccessfulState) {
                      Navigator.of(context)
                          .pushReplacementNamed(ChatScreen.screenRoute , arguments:email );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Login done Successfully ")),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      title: 'Sign In',
                      isLoading: state is RegistrationLoadingState,
                      loadingColor:Colors.blue[800]! ,
                      backgroundColor: Colors.yellow[900]!,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegistrationCubit>(context)
                              .loginToAccount(email: email, password: password);
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
