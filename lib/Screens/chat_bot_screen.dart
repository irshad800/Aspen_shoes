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
    firstName: "gemini",
    profileImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-qrr9hN7mx4PugAh4vLAkACdDBSjbs3NFgA&usqp=CAU",
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
        backgroundColor: primaryColors,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Chatbot",
          style: TextStyle(color: Colors.white),
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
