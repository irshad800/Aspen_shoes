import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shoes/utils/colors.dart';

import '../model/chat_modek.dart';
import '../services/chat_database_helper.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "user");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "shoesbot",
    profileImage:
        "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final dbMessages = await DatabaseHelper().getMessages();
    setState(() {
      messages = dbMessages.map((message) {
        return ChatMessage(
          user: message.userId == "0" ? currentUser : geminiUser,
          text: message.text,
          createdAt: DateTime.parse(message.createdAt),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColors, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'ShoesBot',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await DatabaseHelper().clearMessages();
              setState(() {
                messages = [];
              });
            },
          ),
        ],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    // Save the message to the database
    await DatabaseHelper().insertMessage(ChatMessageModel(
      userId: currentUser.id,
      text: chatMessage.text,
      createdAt: chatMessage.createdAt.toIso8601String(),
    ));

    String question = chatMessage.text;

    print("Sending question: $question");

    try {
      gemini.streamGenerateContent(question).listen((event) async {
        String response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";
        ChatMessage message = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: response,
        );
        setState(() {
          messages = [message, ...messages];
        });

        await DatabaseHelper().insertMessage(ChatMessageModel(
          userId: geminiUser.id,
          text: response,
          createdAt: DateTime.now().toIso8601String(),
        ));
      }).onError((error) {
        print("Error in receiving response: $error");
      });
    } catch (e) {
      print("Exception caught: $e");
    }
  }
}
