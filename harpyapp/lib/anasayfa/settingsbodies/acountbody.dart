import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:harpyapp/anasayfa/home/drawerbodies/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:the_validator/the_validator.dart';

class AccoutScreen extends StatefulWidget {
  final String title;

  const AccoutScreen({super.key, required this.title});

  @override
  State<AccoutScreen> createState() => _HesapScreenState();
}

class _HesapScreenState extends State<AccoutScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? photoURL = FirebaseAuth.instance.currentUser!.photoURL;
  late String email;
  late String password;
  late String displayName;
  late String phoneNumber;
  late String smscode;
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode2 = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    image: photoURL != null
                        ? DecorationImage(
                            image: NetworkImage(photoURL.toString()))
                        : null),
                child: photoURL == null
                    ? Text(currentUser!.displayName.toString())
                    : null,
              ),
            ),
          ),
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25,),
                InkWell(
                  onTap: selectImage,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          border:Border.all(width: 6, color: Colors.blueGrey),
                            color: Colors.blueGrey[200],
                            borderRadius: BorderRadius.circular(45),
                            image: photoURL != null
                                ? DecorationImage(
                                    image: NetworkImage(photoURL.toString()))
                                : null),
                        child: currentUser!.photoURL == null
                            ? Text(
                                currentUser!.displayName.toString(),
                                style: const TextStyle(fontSize: 24),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              border:Border.all(width: 3, color: Colors.black38),  
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(Icons.camera_alt,color: Colors.black,)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 5),
                    child: Form(
                        key: formKey2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                                initialValue: currentUser!.email.toString(),
                                onSaved: (value) {
                                  setState(() {
                                    email = value!;
                                  });
                                },
                                autovalidateMode: autovalidateMode2,
                                validator: FieldValidator.email(
                                    message:
                                        "Geçerli bir e-mail adresi giriniz!"),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: "E-mail",
                                    labelStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder())),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                initialValue:
                                    currentUser!.displayName.toString(),
                                onSaved: (value) {
                                  setState(() {
                                    displayName = value!;
                                  });
                                },
                                autovalidateMode: autovalidateMode2,
                                validator: FieldValidator.minLength(3,
                                    message:
                                        "Adınız en az 3 karakterden oluşmalıdır"),
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                    labelText: "Adınız",
                                    labelStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder())),
                            const SizedBox(
                              height: 10,
                            ),
                            IntlPhoneField(
                              initialValue: currentUser!.phoneNumber.toString(),
                              autovalidateMode: autovalidateMode2,
                              decoration: const InputDecoration(
                                labelText: 'Telefon Numarası',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              initialCountryCode: 'TR',
                              onSaved: (value) {
                                setState(() {
                                  phoneNumber =
                                      value!.countryCode + value.number;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: updateCurrentUser,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Colors.teal[600]),
                                  child: const Text(
                                    "Güncelle",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                )),
                          ],
                        ))),
              ]),
        ),
      ),
    );
  }

  void selectImage() {
    Alert(
      style: const AlertStyle(
          titleStyle: TextStyle(color: Colors.white),
          descStyle: TextStyle(color: Colors.white)),
      context: context,
      image: photoURL != null
          ? Image.network(photoURL.toString())
          : Image.asset("assets/images/logo.png"),
      title: "Profil Resmi Değiştirme",
      buttons: [],
      content: Column(children: [
        photoURL != null
            ? DialogButton(
                onPressed: () {
                  currentUser!.updatePhotoURL(null);
                  setState(() {
                    photoURL = null;
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  "Resmi Sil",
                  style: TextStyle(color: Colors.black),
                ),
              )
            : const SizedBox.shrink(),
        DialogButton(
          onPressed: () async {
            await ImagePicker()
                .pickImage(source: ImageSource.camera)
                .then((value) => updatePhotoURL(value!.path))
                .catchError((onError) {
              debugPrint("Resim Çekilemedi");
            });
          },
          child: const Text(
            "Resim Çek",
            style: TextStyle(color: Colors.black),
          ),
        ),
        DialogButton(
          onPressed: () async {
            await ImagePicker()
                .pickImage(source: ImageSource.gallery)
                .then((value) => updatePhotoURL(value!.path))
                .catchError((onError) {
              debugPrint("Galeriden resim alınamadı");
            });
          },
          child: const Text(
            "Galeriden Yüükle",
            style: TextStyle(color: Colors.black),
          ),
        )
      ]),
    ).show();
  }

  void alertWarning(desc) {
    Alert(
        context: context,
        style: const AlertStyle(
            titleStyle: TextStyle(color: Colors.white),
            descStyle: TextStyle(color: Colors.white)),
        type: AlertType.warning,
        title: "Uyarı!",
        desc: desc,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Kapat",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          )
        ]).show();
  }

  void alertSuccess(desc) {
    Alert(
        context: context,
        style: const AlertStyle(
            titleStyle: TextStyle(color: Colors.white),
            descStyle: TextStyle(color: Colors.white)),
        type: AlertType.success,
        title: "Başarılı!",
        desc: desc,
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Kapat",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          )
        ]).show();
  }

  updatePhotoURL(String path) {
    storage
        .ref()
        .child("uploads/images/users/${currentUser!.uid}/photo")
        .putFile(File(path))
        .then((p0) => p0.ref.getDownloadURL().then((value) {
              currentUser!.updatePhotoURL(value);
              setState(() {
                photoURL = value;
              });
              Navigator.pop(context);
            }).catchError((onError) {
              debugPrint("dosya URL bilgisi alınamadı");
            }))
        .catchError((onError) {
      debugPrint("dosya yüklenemedi");
    });
  }

  void updateCurrentUser() {
    autovalidateMode2 = AutovalidateMode.always;
    if (formKey2.currentState!.validate()) {
      formKey2.currentState!.save();
      autovalidateMode2 = AutovalidateMode.disabled;
      currentUser!.updateDisplayName(displayName).then((value) {
        //debugPrint("yeni isim:${currentUser!.displayName.toString()}");
        reAuth();
      }).catchError((onError) {
        debugPrint("displayName güncelleneemdi!");
      });
    } else {
      autovalidateMode2 = AutovalidateMode.always;
    }
  }

  void reAuth() {
    Alert(
        context: context,
        type: AlertType.warning,
        title: "Şifre Kontrol",
        desc: "Lütfen şifrenizi giriniz!",
        content: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              autofocus: true,
              autovalidateMode: AutovalidateMode.always,
              validator:
                  FieldValidator.required(message: "Doldurulması Zorunludur!"),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.vpn_key),
                  errorStyle: const TextStyle(fontSize: 18),
                  labelText: "Şifre",
                  labelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.purple))),
            ),
            const SizedBox(height: 10),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              currentUser!
                  .reauthenticateWithCredential(EmailAuthProvider.credential(
                      email: currentUser!.email.toString(), password: password))
                  .then((value) {
                value.user!.updateEmail(email).then((value) {
                  debugPrint("e-mail güncellendi");
                  updatePhone();
                }).catchError((onError) {
                  debugPrint("email güncellenemedi");
                });
                Navigator.pop(context);
              }).catchError((onError) {
                alertWarning("Hatalı Şifre giridiniz");
              });
            },
            child: const Text(
              "Doğrula",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void updatePhone() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: 3,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (user) {
          debugPrint("giriş tamam");
        },
        verificationFailed: (expection) {
          debugPrint("giriş hatası");
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint("timeout hatası");
        });
  }

  void codeSent(String verificationId, int? forceResendingToken) {
    Alert(
        context: context,
        type: AlertType.warning,
        title: "SMS CODE",
        desc: "Cep telefonunuza gelen Sms Kodu giriniz!",
        content: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  smscode = value;
                });
              },
              autofocus: true,
              autovalidateMode: AutovalidateMode.always,
              validator:
                  FieldValidator.required(message: "Doldurulması Zorunludur!"),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.vpn_key),
                  errorStyle: const TextStyle(fontSize: 18),
                  labelText: "Sms Code",
                  labelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.purple))),
            ),
            const SizedBox(height: 10),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smscode);
              currentUser!.updatePhoneNumber(credential).then((value) {
                debugPrint("telefon güncellendi!");
              }).catchError((onError) {
                debugPrint("telefon güncellenmedi!: ${onError.toString()}");
              });
            },
            child: const Text(
              "GÖNDER",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
