import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:harpyapp/anasayfa/bodies/todobodies/bekleyen.dart';
import 'package:harpyapp/anasayfa/bodies/todobodies/devameden.dart';
import 'package:harpyapp/anasayfa/bodies/todobodies/tamamlanan.dart';

class TodoBody extends StatefulWidget {
  const TodoBody({super.key});

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? photoURL = FirebaseAuth.instance.currentUser!.photoURL;
  int currentIndexTodo = 0;
  List<Widget> getTodoBody = [
    const BekleyenBody(),
    const DevamEdenBody(),
    const TamamlananBody(),
  ];
  int tamamlanan = 0;
  int devameden = 0;
  int bekleyen = 0;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: CircleAvatar(radius: 50.0,
                backgroundImage:
                    NetworkImage(photoURL.toString()),
                backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text("$tamamlanan\nBekleyen",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13)),
                    onPressed: () {
                      setState(() {
                        currentIndexTodo = 0;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text("$devameden\nDevam eden",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                        )),
                     onPressed: () {
                      setState(() {
                        currentIndexTodo = 1;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text("$bekleyen\nTamamlanan",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 13)),
                     onPressed: () {
                      setState(() {
                        currentIndexTodo = 2;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),




          Padding(
            padding: const EdgeInsets.all(10),
            child: getTodoBody[currentIndexTodo],
          )
        ],
      ),
    );
  }
}
