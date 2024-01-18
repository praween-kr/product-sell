import 'package:flutter/material.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

/// New Timer
class AppTimer extends StatelessWidget {
  const AppTimer({
    super.key,
    required this.duration,
    required this.startDateTime,
    this.viewType = false,
    this.textSize,
    this.onChanged,
    this.bidingStarted = false,
    required this.bidNow,
  });
  // Required Params
  final Duration duration;
  final Function(TimerType)? onChanged;
  final DateTime startDateTime;
  final bool viewType;
  final double? textSize;
  final bool bidingStarted;
  final Function bidNow;
  //
  static bool _running = true;
  //
  Stream<TimerType> _clock() async* {
    _running = true;
    try {
      Duration def = startDateTime.difference(DateTime.now());
      int defInDays = def.inDays;
      if (defInDays == 0) {
        while (_running) {
          await Future<void>.delayed(const Duration(seconds: 1));
          TimerType data = TimerType(
              value: "00:00:00",
              color: Colors.red,
              status: TimerTypeStatus.UPCOMING);
          // Runing timer
          DateTime targetDT = startDateTime;
          DateTime today = DateTime.now();

          // Start in--
          bool isWillStart = false;
          Duration d1 = startDateTime.difference(DateTime.now());
          if (d1.inSeconds > 0) {
            isWillStart = true;
          } else if (bidingStarted) {
            targetDT = startDateTime.add(duration);
          }
          //-----------
          Duration liveTime = targetDT.difference(today);
          int x = liveTime.inSeconds;

          if (x > 0) {
            data = TimerType(
                value: reminderTime(liveTime),
                color: isWillStart ? Colors.blue : Colors.red,
                status: isWillStart
                    ? TimerTypeStatus.UPCOMING
                    : TimerTypeStatus.GOINGON);
          } else {
            // Timer over/no bit yet----------
            data = TimerType(
                value: "00:00:00",
                color: bidingStarted ? Colors.red : Colors.blue,
                status: bidingStarted
                    ? TimerTypeStatus.END
                    : TimerTypeStatus.GOINGON_NO_BID_YET);
            _running = false;
          }
          if (onChanged != null) {
            onChanged!(data);
          }
          yield data;
        }
      } else if (defInDays > 0) {
        TimerType data = TimerType(
            value: "$defInDays ${defInDays == 1 ? 'day' : 'days'}",
            color: Colors.blue,
            status: TimerTypeStatus.UPCOMING);
        yield data;
      } else {
        // _bidOver();
        TimerType data = TimerType(
            value: "end", color: Colors.red, status: TimerTypeStatus.END);
        yield data;
      }
    } catch (e) {
      // print("Timer Start to --> (Error)-> djfksdfsfslfskldfjdsjfdsjf");
    }
  }

  String reminderTime(Duration duration) {
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
            return viewType
                ? ShimmerWidgets.text(
                    w: 60, h: 12, color: AppColor.themeColor.withOpacity(0.5))
                : timerWidget(
                    timeChild: ShimmerWidgets.text(
                        w: 80,
                        h: 16,
                        color: AppColor.themeColor.withOpacity(0.5)));
          }
          return viewType
              ? Text(
                  snapshot.data?.value ?? '00:00:00',
                  style: TextStyle(
                      fontSize: textSize ?? 20,
                      color: snapshot.data?.color ?? Colors.red),
                )
              : timerWidget(
                  timeChild: Text(
                  snapshot.data?.value ?? '00:00:00',
                  style: TextStyle(
                      fontSize: textSize ?? 20,
                      color: snapshot.data?.color ?? Colors.red),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimerType {
  final String value;
  final Color color;
  final TimerTypeStatus status;
  TimerType({required this.value, required this.color, required this.status});
}

enum TimerTypeStatus { END, GOINGON, UPCOMING, GOINGON_NO_BID_YET }
