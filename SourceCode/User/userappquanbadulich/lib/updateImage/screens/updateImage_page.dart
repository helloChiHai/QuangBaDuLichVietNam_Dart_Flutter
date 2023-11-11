import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/updateImage_bloc.dart';
import '../bloc/updateImage_state.dart';
import '../widgets/updateImage_widget.dart';

class UpdateImagePage extends StatefulWidget {
  const UpdateImagePage({super.key});

  @override
  State<UpdateImagePage> createState() => _UpdateImagePageState();
}

class _UpdateImagePageState extends State<UpdateImagePage> {
  late String customerId;
  bool isDialogShown = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    customerId = args['customerId'] as String;
  }

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
      body: BlocListener<UpdateImageBloc, UpdateImageState>(
        listener: (context, state) {
          if (state is UpdateImageSuccess && !isDialogShown) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật hình ảnh thành công!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Cập nhật hình ảnh thành công! Vui lòng đăng nhập lại để hoàn tất việc cập nhật',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is UpdateImageFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật hình ảnh không thành công!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: UpdateImageWidget(customerId: customerId),
      ),
    );
  }
}
