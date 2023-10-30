import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void openSettingsForPermission(
    {required String typeText, required String purposeText}) {
  Get.bottomSheet(
    Wrap(
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: Get.width * 0.15, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(1.0),
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              children: [
                const Text("Permission",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue)),
                const SizedBox(height: 8),
                Text(
                  "To $purposeText, allow Jobbie access to your $typeText.\nTap Settings > Permissions, and turn $typeText on.",
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        child: const Center(
                            child: Text(
                          "Not now",
                          style: TextStyle(color: Colors.blue),
                        )),
                      ),
                    ),
                    // const SizedBox(width: 14),
                    InkWell(
                      onTap: () async {
                        Get.back();
                        await openAppSettings();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        child: const Center(
                            child: Text(
                          "Settings",
                          style: TextStyle(color: Colors.blue),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
    // backgroundColor: Colors.black.withOpacity(0.3)
  );
}
