import 'package:appquangbadulich/home/screens/detailTourist_comment.dart';
import 'package:appquangbadulich/home/screens/detailTourist_content.dart';
import 'package:flutter/material.dart';

class DetailTouristAttraction extends StatefulWidget {
  const DetailTouristAttraction({super.key});

  @override
  State<DetailTouristAttraction> createState() =>
      _DetailTouristAttractionState();
}

class _DetailTouristAttractionState extends State<DetailTouristAttraction> {
  PageController pageController = PageController();
  int currentIndex = 0;
  bool isCheckFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 310,
                  color: Colors.red,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/img/img_8.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/home');
                              },
                              icon: const Icon(Icons.arrow_back, size: 35),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isCheckFavourite = !isCheckFavourite;
                                });
                              },
                              icon: Icon(
                                isCheckFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 35,
                                color: isCheckFavourite ? Colors.red : null,
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
                  height: 1900,
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
                            const Text(
                              'Hồ Gươm',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.place_outlined, size: 25),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      'Địa chỉ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.monetization_on_outlined,
                                      size: 25),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      'Giá vé: miến phí',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: double.infinity,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.calendar_month_outlined, size: 25),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      'Thời điểm thích hợp: tháng 1,2,3,4,6,7,8,9,0,10-',
                                      style: TextStyle(
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
                        child: Row(
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
                                  color: currentIndex == 0
                                      ? Colors.black
                                      : const Color.fromARGB(255, 77, 76, 76),
                                  fontSize: currentIndex == 0 ? 25 : 20,
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
                                'Bình luận',
                                style: TextStyle(
                                  color: currentIndex == 1
                                      ? Colors.black
                                      : const Color.fromARGB(255, 77, 76, 76),
                                  fontSize: currentIndex == 1 ? 25 : 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          children: [
                            DetailContent(),
                            CommentTourist(),
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
      ),
    );
  }
}
