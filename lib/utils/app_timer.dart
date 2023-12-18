import 'package:flutter/material.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

class AppTimer extends StatelessWidget {
  const AppTimer(
      {super.key,
      required this.bidNow,
      required this.endTime,
      this.textType = false,
      this.textStyle});
  final Function bidNow;
  final DateTime endTime;
  final bool textType;
  final TextStyle? textStyle;

  static bool _running = true;
  Stream<String> _clock() async* {
    print("dsfsdf");
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));

      DateTime targetDT = endTime;
      DateTime today = DateTime.now();
      Duration liveTime = targetDT.difference(today);
      String value = "00:00:00";
      if (liveTime.inSeconds <= 0) {
        value = "00:00:00";
        _running = false;
      } else {
        value = _reminderTime(liveTime);
      }
      yield value;
    }
  }

  String _reminderTime(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _clock(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return textType
                ? ShimmerWidgets.text(
                    w: 60, h: 12, color: AppColor.themeColor.withOpacity(0.5))
                : timerWidget(
                    timeChild: ShimmerWidgets.text(
                        w: 80,
                        h: 16,
                        color: AppColor.themeColor.withOpacity(0.5)));
          }
          return textType
              ? Text(
                  snapshot.data ?? '00:00:00',
                  style: textStyle ??
                      const TextStyle(fontSize: 20, color: Colors.red),
                )
              : timerWidget(
                  timeChild: Text(
                  snapshot.data ?? '00:00:00',
                  style: textStyle ??
                      const TextStyle(fontSize: 20, color: Colors.red),
                ));
        });
  }

  Widget timerWidget({required Widget timeChild}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
                // borderRadius: BorderRadius.all(Radius.circular(17)),
                color: Colors.white),
            padding:
                const EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
            child: Column(
              children: [
                Image.asset(Assets.assetsClock, height: 100, width: 100),
                const SizedBox(height: 10),
                timeChild,
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => bidNow(),
                  child: const CommonButton(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    color: AppColor.appColor,
                    text: "Bid Now",
                    radius: 15,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontSize: 15,
                        color: Colors.white),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
