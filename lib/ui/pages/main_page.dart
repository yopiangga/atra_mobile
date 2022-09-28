part of 'pages.dart';

class MainPage extends StatefulWidget {
  final String uid;

  const MainPage({this.uid = ""});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController;
  bool loading = false;
  bool isGetData = true;
  bool tapPlus = false;

  Future<List<ArticleModel>> _getArticles;
  Future<List<DocumentModel>> _getDocuments;

  @override
  void initState() {
    super.initState();
    _getArticles = ArticleServices.getArticles();
    _getDocuments = DocumentServices.getDocuments(uid: widget.uid);

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    final _documents = Provider.of<DocumentProvider>(context);
    List<DocumentModel> documents = _documents.documents;
    final _articles = Provider.of<ArticleProvider>(context);
    List<ArticleModel> articles = _articles.articles;
    auth.User user = Provider.of<auth.User>(context);

    if (isGetData) {
      _getArticles.then((value) {
        setState(() {
          _articles.setArticles(value);
        });
      });

      _getDocuments.then((value) {
        setState(() {
          _documents.setDocuments(value);
        });
      });
      // print("getdata");

      setState(() {
        isGetData = false;
      });
    }

    Future<void> handleTakePicture(String mode) async {
      setState(() {
        loading = true;
      });

      File img;
      if (mode == "camera")
        img = await getImageCamera();
      else if (mode == "gallery")
        img = await getImageGallery();
      else
        img = await getImageGallery();

      if (img == null) {
        setState(() {
          loading = false;
        });
        return;
      }

      final result = await textClassification(img);

      if (result == false || result == null) {
        setState(() {
          loading = false;
        });
        return;
      } else {
        DocumentModel document = DocumentModel(
          id: "1",
          time: "0",
          uid: user.uid,
        );

        document.text.add(result[0]);
        // document.image.add(result[1]);

        final resJob = await ProsaServices.submitTTS(document.text);
        final jobId = jsonDecode(resJob.body)['job_id'];

        document.job_id = jobId;

        final res = await DocumentServices.addDocument(document);

        document.id = jsonDecode(res.body.toString())['data'];
        document.time = jsonDecode(res.body.toString())['data'];

        setState(() {
          documents.add(document);
          loading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DocumentDetailPage(
                      document: documents.last,
                    )));
      }
    }

    Future<void> handleTakeFile() async {
      setState(() {
        loading = true;
      });

      File img;

      img = await getFilePDF();

      final result = await textClassification(img);

      print(result[0]);

      setState(() {
        loading = false;
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(
              color: Color(0xFFF6F7F9),
            ),
          ),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
            },
            children: [DashboardPage(), DocumentsPage()],
          ),
          loading
              ? Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: SpinKitWave(
                        color: mainColor, type: SpinKitWaveType.start),
                  ),
                )
              : Container(),
          createCustomBottomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: tapPlus ? 64 : 46,
              height: tapPlus ? 64 : 46,
              margin: EdgeInsets.only(
                  bottom: tapPlus ? 110 : 42, right: tapPlus ? 200 : 0),
              child: FloatingActionButton(
                heroTag: "btnCamera",
                elevation: 0,
                backgroundColor: mainColor,
                onPressed: () async {
                  await handleTakePicture("camera");
                },
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: Icon(MdiIcons.camera,
                      color: Colors.white.withOpacity(1), size: 28),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: tapPlus ? 64 : 46,
              height: tapPlus ? 64 : 46,
              margin: EdgeInsets.only(
                  bottom: tapPlus ? 110 : 42, left: tapPlus ? 0 : 0),
              child: FloatingActionButton(
                heroTag: "btnGallery",
                elevation: 0,
                backgroundColor: mainColor,
                onPressed: () async {
                  await handleTakePicture("gallery");
                },
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: Icon(MdiIcons.viewGalleryOutline,
                      color: Colors.white.withOpacity(1), size: 28),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: tapPlus ? 64 : 46,
              height: tapPlus ? 64 : 46,
              margin: EdgeInsets.only(
                  bottom: tapPlus ? 110 : 42, left: tapPlus ? 200 : 0),
              child: FloatingActionButton(
                heroTag: "btnFile",
                elevation: 0,
                backgroundColor: mainColor,
                onPressed: () async {
                  // await handleTakeFile();
                },
                child: SizedBox(
                  height: 28,
                  width: 28,
                  child: Icon(MdiIcons.fileDocumentOutline,
                      color: Colors.white.withOpacity(1), size: 28),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 46,
              height: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                heroTag: "btnTap",
                elevation: 0,
                backgroundColor: mainColor,
                onPressed: () async {
                  setState(() {
                    tapPlus = !tapPlus;
                  });
                  return;
                },
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: Icon(
                    MdiIcons.plus,
                    color: Colors.white.withOpacity(1),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createCustomBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomNavBarClipper(),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: mainColor,
            unselectedItemColor: Color(0xFFE5E5E5),
            currentIndex: bottomNavBarIndex,
            onTap: (index) {
              setState(() {
                bottomNavBarIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Icon(
                        MdiIcons.viewDashboard,
                        color: (bottomNavBarIndex == 0)
                            ? mainColor
                            : accentColor1.withOpacity(0.7),
                      ),
                    ),
                    height: 20,
                    margin: EdgeInsets.only(bottom: 6),
                  ),
                  label: "Beranda"),
              BottomNavigationBarItem(
                  icon: Container(
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Icon(
                        MdiIcons.fileDocumentMultiple,
                        color: (bottomNavBarIndex == 1)
                            ? mainColor
                            : accentColor1.withOpacity(0.7),
                      ),
                    ),
                    height: 20,
                    margin: EdgeInsets.only(bottom: 6),
                  ),
                  label: "Dokumen Saya"),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
