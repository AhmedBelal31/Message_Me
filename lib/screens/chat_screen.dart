// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:message_me/controller/registeration_cubit/registeration_cubit.dart';
// import 'package:message_me/controller/registeration_cubit/registeration_states.dart';
// import 'package:message_me/models/message_model.dart';
// import 'package:message_me/screens/welcome_screen.dart';

// import '../widgets/my_message.dart';
// import '../widgets/receiver_message.dart';

// class ChatScreen extends StatefulWidget {
//   static const screenRoute = 'chat_screen';

//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     String email = ModalRoute.of(context)!.settings.arguments as String;
//     String message = '';
//     var chatController = TextEditingController();
//     return BlocProvider(
//       create: (context) => RegisterationCubit()..getMessagesFromFireStore(),
//       child: BlocBuilder<RegisterationCubit, RegisterationStates>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.yellow[900],
//               title: Row(
//                 children: [
//                   Image.asset('images/logo.png', height: 25),
//                   const SizedBox(width: 10),
//                   const Text(
//                     'Chat',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 ],
//               ),
//               actions: [
//                 state is! SignoutLoadingState
//                     ? IconButton(
//                         onPressed: () {
//                           BlocProvider.of<RegisterationCubit>(context)
//                               .signOut();
//                           Navigator.of(context)
//                               .pushReplacementNamed(WelcomeScreen.screenRoute);
//                         },
//                         icon: const Icon(Icons.close),
//                       )
//                     : const SizedBox(
//                         height: 25,
//                         width: 25,
//                         child: CircularProgressIndicator(),
//                       ),
//                 const SizedBox(width: 20),
//               ],
//             ),
//             body: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               // crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Expanded(
//                   child: ListView.separated(
//                     itemBuilder: (context, index) {
//                       MessageModel messages =
//                           BlocProvider.of<RegisterationCubit>(context)
//                               .messages[index];
//                       return messages.email == email
//                           ? MyMessage(myMessages: messages)
//                           : RecieverMessage(receiverMessages: messages);
//                     },
//                     separatorBuilder: (context, index) => const SizedBox(
//                       height: 20,
//                     ),
//                     itemCount: message.length,
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                       border: Border(
//                           top: BorderSide(
//                     color: Colors.yellow[900]!,
//                   ))),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: chatController,
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 10),
//                             hintText: 'Write your message here ...',
//                           ),
//                           onChanged: (value) {
//                             message = value;
//                           },
//                         ),
//                       ),
//                       BlocBuilder<RegisterationCubit, RegisterationStates>(
//                         builder: (context, state) {
//                           return TextButton(
//                               onPressed: () {
//                                 //! Send Message Here ....
//                                 BlocProvider.of<RegisterationCubit>(context)
//                                     .addMessageToFireStore(
//                                         message: message, email: email);

//                                 chatController.clear();

//                               },
//                               child: Text(
//                                 'send',
//                                 style: TextStyle(
//                                   color: Colors.blue[800],
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ));
//                         },
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_me/controller/registeration_cubit/registeration_cubit.dart';
import 'package:message_me/controller/registeration_cubit/registeration_states.dart';
import 'package:message_me/models/message_model.dart';
import 'package:message_me/screens/welcome_screen.dart';

import '../widgets/my_message.dart';
import '../widgets/receiver_message.dart';

class ChatScreen extends StatefulWidget {
  static const screenRoute = 'chat_screen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = TextEditingController();
  String message = '';
  ScrollController listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => RegistrationCubit()..getMessagesFromFireStore(),
      child: BlocBuilder<RegistrationCubit, RegistrationStates>(
        builder: (context, state) {
          var cubit = BlocProvider.of<RegistrationCubit>(context);

          return Scaffold(
            appBar: buildAppBar(state, cubit, context),
            body: Column(
              children: [
                Expanded(
                  child: state is GetMessagesLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          controller: listController,
                          reverse: true,
                          itemBuilder: (context, index) {
                            MessageModel messages = cubit.messages[index];
                            return messages.email == email
                                ? MyMessage(myMessages: messages)
                                : RecieverMessage(receiverMessages: messages);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 20,
                          ),
                          itemCount: cubit.messages.length,
                        ),
                ),
               const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.yellow[900]!,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: chatController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: 'Write your message here ...',
                          ),
                          onChanged: (value) {
                            message = value;
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (message.isNotEmpty) {
                            cubit.addMessageToFireStore(
                              message: message,
                              email: email,
                              dateTime: DateTime.now().toString(),
                            );
                            chatController.clear();
                            //message = '';
                            listController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar(
      RegistrationStates state, RegistrationCubit cubit, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow[900],
      title: Row(
        children: [
          Image.asset('images/logo.png', height: 25),
          const SizedBox(width: 10),
          const Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      actions: [
        state is! SignoutLoadingState
            ? IconButton(
                onPressed: () {
                  cubit.signOut();
                  Navigator.of(context)
                      .pushReplacementNamed(WelcomeScreen.screenRoute);
                },
                icon: const Icon(Icons.close),
              )
            : const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
        const SizedBox(width: 20),
      ],
    );
  }
}
