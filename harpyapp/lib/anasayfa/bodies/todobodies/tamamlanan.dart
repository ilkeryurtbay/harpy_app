import 'package:flutter/material.dart';

class TamamlananBody extends StatefulWidget {
  const TamamlananBody({super.key});

  @override
  State<TamamlananBody> createState() => _TamamlananBodyState();
}

class _TamamlananBodyState extends State<TamamlananBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("tamamlanan işler"));
  }
}
