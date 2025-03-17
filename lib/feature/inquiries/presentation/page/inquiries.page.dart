import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({super.key});

  @override
  State<InquiryPage> createState () => _InquiryPage();
}

class _InquiryPage extends State<InquiryPage> {
  late AuthBloc authBloc;
  ChatUser user1 = ChatUser(
    id: 'id-123',
  );

  ChatUser vertexAI = ChatUser(
    id: Uuid().v4(),
    firstName: 'Vertex',
    lastName: 'AI'
  );

  List<ChatMessage> chatMessage = <ChatMessage>[];

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();

    user1.firstName = (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel?.firstName : "";
    user1.lastName = (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel?.lastName : "";
  }

  void callVertexAI (String userPrompt) async {
    final model = FirebaseVertexAI.instance.generativeModel(model: 'gemini-2.0-flash');
    final prompt = [Content.text(userPrompt)];
    final response = await model.generateContent(prompt);

    setState(() {
      chatMessage.insert(0, 
        ChatMessage(user: vertexAI, text: response.text ?? '', createdAt: DateTime.now())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(inquiryTitle),
        backgroundColor: tealColor,
      ),
      body: DashChat(currentUser: user1, onSend: (ChatMessage m) {
        chatMessage.insert(0, m);
        callVertexAI(m.text);
      }, messages: chatMessage),
    );
  }
}
