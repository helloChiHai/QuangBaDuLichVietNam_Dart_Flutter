import 'dart:io';

import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final List<String> imagePaths;

  const DisplayWidget({Key? key, required this.imagePaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách hình ảnh'),
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: Image.file(
              File(imagePaths[index]),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
