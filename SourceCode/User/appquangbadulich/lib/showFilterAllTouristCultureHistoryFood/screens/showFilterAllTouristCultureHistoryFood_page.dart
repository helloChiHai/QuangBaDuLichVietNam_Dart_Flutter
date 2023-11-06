import 'package:flutter/material.dart';

class ShowFilterAllTouristCultureHistoryFoodPage extends StatefulWidget {
  const ShowFilterAllTouristCultureHistoryFoodPage({super.key});

  @override
  State<ShowFilterAllTouristCultureHistoryFoodPage> createState() =>
      _ShowFilterAllTouristCultureHistoryFoodPageState();
}

class _ShowFilterAllTouristCultureHistoryFoodPageState
    extends State<ShowFilterAllTouristCultureHistoryFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Bạn muốn tìm chổ nào',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModalBottomSheet(context);
        },
        child:  Icon(Icons.add), 
        backgroundColor: Colors.blue, // Thay đổi màu nút
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Đặt vị trí cho nút
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: 100,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(16),
          child: Text('Nội dung của Bottom Sheet'),
        );
      },
    );
  }
}
