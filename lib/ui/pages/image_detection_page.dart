part of 'pages.dart';

class ImageDetectionPage extends StatefulWidget {
  List<imageLabelling.ImageLabel> labels;
  File image;

  ImageDetectionPage({this.labels, this.image});

  @override
  State<ImageDetectionPage> createState() => _ImageDetectionPageState();
}

class _ImageDetectionPageState extends State<ImageDetectionPage> {
  FlutterTts tts = FlutterTts();
  bool statusPlay = false;

  initState() {
    super.initState();
    tts.setLanguage('en-US');
    tts.setSpeechRate(0.4);
  }

  void dispose() {
    super.dispose();
    tts.stop();
  }

  playAudio(String text) async {
    tts.speak(text);
  }

  String preProcess(List<imageLabelling.ImageLabel> dataLabel) {
    String temp = "";
    for (imageLabelling.ImageLabel label in dataLabel) {
      final String text = label.label;
      final int index = label.index;
      final double confidence = label.confidence;
      temp += text + ", ";
    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: accentColor1,
        elevation: 0,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () {
            playAudio("Deteksi Objek");
          },
          child: Text(
            "Deteksi Objek",
            style: blackTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Container(
              // height: expand ? double.infinity : 110,
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Objek Terdeteksi".toString(),
                                style: blackTextFont.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.labels.length.toString() +
                                    " Objek berhasil terdeteksi",
                                maxLines: 2,
                                style: blackTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (statusPlay) {
                            tts.stop();
                          } else {
                            playAudio(preProcess(widget.labels));
                          }

                          setState(() {
                            statusPlay = !statusPlay;
                          });
                        },
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: (statusPlay)
                                    ? Colors.grey[400]
                                    : mainColor),
                            child: (statusPlay)
                                ? Icon(
                                    Icons.stop_circle_outlined,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.record_voice_over_rounded,
                                    color: Colors.white,
                                  )),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.labels
                          .map((el) => Text(
                                el.label,
                                style: blackTextFont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ))
                          .toList())
                ],
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Image.file(widget.image),
          )
        ],
      ),
    );
  }
}
