import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
            onPressed: () {
              //! ToDo: SignOut Here
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
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
                    decoration:const  InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: 'Write your message here ...',
                    ),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text(
                  'send' ,
                  style: TextStyle(
                    color: Colors.blue[800] ,
                    fontWeight: FontWeight.bold ,
                    fontSize: 18 ,
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}