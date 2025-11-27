import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String filePath;
  final String fileName;

  const ImagePreviewScreen({
    super.key,
    required this.filePath,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "Image Preview",
        subtitle: fileName,
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showImageViewer(
              context,
              Image.file(File(filePath)).image,
              swipeDismissible: true,
              doubleTapZoomable: true,
            );
          },
          child: Hero(
            tag: "preview-image",
            child: Image.file(File(filePath), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
