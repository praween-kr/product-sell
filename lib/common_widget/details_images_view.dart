import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/image_view.dart';

class DetailsImagesView extends StatefulWidget {
  const DetailsImagesView({super.key, required this.images});
  final List<String> images;

  @override
  State<DetailsImagesView> createState() => _DetailsImagesViewState();
}

class _DetailsImagesViewState extends State<DetailsImagesView> {
  String seletedImage = '';
  @override
  void initState() {
    super.initState();
    if (widget.images.isNotEmpty) {
      setState(() {
        seletedImage = widget.images.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      child: Stack(children: [
        SizedBox(
            height: Get.height * 0.42,
            child: AppImage.view("${ImageBaseUrls.product}$seletedImage",
                fit: BoxFit.cover, width: double.infinity)),
        Positioned(
            left: 10,
            bottom: 10,
            child: SizedBox(
              width: Get.width * 1.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: widget.images
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
                                    child: AppImage.view(
                                      "${ImageBaseUrls.product}$e",
                                      fit: BoxFit.cover,
                                      height: 75,
                                      width: 80,
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
