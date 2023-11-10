import 'package:appquangbadulich/updateImage/widgets/updateImage_widget.dart';
import 'package:flutter/material.dart';

class UpdateImagePage extends StatefulWidget {
  const UpdateImagePage({super.key});

  @override
  State<UpdateImagePage> createState() => _UpdateImagePageState();
}

class _UpdateImagePageState extends State<UpdateImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Cập nhật hình ảnh',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.black,
        ),
      ),
      body: UpdateImageWidget(),
    );
  }
}
