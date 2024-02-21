import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/video/app_video_play.dart';

class DetailsImagesView extends StatefulWidget {
  const DetailsImagesView({super.key, required this.items});
  final List<ImgVideoData> items;

  @override
  State<DetailsImagesView> createState() => _DetailsImagesViewState();
}

class _DetailsImagesViewState extends State<DetailsImagesView> {
  ImgVideoData? seletedImage;
  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      setState(() {
        seletedImage = widget.items.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            if (seletedImage?.type == IVType.video) {
              Get.to(() => AppVideoPlayer(
                  video:
                      "${ImageBaseUrls.product}${seletedImage?.video ?? ''}"));
            }
          },
          child: SizedBox(
            height: Get.height * 0.42,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AppImage.view(
                  "${ImageBaseUrls.product}${seletedImage?.type == IVType.image ? seletedImage?.image : seletedImage?.thumb}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: Get.height * 0.42,
                ),
                seletedImage?.type == IVType.video
                    ? const Positioned(
                        child: Icon(
                          Icons.play_circle_outlined,
                          color: AppColor.white,
                          size: 46,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
        Positioned(
            left: 10,
            bottom: 10,
            child: SizedBox(
              width: Get.width * 1.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: widget.items
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    seletedImage = e;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: seletedImage == e
                                            ? Colors.green
                                            : Colors.grey,
                                        width: 1.5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AppImage.view(
                                          "${ImageBaseUrls.product}${e.type == IVType.image ? e.image : e.thumb}",
                                          fit: BoxFit.cover,
                                          height: 75,
                                          width: 80,
                                        ),
                                        e.type == IVType.video
                                            ? const Positioned(
                                                child: Icon(
                                                  Icons.play_circle_outlined,
                                                  color: AppColor.white,
                                                  size: 32,
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
              ),
            )),
      ]),
    );
  }
}

enum IVType { image, video }

class ImgVideoData {
  IVType type;
  String? image;
  String? video;
  String? thumb;
  ImgVideoData({this.image, this.video, this.thumb, this.type = IVType.image});
}
