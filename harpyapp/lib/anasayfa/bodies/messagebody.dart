import 'package:flutter/material.dart';

class MessageBody extends StatefulWidget {
  const MessageBody({super.key});

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("MessageBody",));
  }
}
