import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oninto_flutter/utills/app_print.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum AttachmentPicker {
  IMG_GALLERY,
  IMG_CAMERA,
  IMG_GALLERY_MULTIPLE,
  IMG_VIDEO_MULTIPLE,
  IMG_VIDEO,
  VIDEO_CAMERA,
  VIDEO_GALLERY,
  FILE
}

class AppPicker {
  image(Function(String?, AttachmentPicker?, String?) onChanged) {
    Get.bottomSheet(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14), topRight: Radius.circular(14)),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              listTile(
                  onClick: () async {
                    Get.back();
                    onChanged(await (picker(AttachmentPicker.IMG_GALLERY)),
                        AttachmentPicker.IMG_GALLERY, null);
                  },
                  title: "Gallery",
                  icon: Icons.photo),
              listTile(
                  onClick: () async {
                    Get.back();
                    onChanged(await (picker(AttachmentPicker.IMG_CAMERA)),
                        AttachmentPicker.IMG_GALLERY, null);
                  },
                  title: "Camera",
                  icon: Icons.camera_alt_rounded),
              listTile(
                  onClick: () async {
                    Get.back();
                    onChanged(await (picker(AttachmentPicker.FILE)),
                        AttachmentPicker.FILE, null);
                  },
                  title: "File",
                  icon: Icons.camera_alt_rounded),
              listTile(
                  onClick: () async {
                    Get.back();
                    var path = await (picker(AttachmentPicker.VIDEO_GALLERY));
                    final fileName = await VideoThumbnail.thumbnailFile(
                        video: path,
                        thumbnailPath: (await getTemporaryDirectory()).path,
                        imageFormat: ImageFormat.WEBP,
                        maxHeight: 64,
                        quality: 75);
                    AppPrint.all(fileName.toString());
                    onChanged(path, AttachmentPicker.VIDEO_GALLERY, fileName);
                  },
                  title: "Video",
                  icon: Icons.camera_alt_rounded),
              //
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  alignment: Alignment.center,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    ));
  }

  Widget listTile({String? title, required Function onClick, IconData? icon}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClick(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "Title",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600),
              ),
              icon == null
                  ? const SizedBox.shrink()
                  : Icon(icon, color: themeColor),
            ],
          ),
        ),
      ),
    );
  }

  picker(AttachmentPicker type) async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    if (type == AttachmentPicker.IMG_GALLERY) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // _pick();
        String? path = await imgCropping(image.path);
        return path;
      } else {
        return null;
      }
    }

// Capture a photo.
    if (type == AttachmentPicker.IMG_CAMERA) {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        return imgCropping(photo.path);
      }
    }
// Pick a video.
    if (type == AttachmentPicker.VIDEO_GALLERY) {
      final XFile? galleryVideo =
          await picker.pickVideo(source: ImageSource.gallery);
      if (galleryVideo != null) {
        return galleryVideo.path;
      }
    }

// Capture a video.
    if (type == AttachmentPicker.VIDEO_CAMERA) {
      final XFile? cameraVideo =
          await picker.pickVideo(source: ImageSource.camera);
      if (cameraVideo != null) {
        return cameraVideo.path;
      }
    }

// Pick multiple images.
    if (type == AttachmentPicker.IMG_GALLERY_MULTIPLE) {
      final List<XFile> images = await picker.pickMultiImage();
      return images.map((e) => e.path).toList();
    }

// Pick singe image or video.
    if (type == AttachmentPicker.IMG_VIDEO) {
      final XFile? media = await picker.pickMedia();
      if (media != null) {
        return media.path;
      }
    }

// Pick multiple images and videos.
    if (type == AttachmentPicker.IMG_VIDEO_MULTIPLE) {
      final List<XFile> medias = await picker.pickMultipleMedia();
      return medias.map((e) => e.path).toList();
    }

    // File
    if (type == AttachmentPicker.FILE) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowedExtensions: [
            'pdf',
            'docx',
            'xlsx',
            'pptx',
            'doc',
            'xls',
            'ppt'
          ]);

      if (result != null) {
        return result.files.single.path;
      }
    }
  }

  ///-----------Cropping-------------
  Future<String?> imgCropping(String path) async {
    CroppedFile? croppedFile;
    croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9
      // ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: themeColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
    );
    if (croppedFile != null) {
      return croppedFile.path;
    } else {
      print('No image selected.');
    }
    return null;
  }
}
