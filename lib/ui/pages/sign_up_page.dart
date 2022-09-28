part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FlutterTts tts = FlutterTts();

  initState() {
    super.initState();
    tts.setLanguage('id-ID');
    tts.setSpeechRate(0.4);
  }

  void dispose() {
    super.dispose();
    tts.stop();
  }

  playAudio(String text) async {
    tts.speak(text);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 22),
                height: 56,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                    Center(
                      child: GestureDetector(
                        onDoubleTap: () {
                          playAudio("Buat Akun Baru");
                        },
                        child: Text(
                          "Buat Akun\nBaru",
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 104,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onDoubleTap: () {
                          playAudio("Atra");
                        },
                        child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.contain,
                              ),
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {},
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Alamat email",
                  hintText: "Alamat email",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Kata sandi",
                  hintText: "Kata sandi",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: retypePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Konfirmasi kata sandi",
                  hintText: "Konfirmasi kata sandi",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                onPressed: () async {
                  if (!(emailController.text.trim() != "" &&
                      passwordController.text.trim() != "" &&
                      retypePasswordController.text.trim() != "")) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Tolong lengkapi data!",
                    )..show(context);
                  } else if (passwordController.text.trim() !=
                      retypePasswordController.text.trim()) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Kata sandi tidak sama!",
                    )..show(context);
                  } else if (passwordController.text.length < 6) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Kata sandi harus lebih dari 6 karakter!",
                    )..show(context);
                  } else if (!EmailValidator.validate(emailController.text)) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Format alamat email salah!",
                    )..show(context);
                  } else {
                    // String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    final result = await AuthServices.signUp(email, password);

                    if (result?.uid == null)
                      FlushbarWidget(context, result.message);
                    else
                      Navigator.pop(context);
                  }
                  // print("Signup");
                  // await AuthServices.signUp("yopiangga@gmail.com", "123456");
                  // print("Signup done");
                },
                child: Icon(Icons.arrow_forward),
                elevation: 0,
                backgroundColor: mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
