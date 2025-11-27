import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String filePath;
  final String fileName;

  const PdfPreviewScreen({
    super.key,
    required this.filePath,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "PDF Preview",
        subtitle: fileName,
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
      ),

      body: SfPdfViewer.file(File(filePath)),
    );
  }
}
