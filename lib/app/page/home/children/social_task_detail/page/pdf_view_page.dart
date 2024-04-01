import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/controller/social_task_detail_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';

class PdfViewerPage extends StatefulWidget {
  final String localPath1;

  const PdfViewerPage({super.key, required this.localPath1});
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final SocialTaskDetailController socialTaskDetailController = Get.find();
  String localPath = '';

  @override
  void initState() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDF Viewer",
        ),
      ),
      
    );
  }
}
