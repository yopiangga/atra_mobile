part of 'widgets.dart';

Widget ShowDialogLoadingWidget({context}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
            // The background color
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                child:
                    SpinKitWave(color: mainColor, type: SpinKitWaveType.start),
              ),
            ));
      });
}
