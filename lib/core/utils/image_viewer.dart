import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class AppImageViewer {
  static void show({
    required BuildContext context,
    required String imageUrl,
    bool isLocalFile = false,
    bool swipeDismissible = true,
    bool doubleTapZoomable = true,
    BoxFit fit = BoxFit.contain,
  }) {
    final imageProvider = isLocalFile
        ? FileImage(File(imageUrl))
        : NetworkImage(imageUrl) as ImageProvider;

    showImageViewer(
      context,
      imageProvider,
      swipeDismissible: swipeDismissible,
      doubleTapZoomable: doubleTapZoomable,
    );
  }
}
