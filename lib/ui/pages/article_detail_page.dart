part of 'pages.dart';

class ArticleDetailPage extends StatefulWidget {
  ArticleModel article;

  ArticleDetailPage({this.article});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool getData = true;
  bool statusPlay = false;

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
    setState(() {
      statusPlay = true;
    });
    tts.speak(text);
    tts.setCompletionHandler(() {
      setState(() {
        statusPlay = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _language = Provider.of<LanguageProvider>(context);
    List<LanguageModel> language = _language.items;

    if (getData) {
      tts.setLanguage(_language.selectedKey);
    }

    return Scaffold(
        appBar: AppBar(
          foregroundColor: accentColor1,
          elevation: 0,
          backgroundColor: Colors.white,
          title: GestureDetector(
            onTap: () {
              playAudio("Artikel");
            },
            child: Text(
              "Artikel",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {
                  tts.stop();
                  setState(() {
                    statusPlay = false;
                  });
                },
                child: !statusPlay
                    ? SizedBox()
                    : Icon(
                        Icons.stop_circle_outlined,
                        color: mainColor,
                        size: 24,
                      )),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    playAudio(widget.article.title);
                  },
                  child: Text(widget.article.title,
                      style: blackTextFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 20),
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 7,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        image: DecorationImage(
                            image: NetworkImage(widget.article.image),
                            fit: BoxFit.cover))),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.article.description
                      .map((e) => GestureDetector(
                            onTap: () {
                              playAudio(e);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text(e,
                                  style: blackTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.justify),
                            ),
                          ))
                      .toList(),
                )
              ],
            )));
  }
}
