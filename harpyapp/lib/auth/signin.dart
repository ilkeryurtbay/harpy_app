import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:the_validator/the_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInScreen extends StatefulWidget {
  final String title;
  const SignInScreen({super.key, required this.title});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn google = GoogleSignIn();
  FacebookAuth facebook = FacebookAuth.instance;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  AutovalidateMode autovalidateMode2 = AutovalidateMode.disabled;

  
  // ignore: unused_field
  Map? _userData;

  late String phone;
  late String email;
  late String password;
  late String smscode;
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.teal[400],
                        unselectedLabelColor: Colors.white,
                        tabs: const [
                          Tab(
                            text: "Telefon",
                          ),
                          Tab(text: "E-mail")
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.topCenter,
                        height: 300,
                        child: TabBarView(
                          children: [
                            Container(
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 5),
                                child: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IntlPhoneField(
                                          autovalidateMode: autovalidateMode,
                                          decoration: const InputDecoration(
                                            labelText: 'Telefon Numarası',
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                            ),
                                          ),
                                          initialCountryCode: 'TR',
                                          onSaved: (value) {
                                            setState(() {
                                              phone = value!.countryCode +
                                                  value.number;
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        InkWell(
                                            onTap: signInPhone,
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.teal[600]),
                                              child: const Text(
                                                "Giriş",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                            )),
                                      ],
                                    ))),
                            Container(
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 5),
                                child: Form(
                                    key: formKey2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                    "Geçerli bir e-mail adresi giriniz!"),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                                labelText: "E-mail",
                                                labelStyle:
                                                    TextStyle(fontSize: 16),
                                                border: OutlineInputBorder())),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            onSaved: (value) {
                                              setState(() {
                                                password = value!;
                                              });
                                            },
                                            validator: FieldValidator.password(
                                                shouldContainNumber: true,
                                                onNumberNotPresent: () =>
                                                    "Şifre sayı içermelidir",
                                                shouldContainCapitalLetter:
                                                    true,
                                                onCapitalLetterNotPresent: () =>
                                                    "Şifre büyükharf içermelidir",
                                                shouldContainSmallLetter: true,
                                                shouldContainSpecialChars: true,
                                                onSpecialCharsNotPresent: () =>
                                                    "Şifre özel karakter içermelidir",
                                                minLength: 8,
                                                maxLength: 15,
                                                errorMessage:
                                                    "En az 8-15 karakter uzunluğunda olmalıdır\nŞifre küçük harf içermelidir"),
                                            autovalidateMode: autovalidateMode2,
                                            obscureText: isObscureText,
                                            decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isObscureText =
                                                          !isObscureText;
                                                    });
                                                  },
                                                  child: Icon(isObscureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                                ),
                                                labelText: "Şifre",
                                                labelStyle: const TextStyle(
                                                    fontSize: 16),
                                                border:
                                                    const OutlineInputBorder())),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                              onPressed: resetPassword,
                                              child: const Text(
                                                  "Şifrenizi mi unuttunuz?")),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                            onTap: signInEmail,
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.teal[600]),
                                              child: const Text(
                                                "Giriş",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                            )),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 1,
                    color: Colors.white,
                  )),
                  const Expanded(
                      child: Text(
                    "YA DA",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 1,
                    color: Colors.white,
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: TextButton.icon(
                        onPressed: signInGoogle,
                        icon: const FaIcon(FontAwesomeIcons.google),
                        label: const Text("Google ile giriş yap")),
                  )),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: TextButton.icon(
                        onPressed: signInFacebook,
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        label: const Text("Facebook ile giriş yap")),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                child: const Text("Üye değil misiniz? Kayıt Olun!"),
                onPressed: () {
                  Navigator.pushNamed(context, "signup");
                },
              )
            ]),
      ),
    );
  }

  void signInPhone() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      auth.verifyPhoneNumber(
          phoneNumber: phone,
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
  }

  Future signInEmail()  async {
    autovalidateMode2 = AutovalidateMode.always;
    if (formKey2.currentState!.validate()) {
      formKey2.currentState!.save();
      autovalidateMode2 = AutovalidateMode.disabled;
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user!.emailVerified) {
          Navigator.pushNamed(context, "home");
        } else {
          value.user!.sendEmailVerification();
          alertWarning(
              "Lütfen e-mail adresinize gelen doğrulama mailini onaylayınız!");
        }
      }).catchError((onError) {
        alertWarning("Email ve/veya şifre hatalı ");
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

  void resetPassword() {
    Alert(
        style: const AlertStyle(
            titleStyle: TextStyle(color: Colors.white),
            descStyle: TextStyle(color: Colors.white)),
        context: context,
        type: AlertType.warning,
        title: "Şifre Sıfırlama",
        desc: "Lütfen e-mail adresinizi giriniz",
        buttons: [],
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                autovalidateMode: AutovalidateMode.always,
                validator: FieldValidator.email(
                    message: "Geçerli bir e-mail adresi giriniz!"),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder())),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  auth.sendPasswordResetEmail(email: email).then((value) {
                    Navigator.pop(context);
                    alertWarning(
                        "E-mail adresinize gönderilen mail ile şifrenizi sıfırlayabilirsiniz.");
                  }).catchError((onError) {
                    alertWarning(
                        "Lütfen sisteme kayıtlı bir email adresi giriniz");
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.teal[600]),
                  child: const Text(
                    "Giriş",
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ],
        )).show();
  }

  void signInGoogle() {
    google.signIn().then((value) {
      value!.authentication.then((token) {
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: token.accessToken, idToken: token.idToken);
        auth.signInWithCredential(credential).then((result) {
          Navigator.pushNamed(context, "home");
        }).catchError((onError) {
          debugPrint("credantial hatası: $onError");
        });
      }).catchError((onError) {
        debugPrint("token: $onError");
      });
    }).catchError((onError) {
      debugPrint("google: $onError");
    });
  }

  void signInFacebook() {
    facebook.login().then((value) {
      AuthCredential credential =
          FacebookAuthProvider.credential(value.accessToken!.token);
      auth.signInWithCredential(credential).then((result) {
        Navigator.pushNamed(context, "home");
      }).catchError((onError) {
        debugPrint("facebook credential hata: ${onError.toString()}");
      });
    }).catchError((onError) {
      debugPrint("facebook login hata: ${onError.toString()}");
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
              AuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smscode);
              auth.signInWithCredential(credential).then((user) {
                Navigator.pushNamed(context, "home");
              }).catchError((onError) {
                debugPrint("credential hatası");
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
