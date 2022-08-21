import 'package:flutter/material.dart';

class NewsBody extends StatefulWidget {
  const NewsBody({super.key});

  @override
  State<NewsBody> createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("News Body"));
  }
}
