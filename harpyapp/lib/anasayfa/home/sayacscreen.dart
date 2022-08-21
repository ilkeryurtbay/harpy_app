// import 'package:flutter/material.dart';
// import 'package:harpyapp/model/sayac.dart';
// import 'package:harpyapp/utils/appbar.dart';
// import 'package:provider/provider.dart';

// class ProviderSayacScreen extends StatefulWidget {
//   final String title;
//   const ProviderSayacScreen({super.key, required this.title});

//   @override
//   State<ProviderSayacScreen> createState() => _ProviderSayacScreenState();
// }

// class _ProviderSayacScreenState extends State<ProviderSayacScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PreferredSize(
//           preferredSize: Size.fromHeight(kToolbarHeight),
//           child: MyAppBar(title: "Provider Sayaç")),
//       body: Consumer<Sayac>(builder: (context, sayac, child) {
//         return Container(
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             //crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.green),
//                 onPressed: () {
//                   sayac.arttir();
//                 },
//                 child: const Text(
//                   "+",
//                   style: TextStyle(fontSize: 24, color: Colors.white),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(sayac.value.toString(),
//                   style: TextStyle(
//                       fontSize: 24,
//                       color: sayac.value >= 0 ? Colors.green : Colors.red)),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.red),
//                 onPressed: () {
//                   sayac.azalt();
//                 },
//                 child: const Text("-",
//                     style: TextStyle(fontSize: 24, color: Colors.white)),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
