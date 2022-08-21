import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyBottomBar extends StatefulWidget {
  final int currentIndex;
  ValueChanged<int> onClicked;
  MyBottomBar({super.key, required this.currentIndex, required this.onClicked});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onClicked,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "Haberler"),
        BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: "Mesajlaşma"),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "QR Code"),
        BottomNavigationBarItem(icon: Icon(Icons.add_task), label: "Görevler"),
      ],
    );
  }
}
