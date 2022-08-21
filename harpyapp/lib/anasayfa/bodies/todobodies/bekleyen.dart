import 'package:flutter/material.dart';

class BekleyenBody extends StatefulWidget {
  const BekleyenBody({super.key});

  @override
  State<BekleyenBody> createState() => _BekleyenBodyState();
}

class _BekleyenBodyState extends State<BekleyenBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("bekleyen işler"));
  }
}
