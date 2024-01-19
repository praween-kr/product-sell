import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/product/sell_item_controller.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_text.dart' as apptext;
import 'package:oninto_flutter/utils/color_constant.dart' as appcolor;
import 'package:oninto_flutter/utils/helper/file_picker.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart' as appdialog;

class SellItemScreenAction {
  SellItemScreenAction(this._controller);
  final SellItemController _controller;

  //
  addAndRemoveAttachment(int position, {required}) {
    Get.bottomSheet(ClipRRect(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () {
                Get.back();
                addAttachment(position);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Change",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )),
                    Icon(Icons.change_circle),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                if (_controller.multipleImages[position].isNetwork) {
                  _controller.oldImagesIdList
                      .add(_controller.multipleImages[position].id.toString());
                }
                _controller.multipleImages.removeAt(position);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Remove",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )),
                    Icon(Icons.close),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ));
  }

  addAttachment(int position) {
    if (position < _controller.multipleImages.length) {
      _controller.selectedImageForUpdate.value = position;
    }
    AppPicker().image((path, type, thumb) {
      String typeKey = "0";
      if (type == AttachmentPicker.IMG) {
        typeKey = "0";
      } else if (type == AttachmentPicker.VIDEO) {
        typeKey = "2";
      } else {
        typeKey = "1";
      }
      if (path != null) {
        if (_controller.selectedImageForUpdate.value == position) {
          if (_controller.multipleImages[position].isNetwork) {
            _controller.oldImagesIdList
                .add(_controller.multipleImages[position].id.toString());
          }
          AppPrint.all(
              "controller.oldImagesIdList: ${_controller.oldImagesIdList}");
          //
          _controller.multipleImages.replaceRange(position, position + 1,
              [AttachmentModel(path: path, type: typeKey, thumb: thumb)]);
        } else {
          _controller.multipleImages
              .add(AttachmentModel(path: path, type: typeKey, thumb: thumb));
        }
        _controller.singleImage.value = typeKey == '2' ? thumb ?? '' : path;
        _controller.singleImageType.value = typeKey;
        _controller.multipleImages.refresh();
      }
    });
  }

  addMoreAttachments() {
    AppPicker().image((path, type, thumb) {
      String typeKey = "0";
      if (type == AttachmentPicker.IMG) {
        typeKey = "0";
      } else if (type == AttachmentPicker.VIDEO) {
        typeKey = "2";
      } else {
        typeKey = "1";
      }
      if (path != null) {
        _controller.multipleImages
            .add(AttachmentModel(path: path, type: typeKey, thumb: thumb));
        _controller.multipleImages.refresh();
        _controller.singleImage.value = typeKey == '2' ? thumb ?? '' : path;
        _controller.singleImageType.value = typeKey;
      }
    });
  }

  selectProductSizeDialog() {
    appdialog.AppDialogs.simple(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: apptext.AppText(
              text: "Select Product Sizes",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Obx(
              () => Wrap(
                children: List.generate(
                  _controller.sizeItems.length,
                  (index) => index == 0
                      ? const SizedBox.shrink()
                      : productSizeCard(
                          color: Colors.grey.shade200,
                          title: _controller.sizeItems.keys.toList()[index],
                          isSelected: _controller.pickedSizes.keys
                              .toList()
                              .contains(
                                  _controller.sizeItems.keys.toList()[index]),
                          onClick: () {
                            //---
                            if (_controller.pickedSizes.keys.toList().contains(
                                _controller.sizeItems.keys.toList()[index])) {
                              _controller.pickedSizes.remove(
                                  _controller.sizeItems.keys.toList()[index]);
                              // Remove from db
                              int? id = _controller.pickedSizes[
                                  _controller.pickedSizes.keys.toList()[index]];
                              if (id != null &&
                                  !_controller.removeSizes.contains(id)) {
                                _controller.removeSizes.add(id);
                              }
                            } else {
                              String key =
                                  _controller.sizeItems.keys.toList()[index];
                              _controller.pickedSizes.addAll({key: null});
                              // Not remove from db
                              int? id = _controller.pickedSizes[
                                  _controller.pickedSizes.keys.toList()[index]];
                              if (id != null &&
                                  _controller.removeSizes.contains(id)) {
                                _controller.removeSizes.remove(id);
                              }
                            }
                            _controller.pickedSizes.refresh();
                          }),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topRight,
            child: productSizeCard(
              color: Colors.grey.shade200,
              title: "Done",
              isSelected: true,
              onClick: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget productSizeCard(
      {required String title,
      bool isSelected = false,
      Color? color,
      required Function onClick,
      Function? remove}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        margin: const EdgeInsets.only(right: 8, top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color:
              isSelected ? appcolor.AppColor.appColor : color ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            apptext.AppText(
              text: title,
              textAlign: TextAlign.center,
              color: isSelected ? appcolor.AppColor.white : null,
            ),
            remove == null ? const SizedBox.shrink() : const SizedBox(width: 8),
            remove == null
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () => remove(),
                    child: Icon(Icons.cancel, color: Colors.grey.shade500))
          ],
        ),
      ),
    );
  }
}
