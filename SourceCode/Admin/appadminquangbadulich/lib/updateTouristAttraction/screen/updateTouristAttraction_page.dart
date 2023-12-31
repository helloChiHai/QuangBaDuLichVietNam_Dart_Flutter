import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';
import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:appadminquangbadulich/updateTouristAttraction/screen/updateTouristAttraction_widget.dart';
import 'package:flutter/material.dart';

class UpdateTouristAttrractionpage extends StatefulWidget {
  const UpdateTouristAttrractionpage({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateTouristAttrractionpage> createState() =>
      _UpdateTouristAttrractionpageState();
}

class _UpdateTouristAttrractionpageState
    extends State<UpdateTouristAttrractionpage> {
  late TouristAttractionModel tourist;
  PageController pageController = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    tourist = arguments['aboutTouristData'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 173, 213, 245),
        title: Text(
          'Cập nhật ${tourist.nameTourist}',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailTouristAttraction_AboutPage(
                  idTourist: tourist.idTourist),
            ));
          },
        ),
      ),
      body: UpdateTouristAttractionWidget(
        tourist: tourist,
      ),
    );
  }
}
