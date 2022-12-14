part of 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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

  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      playAudio("Atra");
                    },
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          // color: Colors.grey[600],
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      playAudio("Selamat Datang Kembali");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30, bottom: 40),
                      child: Text("Selamat Datang\nKembali",
                          style: blackTextFont.copyWith(fontSize: 20)),
                    ),
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Alamat email",
                        hintText: "Alamat email"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Kata sandi",
                        hintText: "Kata sandi"),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 40, bottom: 30),
                      child: isSignIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              backgroundColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : Color(0xFFE4E4E4),
                              onPressed: isEmailValid && isPasswordValid
                                  ? () async {
                                      setState(() {
                                        isSignIn = true;
                                      });

                                      SignInSignUpResult result =
                                          await AuthServices.signIn(
                                              _emailController.text.trim(),
                                              _passwordController.text.trim());
                                      setState(() {
                                        isSignIn = false;
                                      });
                                      if (result?.uid == null)
                                        FlushbarWidget(context, result.message);
                                      else
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainPage(uid: result.uid)));
                                      // print(result.message);
                                    }
                                  : null,
                              child: Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : Color(0xFFBEBEBE),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          playAudio("Belum memiliki akun? Daftar Sekarang");
                        },
                        child: Text("Belum memiliki akun? ",
                            style: greyTextFont.copyWith(
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text("Daftar Sekarang", style: blueTextFont))
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
