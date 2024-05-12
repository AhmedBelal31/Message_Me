import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me/controller/registeration_cubit/registeration_cubit.dart';
import 'package:message_me/controller/registeration_cubit/registeration_states.dart';
import 'package:message_me/screens/welcome_screen.dart';

class ChatScreen extends StatefulWidget {
  static const screenRoute = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    String message = '';
    return BlocProvider(
      create: (context) => RegisterationCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[900],
          title: Row(
            children: [
              Image.asset('images/logo.png', height: 25),
              const SizedBox(width: 10),
              const Text(
                'MessageMe',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          actions: [
            BlocBuilder<RegisterationCubit, RegisterationStates>(
              builder: (context, state) {
                return state is! SignoutLoadingState
                    ? IconButton(
                        onPressed: () {
                          BlocProvider.of<RegisterationCubit>(context)
                              .signOut();
                          Navigator.of(context)
                              .pushReplacementNamed(WelcomeScreen.screenRoute);
                        },
                        icon: const Icon(Icons.close),
                      )
                    : const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: Colors.yellow[900]!,
              ))),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        hintText: 'Write your message here ...',
                      ),
                      onChanged: (value) {
                        message = value;
                      },
                    ),
                  ),
                  BlocBuilder<RegisterationCubit, RegisterationStates>(
                    builder: (context, state) {
                      return TextButton(
                          onPressed: () {
                            //! Send Message Here ....
                            BlocProvider.of<RegisterationCubit>(context)
                                .addMessageToFireStore(
                                    message: message, email: email);
                          },
                          child: Text(
                            'send',
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
