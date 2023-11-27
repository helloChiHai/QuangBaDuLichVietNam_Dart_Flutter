import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/comment/screens/comment_page.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_content.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_culture.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_history.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_specialtyDish.dart';
import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:flutter/material.dart';

class UpdateTouristAttractionWidget extends StatefulWidget {
  final TouristAttractionModel tourist;

  const UpdateTouristAttractionWidget({
    Key? key,
    required this.tourist,
  }) : super(key: key);

  @override
  State<UpdateTouristAttractionWidget> createState() =>
      _UpdateTouristAttractionWidgetState();
}

class _UpdateTouristAttractionWidgetState
    extends State<UpdateTouristAttractionWidget> {
  late TouristAttractionModel tourist;
  PageController pageController = PageController();
  int pageViewInit = 0;
  TextEditingController nameTouristController = TextEditingController();
  bool hasChangednameTouristController = false;

  @override
  void initState() {
    super.initState();
    tourist = widget.tourist;
    pageController = PageController(initialPage: pageViewInit);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return Image.memory(
          Uint8List.fromList(imageBytes),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return Image.asset(
          'assets/img/${img}',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      }
    } else {
      return Image.asset(
        'assets/img/img_12.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentTouristName = tourist.nameTourist;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 310,
                color: const Color.fromARGB(255, 173, 207, 235),
                child: Stack(
                  children: [
                    FutureBuilder<Widget>(
                      future: _buildImage(tourist.imgTourist),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return snapshot.data ?? Container();
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 31),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/homeAdmin');
                              },
                              icon: const Icon(Icons.arrow_back, size: 30),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print(currentTouristName);
                              print(nameTouristController.text);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Row(
                                children: [
                                  Text(
                                    'Cập nhật',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.check_circle_outline, size: 30),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 290),
                padding: const EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                height: 3000,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: nameTouristController,
                            decoration: InputDecoration(
                              hintText: currentTouristName,
                              hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (newValue) {
                              if (newValue != currentTouristName) {
                                nameTouristController.text = newValue;
                              } else if(newValue == nameTouristController.text){
                                nameTouristController.text = currentTouristName;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.place_outlined, size: 25),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    tourist.address,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.monetization_on_outlined,
                                    size: 25),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    'Giá vé: ${tourist.ticket}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    size: 25),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    'Thời điểm thích hợp: ${tourist.rightTime.join(', ')}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      color: Colors.white,
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Giới thiệu',
                                  style: TextStyle(
                                    color: pageViewInit == 0
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 0 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Văn hóa',
                                  style: TextStyle(
                                    color: pageViewInit == 1
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 1 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Lịch sử',
                                  style: TextStyle(
                                    color: pageViewInit == 2
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 2 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    3,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Đặc sản',
                                  style: TextStyle(
                                    color: pageViewInit == 3
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 3 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    4,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Bình luận',
                                  style: TextStyle(
                                    color: pageViewInit == 4
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 4 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            pageViewInit = index;
                          });
                        },
                        children: [
                          DetailContent(
                            dataIntroTourist: tourist.touristIntroduction,
                          ),
                          DetailCulture(dataCulture: tourist.culture),
                          DetailHistory(dataHistory: tourist.history),
                          DetailSpecialtyDish(
                              dataSpecialtyDish: tourist.specialtyDish),
                          CommentPage(idTourist: tourist.idTourist),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
