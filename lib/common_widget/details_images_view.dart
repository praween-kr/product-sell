import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utills/image_view.dart';

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
    // TODO: implement initState
    super.initState();
    if (widget.images.isNotEmpty) {
      setState(() {
        seletedImage = widget.images.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("dd: $seletedImage");

    return Container(
      color: Colors.grey.shade300,
      child: Stack(children: [
        // AppImage.view(""),
        SizedBox(
            height: Get.height * 0.35,
            child: AppImage.view("${ImageBaseUrls.product}$seletedImage",
                fit: BoxFit.cover, width: double.infinity)
            // Image.asset(
            //   Assets.assetsParker,
            //   fit: BoxFit.cover,
            // )
            ),
        Positioned(
            left: 20,
            bottom: 10,
            // top: MediaQuery.of(context).size.height * 0.25,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: seletedImage == e
                                        ? Colors.green
                                        : Colors.grey,
                                    width: 3),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
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
                    .toList()
                // [
                //   Image.asset(
                //     Assets.assetsGyrados,
                //     height: 80,
                //     width: 80,
                //   ),
                //   const SizedBox(
                //     width: 10,
                //   ),
                //   Image.asset(
                //     Assets.assetsGyrados1,
                //     height: 80,
                //     width: 80,
                //   ),
                //   const SizedBox(
                //     width: 10,
                //   ),
                //   Stack(children: [
                //     Image.asset(
                //       Assets.assetsPokemon,
                //       height: 80,
                //       width: 80,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(20),
                //       child: Image.asset(
                //         Assets.assetsVideo,
                //         height: 40,
                //         width: 40,
                //       ),
                //     ),
                //   ]),
                // ],
                )),
      ]),
    );
  }
}
