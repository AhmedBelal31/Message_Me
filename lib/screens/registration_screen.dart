import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me/controller/registeration_cubit/registeration_cubit.dart';
import 'package:message_me/controller/registeration_cubit/registeration_states.dart';
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
  late String email;
  late String password;
  bool isLoading = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  var formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one capital letter';
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterationCubit(),
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
                BlocConsumer<RegisterationCubit, RegisterationStates>(
                  listener: (context, state) {
                    if (state is RegisterationFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }

                    if (state is RegisterationSuccessfulState) {
                      Navigator.of(context)
                          .pushReplacementNamed(ChatScreen.screenRoute);
                      ScaffoldMessenger.of(context).showSnackBar(
        
                        const SnackBar(
                          backgroundColor: Colors.green,
                            content: Text("Registeration done Successfully ")),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state is RegisterationLoadingState,
                      title: 'Register',
                      backgroundColor: Colors.blue[800]!,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterationCubit>(context)
                              .registerAccount(
                                  email: email, password: password);
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
