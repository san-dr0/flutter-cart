import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({super.key});

  @override
  State<InquiryPage> createState () => _InquiryPage();
}

class _InquiryPage extends State<InquiryPage> {
  ChatUser user1 = ChatUser(
    id: 'id-123',
    firstName: 'Fname',
    lastName: 'Lname'
  );

  ChatUser user2 = ChatUser(
    id: 'id-1234',
    firstName: 'fname Sec',
    lastName: 'Last sec'
  );

  List<ChatMessage> chatMessage = <ChatMessage>[];

  @override
  void initState() {
    super.initState();
    chatMessage.add(ChatMessage(user: user1, text: 'Hello', createdAt: DateTime.now()));
    chatMessage.add(ChatMessage(user: user2, text: 'Im user2', createdAt: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(inquiryTitle),
        backgroundColor: tealColor,
      ),
      body: DashChat(currentUser: user1, onSend: (ChatMessage m) {
        setState(() {
          chatMessage.insert(0, m);
        });
      }, messages: chatMessage),
    );
  }
}
