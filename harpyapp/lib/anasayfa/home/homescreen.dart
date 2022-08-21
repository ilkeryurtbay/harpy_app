import 'package:flutter/material.dart';
import 'package:harpyapp/anasayfa/bodies/messagebody.dart';
import 'package:harpyapp/anasayfa/bodies/newsbody.dart';
import 'package:harpyapp/anasayfa/bodies/qrbody.dart';
import 'package:harpyapp/anasayfa/bodies/todobody.dart';
import 'package:harpyapp/anasayfa/home/drawerbodies/settings.dart';
import 'package:harpyapp/utils/mybottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  int currentIndex = 0;
  List<Widget> getBody = [
    const NewsBody(),
    const MessageBody(),
    const QRBody(),
    const TodoBody()
  ];
  @override
  Widget build(BuildContext context) {
    void onClicked(index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                showModalBottomSheet(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.33),
                  backgroundColor: Colors.grey[700],
                  barrierColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        const Icon(
                          Icons.horizontal_rule,
                          color: Colors.white,
                          size: 32,
                        ),
                        ListTile(
                            leading: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            title: const Text("Ayarlar"),
                            textColor: Colors.white,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SettingsBody(
                                            title: "Ayarlar",
                                          )));
                            }),
                        ListTile(
                          leading: const Icon(
                            Icons.qr_code,
                            color: Colors.white,
                          ),
                          title: const Text("QR Code"),
                          textColor: Colors.white,
                          onTap: () => false,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.perm_identity_outlined,
                            color: Colors.white,
                          ),
                          title: const Text("Personel Kimliği"),
                          textColor: Colors.white,
                          onTap: () => false,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.medical_information,
                            color: Colors.white,
                          ),
                          title: const Text("Kişisel Bilgilerim"),
                          textColor: Colors.white,
                          onTap: () => false,
                        )
                      ],
                    );
                  },
                );
              },
            ),
            InkWell(
                onTap: () => Navigator.pushNamed(context, "account"),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        image: currentUser!.photoURL != null
                            ? DecorationImage(
                                image: NetworkImage(
                                    currentUser!.photoURL.toString()))
                            : null),
                    child: currentUser!.photoURL == null
                        ? Text(currentUser!.displayName.toString())
                        : null,
                  ),
                )),
            IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushNamed(context, "signin");
                });
              },
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: getBody[currentIndex],
        bottomNavigationBar:
            MyBottomBar(currentIndex: currentIndex, onClicked: onClicked));
  }
}
