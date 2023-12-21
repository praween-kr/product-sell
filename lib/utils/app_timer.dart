import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

class AppTimer extends StatelessWidget {
  const AppTimer({
    super.key,
    required this.productId,
    required this.bidNow,
    required this.endTime,
    this.textType = false,
    this.textSize,
    this.onChanged,
    this.bidIsRuning = false,
    this.firstBid,
  });
  final String productId;
  final Function bidNow;
  final DateTime? endTime;
  final bool textType;
  final double? textSize;
  static bool _running = true;
  final Function(TimerType)? onChanged;
  final bool bidIsRuning;
  final DateTime? firstBid;
  //
  _bidOver() {
    HomeCatProductController hcpc;
    if (HomeCatProductController().initialized) {
      hcpc = Get.find<HomeCatProductController>();
    } else {
      hcpc = Get.put(HomeCatProductController());
    }
    hcpc.bidOver(productId: productId);
  }

  //
  Stream<TimerType> _clock() async* {
    _running = true;
    try {
      DateTime td = DateTime.parse(DateTime.now().toString().split(" ").first);
      DateTime ed = DateTime.parse(endTime.toString().split(" ").first);
      int defInDays = ed.difference(td).inDays;
      print("Bid-> End time----->>>>>> $endTime -- $defInDays}");
      if (defInDays == 0) {
        while (_running && endTime != null) {
          print("Bid-> End time----->>>>>> 01");
          await Future<void>.delayed(const Duration(seconds: 1));

          TimerType data = TimerType(
              value: "00:00:00",
              color: Colors.red,
              status: TimerTypeStatus.UPCOMING);

          /// -- End Bid on 12:00 AM --
          if (firstBid != null) {
            //-> True (Biding is started and False (No anyone bid on yet))
            // if (DateTime.parse(firstBid.toString().split(" ").first)
            //         .difference(DateTime.parse(
            //             DateTime.now().toString().split(" ").first))
            //         .inSeconds <=
            //     0) {
            //   data = TimerType(
            //       value: "00:00:00",
            //       color: Colors.red,
            //       status: TimerTypeStatus.END);
            //   _running = false;
            // }
            if (endTime!.difference(DateTime.now()).inSeconds <= 0) {
              _bidOver();
              data = TimerType(
                  value: "00:00:00",
                  color: Colors.red,
                  status: TimerTypeStatus.END);
              _running = false;
            }
            // --------------------------
            else {
              // Runing timer
              DateTime targetDT = endTime!;
              DateTime today = DateTime.now();

              Duration liveTime = targetDT.difference(today);
              int x = liveTime.inSeconds;

              if (x > 0) {
                data = TimerType(
                    value: reminderTime(liveTime),
                    color: Colors.red,
                    status: TimerTypeStatus.GOINGON);
              } else {
                _bidOver();
                data = TimerType(
                    value: "00:00:00",
                    color: Colors.red,
                    status: TimerTypeStatus.END);
                _running = false;
              }
            }
          } else {
            // Left time to start biding
            DateTime targetDT = endTime!.subtract(const Duration(minutes: 5));
            DateTime today = DateTime.now();
            Duration liveTime = targetDT.difference(today);
            if (liveTime.inSeconds > 0) {
              int x = liveTime.inSeconds;
              if (x > 0) {
                data = TimerType(
                    value: reminderTime(liveTime),
                    color: Colors.blue,
                    status: TimerTypeStatus.GOINGON);
              } else {
                data = TimerType(
                    value: "00:00:00",
                    color: Colors.purple,
                    status: TimerTypeStatus.GOINGON);
                _running = false;
              }
            } else {
              // No bid yet
              data = TimerType(
                  value: "00:00:00",
                  color: Colors.green,
                  status: TimerTypeStatus.GOINGON_NO_BID_YET);
            }
          }

          if (onChanged != null) {
            onChanged!(data);
          }
          yield data;
        }
      } else if (defInDays > 0) {
        TimerType data = TimerType(
            value: "$defInDays ${defInDays == 1 ? 'day' : 'days'}",
            color: Colors.green,
            status: TimerTypeStatus.UPCOMING);
        yield data;
      } else {
        _bidOver();
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
          if (snapshot.connectionState == ConnectionState.waiting ||
              endTime == null) {
            return textType
                ? ShimmerWidgets.text(
                    w: 60, h: 12, color: AppColor.themeColor.withOpacity(0.5))
                : timerWidget(
                    timeChild: ShimmerWidgets.text(
                        w: 80,
                        h: 16,
                        color: AppColor.themeColor.withOpacity(0.5)));
          }
          // print(
          //     "Timer Start to --> djfksdfsfslfskldfjdsjfdsjf ${snapshot.data?.value ?? '00:klfkj:00'}");
          return textType
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
