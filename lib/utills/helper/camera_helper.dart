import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class CameraOnCompleteListener {
  void onSuccessFile(File file, String fileType);
}

class CameraHelper {
  final picker = ImagePicker();
  BuildContext context = Get.context!;
  CropAspectRatioPreset? cropAspectRatioPreset;
  late CameraOnCompleteListener callback;

  CameraHelper(this.callback);

  void setCropping(CropAspectRatioPreset cropAspectRatioPreset) {
    this.cropAspectRatioPreset = cropAspectRatioPreset;
  }

  void openAttachmentDialog() async {
    if (await isStorageEnabled()) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'docx',
          'xlsx',
          'pptx',
          'doc',
          'xls',
          'ppt',
          'txt'
        ],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        debugPrint(file.path);
        callback.onSuccessFile(file, "document");
      } else {
        // User canceled the picker
      }
    }
  }

  //for picking image from camera and gallery
  void openImagePicker() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) => GestureDetector(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          decoration: const BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Colors.pinkAccent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x194A841C),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 19,
                                ),
                              ]),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Camera",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ],
                    ),
                    onTap: () async {
                      if (await isCameraEnabled()) {
                        Navigator.pop(context);
                        cropAspectRatioPreset != null
                            ? getImageWithCropping(ImageSource.camera)
                            : getImageWithoutCropping(ImageSource.camera);
                      }
                    },
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              color: Color(0xff6BBBAE),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x194A841C),
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 19,
                                ),
                              ]),
                          child: const Icon(
                            Icons.image_rounded,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ],
                    ),
                    onTap: () async {
                      if (await isStorageEnabled()) {
                        Navigator.pop(context);
                        cropAspectRatioPreset != null
                            ? getImageWithCropping(ImageSource.gallery)
                            : getImageWithoutCropping(ImageSource.gallery);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusScopeNode());
        },
      ),
    );
  }

  void openImagePickerNew() {
    showAdaptiveActionSheet(
      context: context,
      title: const Text("Choose Image"),
      isDismissible: true,
      actions: [
        BottomSheetAction(
            title: const Text(
              'Camera',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400),
            ),
            onPressed: (context) async {
              if (await isCameraEnabled()) {
                Navigator.pop(context);
                cropAspectRatioPreset != null
                    ? getImageWithCropping(ImageSource.camera)
                    : getImageWithoutCropping(ImageSource.camera);
              }
            }),
        BottomSheetAction(
          title: const Text(
            'Gallery',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400),
          ),
          onPressed: (context) async {
            if (await isStorageEnabled()) {
              Navigator.pop(context);
              cropAspectRatioPreset != null
                  ? getImageWithCropping(ImageSource.gallery)
                  : getImageWithoutCropping(ImageSource.gallery);
            }
          },
        ),
      ],
      cancelAction: CancelAction(
          title: const Text(
            'Cancel',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400),
          ),
          onPressed: (BuildContext context) {
            Get.back();
          }),
    );
  }
  // void openImagePickerNew2() {
  //   showModalActionSheet<String>(
  //     context: context,
  //
  //     title: 'Title',
  //     message: 'Message',
  //    builder: (BuildContext context,child){
  //      return  GestureDetector(
  //        child:Container(
  //          child: Column(
  //            children: [
  //              Text("Camera"),
  //              Text("Gallery"),
  //            ],
  //          ),
  //        ),
  //        onTap: () {
  //          FocusScope.of(context).requestFocus(FocusScopeNode());
  //        },
  //      );
  //    },
  //
  //     cancelLabel: "Cancel"
  //   );
  // }

  Future getImageWithCropping(ImageSource imageSource) async {
    XFile? imageFile = await picker.pickImage(source: imageSource);
    CroppedFile? croppedFile;
    if (imageFile != null) {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          cropAspectRatioPreset!,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.cyan,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ],
      );
    }
    if (croppedFile != null) {
      callback.onSuccessFile(File(croppedFile.path), "image");
    } else {
      print('No image selected.');
    }
  }

  Future getImageWithoutCropping(ImageSource imageSource) async {
    XFile? imageFile = await picker.pickImage(source: imageSource);
    if (imageFile != null) {
      callback.onSuccessFile(File(imageFile.path), "image");
    } else {
      print('No image selected.');
    }
  }

  Future<bool> isCameraEnabled() async {
    return true;
  }

  Future<bool> isStorageEnabled() async {
    return true;
  }
}
