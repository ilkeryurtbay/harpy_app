import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpScreen extends StatefulWidget {
  final String title;
  const SignUpScreen({super.key, required this.title});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode2 = AutovalidateMode.disabled;
  late String email;
  String password = "";
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/images/logo_white.png",
                  width: MediaQuery.of(context).size.width * 2 / 4,
                ),
                const Text(
                  "Harpy for Job",
                  style: TextStyle(color: Colors.white, fontSize: 24),
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
                                onSaved: (value) {
                                  setState(() {
                                    email = value!;
                                  });
                                },
                                autovalidateMode: autovalidateMode2,
                                validator: FieldValidator.email(
                                    message:
                                        "Ge??erli bir e-mail adresi giriniz!"),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: "E-mail",
                                    labelStyle: TextStyle(fontSize: 16),
                                    border: OutlineInputBorder())),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                validator: FieldValidator.password(
                                    shouldContainNumber: true,
                                    onNumberNotPresent: () =>
                                        "??ifre say?? i??ermelidir",
                                    shouldContainCapitalLetter: true,
                                    onCapitalLetterNotPresent: () =>
                                        "??ifre b??y??kharf i??ermelidir",
                                    shouldContainSmallLetter: true,
                                    shouldContainSpecialChars: true,
                                    onSpecialCharsNotPresent: () =>
                                        "??ifre ??zel karakter i??ermelidir",
                                    minLength: 8,
                                    maxLength: 15,
                                    errorMessage:
                                        "En az 8-15 karakter uzunlu??unda olmal??d??r\n??ifre k??????k harf i??ermelidir"),
                                autovalidateMode: autovalidateMode2,
                                obscureText: isObscureText,
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isObscureText = !isObscureText;
                                        });
                                      },
                                      child: Icon(isObscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    labelText: "??ifre",
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: const OutlineInputBorder())),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                validator: FieldValidator.equalTo(password,
                                    message: "??ifreler ayn?? de??il"),
                                autovalidateMode: AutovalidateMode.always,
                                obscureText: isObscureText,
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isObscureText = !isObscureText;
                                        });
                                      },
                                      child: Icon(isObscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                    labelText: "??ifre (Tekrar)",
                                    labelStyle: const TextStyle(fontSize: 16),
                                    border: const OutlineInputBorder())),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: signUpEmail,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Colors.teal[600]),
                                  child: const Text(
                                    "Kay??t Ol!",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                )),
                          ],
                        ))),
                TextButton(
                  child: const Text("Hesab??n??z var m??? Giri?? Yap??n!"),
                  onPressed: () {
                    Navigator.pushNamed(context, "signin");
                  },
                )
              ]),
        ),
      ),
    );
  }

  Future signUpEmail() async {
    autovalidateMode2 = AutovalidateMode.always;
    if (formKey2.currentState!.validate()) {
      formKey2.currentState!.save();
      autovalidateMode2 = AutovalidateMode.disabled;
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        value.user!.sendEmailVerification().then((value) {
          alertWarning(
              "L??tfen e-mail adresinize gelen do??rulama mailini onaylay??n??z!");
          auth.signOut();
        });
      }).catchError((onError) {
        alertWarning("Sisteme kay??tl?? bir E-mail adresi girdiniz. ");
      });
    } else {
      autovalidateMode2 = AutovalidateMode.always;
    }
  }

  void alertWarning(desc) {
    Alert(
        context: context,
        style: const AlertStyle(
            titleStyle: TextStyle(color: Colors.white),
            descStyle: TextStyle(color: Colors.white)),
        type: AlertType.warning,
        title: "Uyar??!",
        desc: desc,
        buttons: [
          DialogButton(
            onPressed: () {
              currentUser != null
                  ? Navigator.pushNamed(context, "signin")
                  : Navigator.pop(context);
            },
            child: const Text(
              "Kapat",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          )
        ]).show();
  }
}
