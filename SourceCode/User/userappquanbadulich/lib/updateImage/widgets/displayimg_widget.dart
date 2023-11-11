import 'dart:io';

import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final String? imagePaths;

  const DisplayWidget({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách hình ảnh'),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: _buildImageOrText(),
      ),
    );
  }

  Widget _buildImageOrText() {
    if (imagePaths != null && File(imagePaths!).existsSync()) {
      return Image.file(
        File(imagePaths!),
        fit: BoxFit.cover,
      );
    } else {
      return const Center(
        child: Text(
          'Không tìm thấy đường dẫn',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }
}
