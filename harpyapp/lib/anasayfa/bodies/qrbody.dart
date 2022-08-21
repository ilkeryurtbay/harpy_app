import 'package:flutter/material.dart';

class QRBody extends StatefulWidget {
  const QRBody({super.key});

  @override
  State<QRBody> createState() => _QRBodyState();
}

class _QRBodyState extends State<QRBody> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("QR"));
  }
}
