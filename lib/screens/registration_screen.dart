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

class RegistrationScreen extends StatefulWidget {
  static const screenRoute = 'registeration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    if (state is RegistrationFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }

                    if (state is RegistrationSuccessfulState) {
                      Navigator.of(context)
                          .pushReplacementNamed(ChatScreen.screenRoute , arguments:email);
                      ScaffoldMessenger.of(context).showSnackBar(

                        const SnackBar(
                          backgroundColor: Colors.green,
                            content: Text("Registration done Successfully ")),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                    isLoading: state is RegistrationLoadingState,

                      loadingColor: Colors.yellow[900]!,
                      title: 'Register',
                      backgroundColor: Colors.blue[800]!,
                      onPressed: () async{
                        if (formKey.currentState!.validate())  {
                          BlocProvider.of<RegistrationCubit>(context)
                              .registerAccount(
                                  email: email, password: password);
                      // await  FirebaseAuth.instance
                      //       .createUserWithEmailAndPassword(email: email, password: password);



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
