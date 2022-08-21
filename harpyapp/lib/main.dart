import 'package:flutter/material.dart';
import 'package:harpyapp/anasayfa/settingsbodies/acountbody.dart';
import 'package:harpyapp/anasayfa/home/homescreen.dart';
import 'package:harpyapp/auth/signin.dart';
import 'package:harpyapp/auth/signup.dart';
import 'package:harpyapp/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = "HarpyApp";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplahsScreen(title: title),
      initialRoute: "SplahsScreen",
      routes: {
        "splash": (context) => SplahsScreen(title: title),
        "home": (context) => HomeScreen(
              title: title,
            ),
        "signin": (context) => SignInScreen(
              title: title,
            ),
        "signup": (context) => SignUpScreen(
              title: title,
            ),
        "account": (context) => AccoutScreen(
              title: title,
            ),
      },
    );
  }
}
