part of 'pages.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool loading = false;

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

  @override
  Widget build(BuildContext context) {
    auth.User user = Provider.of<auth.User>(context);
    final _documents = Provider.of<DocumentProvider>(context);
    List<DocumentModel> documents = _documents.documents;

    // print(shareUID);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  playAudio("Ayo Membaca");
                },
                child: Container(
                  height: 136,
                  decoration: BoxDecoration(
                    // color: Colors.grey[200]
                    image: DecorationImage(
                      image: AssetImage('assets/images/start-animation.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70, bottom: 16),
                child: GestureDetector(
                  onDoubleTap: () {
                    playAudio("Jelajahi Dunia");
                  },
                  child: Text(
                    "Jelajahi Dunia",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
              ),
              GestureDetector(
                onDoubleTap: () {
                  playAudio("Baca dan belajar apapun bersama Aisoru");
                },
                child: Text("Baca dan belajar apapun \nbersama Aisoru",
                    style: greyTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center),
              ),
              Container(
                width: 250,
                height: 46,
                margin: EdgeInsets.only(top: 70),
                child: ElevatedButton(
                  child: Text("Mulai Sekarang",
                      style: whiteTextFont.copyWith(fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColor),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                user != null ? MainPage() : SignInPage()));
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  width: 250,
                  height: 46,
                  margin: EdgeInsets.only(top: 15, bottom: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: mainColor),
                  ),
                  child: Center(
                    child: loading
                        ? SpinKitWave(
                            color: mainColor,
                            type: SpinKitWaveType.start,
                            size: 16,
                          )
                        : Text("Pindai Langsung",
                            style: whiteTextFont.copyWith(
                                fontSize: 16, color: mainColor)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      playAudio("Belum memiliki Akun? Daftar Sekarang");
                    },
                    child: Text("Belum memiliki Akun? ",
                        style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400)),
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
            ]),
      ),
    );
  }
}
